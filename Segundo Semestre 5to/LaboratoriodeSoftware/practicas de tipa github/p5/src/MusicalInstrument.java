
public interface MusicalInstrument {
	void hacerSonar();
	String queEs();
	void afinar();
	void hacerSonar(Note n, int duration);
	void afinar(LAFrequency f);
}
