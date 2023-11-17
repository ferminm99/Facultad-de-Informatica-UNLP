
public abstract class MusicalInstrumentImpl implements MusicalInstrument {

	@Override
	public void hacerSonar() {
		System.out.println("Sonando sin nota");
	}

	@Override
	public abstract String queEs();

	@Override
	public void afinar() {
		System.out.println("Afinando sin frecuencia");
	}

	@Override
	public void hacerSonar(Note n, int duration) {
		System.out.println("Sonando ... " + n.getUSCipherLetter() + " con duracion: " + duration);
	}

	@Override
	public void afinar(LAFrequency f) {
		System.out.println("Afinando ... " + f.name());
	}

}
