#!/bin/bash

OUTPUT="../outputs/ejercicio-6a-test.csv"
TIMES=100

# Inicia el entorno
./entorno.sh -start

# Se limpia el output
echo "Time in ns" > $OUTPUT

for (( i = 0; i < $TIMES; i++ )); do
	java -cp "../ejercicios" AskRemote -ejercicio6a 1>> $OUTPUT
	echo "Tiempo de la ejecución $i finalizado"
done

# Finaliza el entorno
./entorno.sh -stop