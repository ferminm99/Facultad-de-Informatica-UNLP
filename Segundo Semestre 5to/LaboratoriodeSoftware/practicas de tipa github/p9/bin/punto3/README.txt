3) 
	a) Listo.
	
	b) Podria intentar usarce interruptedExeption para el tema de disparar una 
	exepcion, pero con Runnable no es posible devolver un valor de la forma tipica
	que se hace con las funciones, ya que run() siempre devuelve tipo void.
	Como alternativa que intenta solucionar este problema aparece la interfaz
	Callable. La interfaz nos obliga a definir un metodo call() el cual devuelve 
	el tipo que hallamos especificado en con Callable<Tipo> al especificar el 
	implements. De esta forma al ejecutar call() se puede obtener un valor de 
	retorno. En el hilo que quiera ejecutar este proceso se puede pedir 
	ejecutar el hilo y guardar el resultado en un objeto Future<Tipo>, de 
	Forma que podremos recuperar de Future<Tipo> el resultado cuando el 
	hilo lo retorne. Pareciera que cuando se intenta hacer get() sobre
	las variables de tipo Future el hilo actual se bloquea hasta que el 
	resultado este listo. Aunque tambien parece tener alternativas para 
	simplemente comprobar su valor sin bloquearse.
	NOTA: Mas info en la siguiente pagina:
		https://www.arquitecturajava.com/java-callable-interface-y-su-uso/ 