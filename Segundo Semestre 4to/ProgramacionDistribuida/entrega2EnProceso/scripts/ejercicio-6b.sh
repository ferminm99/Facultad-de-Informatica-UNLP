#!/bin/bash

./entorno.sh -start

java -cp "../ejercicios"  -Dsun.rmi.transport.tcp.responseTimeout=5000 AskRemote -ejercicio6b

./entorno.sh -stop