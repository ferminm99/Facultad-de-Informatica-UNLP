package punto7;

public class Guitarra implements InstrumentoMusical {

	public Guitarra() {
		
	}

	@Override
	public void hacerSonar() {
		System.out.println("haciendo sonar");
	}

	@Override
	public void hacerSonar(Notas n, int duracion) {
		System.out.println("haciendo sonar "+n+" ("+n.cifrado_americano()+") durante "+duracion+" segundos");
	}

	@Override
	public String queEs() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void afinar(FrecuenciasDeLA f) {
		System.out.println("afinando a la frecuencia "+f+" la cual usa "+f.hercios()+" Hz");
	}

}
