#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "No se ingreso el parametro del archivo a copiar"
	exit 1
fi

# Inicia el entorno
./entorno.sh -start

# Ubicacion de los archivos
ARCHIVO_ORIGINAL="../ejercicios/archivos/server/originales/$1"
COPIA_CLIENTE="../ejercicios/archivos/client/copias/$1"
COPIA_SERVIDOR="../ejercicios/archivos/server/copias/$1"

# Inicia el cliente
echo "Iniciando cliente"
java -cp "../ejercicios" AskRemote -ejercicio4 $ARCHIVO_ORIGINAL $COPIA_CLIENTE $COPIA_SERVIDOR

# Se testea que el contenido de los 3 archivos no difiera
echo "Comparacion entre los archivos: $ARCHIVO_ORIGINAL $COPIA_CLIENTE $COPIA_SERVIDOR"

diff1=$(diff $ARCHIVO_ORIGINAL $COPIA_CLIENTE)
diff2=$(diff $COPIA_CLIENTE $COPIA_SERVIDOR)

if [[ $diff1 || $diff2 ]]; then
	echo "Los archivos no coinciden :("
	echo "$diff1"
	echo "$diff2"
else
	echo "Se crearon los archivos copias sin problemas!!"
fi

# Cierra el entorno
./entorno.sh -stop


exit 0
