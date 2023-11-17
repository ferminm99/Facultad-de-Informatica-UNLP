public class GuitarTest {
	
	public static void main(String []args){
		Guitar g = new Guitar();
		g.hacerSonar();
		g.queEs();
		g.afinar();
	
		g.hacerSonar(Note.DO, 20);
		g.hacerSonar(Note.RE, 20);
		g.hacerSonar(Note.MI, 20);
		g.hacerSonar(Note.FA, 20);
		g.hacerSonar(Note.SOL, 20);
		g.hacerSonar(Note.LA, 20);
		g.hacerSonar(Note.SI, 20);
		
		g.afinar(LAFrequency.F440);
		g.afinar(LAFrequency.F444);
		g.afinar(LAFrequency.F446);
		g.afinar(LAFrequency.F480);
	}

}
