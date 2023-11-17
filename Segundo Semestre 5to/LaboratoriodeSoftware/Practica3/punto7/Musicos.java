package punto7;

import java.util.ArrayList;

public enum Musicos {
	Luis_Alberto_Spinetta(new Guitarra());

	private InstrumentoMusical instrumento;
	
	Musicos(InstrumentoMusical instrumento) {
		this.instrumento = instrumento; 
	}
	
	InstrumentoMusical instrumento() {
		return this.instrumento;
	}
	
	void tocarCancion(ArrayList<Notas> notas, ArrayList<Integer> tiempos) {
		for (int i=0; i < notas.size(); i++) {
			this.instrumento.hacerSonar(notas.get(i), tiempos.get(i));
		}
	}
}
