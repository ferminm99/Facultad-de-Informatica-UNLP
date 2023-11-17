#!/bin/bash
FILE="comunicacionesJava.csv"

start_client() {

    echo "Cargando nuevo tiempo de comunicacion en el puerto $1"

	time=$(java Client localhost $1)

    #AGREGA el tiempo de comunicacion en el csv o lo crea si no existe
	echo "$time" >> $FILE
}

main() {
	javac Client Client.java
	javac Server Server.java

	port=3000

	for (( i = 0; i < 100; i++ )); do

        #Cambia al siguiente puerto para que no haya problemas con las comunicaciones 
        #y se guarda como variable para poderse usar como $1
		port=$(($port + 1))	

        #se fija si el puerto se encuentra trabajando, si no aparece es que se encuentra libre
		free_port=$(ss -tan | grep ":$port")	

		if [ "$free_port" == "" ]
		then
			java Server $port | start_client $port
		fi

	done

}

main

exit 0

