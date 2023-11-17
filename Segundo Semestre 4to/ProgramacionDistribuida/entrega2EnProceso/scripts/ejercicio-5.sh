#!/bin/bash

TIMES=100
OUTPUT="../outputs/ejercicio-4-test"

ARCHIVO_SERVER="../ejercicios/archivos/server/experimentos/experimento.txt"
ARCHIVO_CLIENTE1="../ejercicios/archivos/client/experimentos/experimento1.txt"
ARCHIVO_CLIENTE2="../ejercicios/archivos/client/experimentos/experimento2.txt"

# Inicia el entorno
./entorno.sh -start

echo "Experimento iniciado"

# Se limpia el archivo de output
cat /dev/null > $OUTPUT

# Se generan los 10 experimentos
for (( i = 0; i < $TIMES; i++ )); do
	# Ejecutamos los 2 clientes
	java -cp "../ejercicios" AskRemote -ejercicio5 $ARCHIVO_CLIENTE1 $ARCHIVO_SERVER &
	CLIENT_1_PID=$!
	java -cp "../ejercicios" AskRemote -ejercicio5 $ARCHIVO_CLIENTE2 $ARCHIVO_SERVER &
	CLIENT_2_PID=$!

	# Esperamos la ejecución de los 2 clientes
	wait $CLIENT_1_PID
	wait $CLIENT_2_PID

	# Informamos el resultado
	echo "------------------" >> $OUTPUT
	echo "Ejecución $i: " >> $OUTPUT
	echo $(cat $ARCHIVO_SERVER) >> $OUTPUT
done

echo "Experimento finalizado, ver output en: $OUTPUT"

# Finaliza el entorno
./entorno.sh -stop