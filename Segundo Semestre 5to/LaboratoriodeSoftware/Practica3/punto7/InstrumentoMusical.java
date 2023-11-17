package punto7;

public interface InstrumentoMusical {
	
	void hacerSonar();
	void hacerSonar(Notas n, int duracion);
	
	String queEs();
	
	// void afinar(); //Opcion 1: Requiere que el metodo sea definido en los implementadores.
	default void afinar() {} //Opcion 2: No requiere que el metodo sea definido en los implementadores.
	void afinar(FrecuenciasDeLA f);
}
