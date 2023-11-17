package Practica5;

public interface InstrumentoMusical {
	void hacerSonar();
	String queEs();
	void afinar();
	void hacerSonar(Notas n, int duracion);
	void afinar(FrecuenciasDeLa f);
}
