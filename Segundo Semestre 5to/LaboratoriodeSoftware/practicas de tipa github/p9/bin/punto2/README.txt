2) 
	a) Me da la sensacion que bloquea la consola para que solo 1 hilo la pueda usar a la vez.
	Se bloquea el objeto "System.out" (Osea la consola) durante la ejecucion del for, asi cuando
	un hilo logra obtenerla entonces puede imprimir toda la frase de seguido sin ser interrumpido
	por otro hilo.
	Estube averiguando online y de hecho hace eso, notar que es distinto a bloquear el metodo, ya
	que el lock de los metodos parece ser compartido entre todos los de un mismo objeto.
	
	b) Hay 2 tipos de sincronizacion, de metodos y de bloque. La sincronizacion de bloque siempre 
	esta enlazada a un recurso concreto, y en este caso se usa respecto a "System.out", de forma 
	que es imposible ejecutar el bloque respectivo mientras otro hilo tiene bloqueado "System.out".
	NOTA: Mas info respecto a los tipos de sincronizacion aqui: 
		https://javadesdecero.es/avanzado/sincronizacion-de-hilos/
	Notar que con bloques se pueden realizar sincronizaciones entre distintos procesos.