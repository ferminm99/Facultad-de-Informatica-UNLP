package Practica5;

public class Guitarra implements InstrumentoMusical {
	
	public void hacerSonar(Notas n, int duracion) {
		System.out.println("Suena: "+n.name()+" por "+duracion+" segundos");
	}
	
	public void hacerSonar() {
		System.out.println("Suena");
	}
	
	public String queEs() {
		String str = "Soy una guitarra";
		return str;
	}
	
	public void afinar(FrecuenciasDeLa f) {
		System.out.println("Se afina con la frecuencia: "+f.name());
	}
	
	public void afinar() {
		System.out.println("Afina de ruta");
	}
}
