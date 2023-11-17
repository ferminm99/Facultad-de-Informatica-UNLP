1)	Hay que contemplar varias alternativas, luego de mirar las diapositivas se me
ocurren las siguientes formas:
	a - Directamente sobre el metodo Main: Aunque es necesario usar "Thread.sleep(1000);" 
	para realizar la espera.
	
	b - Haciendo que se encargue un thread mientras main hace lo suyo.
	IMPORTANTE: Por mas que el main termine los hilos que creo siguen ejecutandose con
	normalidad
	
	c - Usando un Ejecutor.
	IMPOTANTE: El uso de ejecutores se justifica cuando se tienen mas threads que CPUs, 
	no es realmente necesario (podria incluso ser ineficiente) hacer uso de ejecutores 
	en esta situacion, donde solo se tiene un thread Reloj.
	
	NOTA: Pense respecto a hacer uso de synchronized pero no veo sentido en usarlo para
	este caso, ya que el hilo reloj es independiente, no necesita sincronizar ni con 
	main ni ningun otro hilo. 