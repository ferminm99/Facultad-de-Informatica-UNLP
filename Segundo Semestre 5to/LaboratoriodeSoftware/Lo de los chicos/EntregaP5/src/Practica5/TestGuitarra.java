package Practica5;

public class TestGuitarra {

	public static void main(String[] args) {
		Guitarra g = new Guitarra();
		g.hacerSonar(Notas.DO, 5);
		g.afinar(FrecuenciasDeLa.HZ440);
	}

}
