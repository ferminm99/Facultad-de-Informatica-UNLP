#!/bin/bash

killall rmiregistry

if [[ $# -ne 1 ]]; then
	echo "Se necesitan los parámetros: operacion"
fi

# Si el "parametro" que recibe primero es -start hace lo siguiente
if [[ $1 == "-start" ]]; then

	cd ../ejercicios

	echo "Abriendo puerto RMI en el directorio ejercicios"
	rmiregistry &

	# Compila todos los archivos que tengan .java
	javac *java

	echo "Iniciando objeto remoto"

	java StartRemoteObject > /dev/null &
	
	cd ../scripts

	# Espera a que el objeto remoto sea iniciado
	#se fija el time wait del rmiregistry, el wc -l -ge 3 ni idea KJJJ
	until [ $(ss -ta | grep -v TIME-WAIT | grep ":rmiregistry" | wc -l) -ge 3 ]; do
		echo "Esperando objeto remoto"
		sleep 1
	done

elif [[ $1 == "-stop" ]]; then
	killall rmiregistry
	killall java
	
else
	echo "Operacion inválida."
	exit 1
fi;

exit 0
