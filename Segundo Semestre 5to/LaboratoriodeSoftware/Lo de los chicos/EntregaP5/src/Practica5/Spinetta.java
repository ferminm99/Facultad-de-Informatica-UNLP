package Practica5;

import java.util.List;

public enum Spinetta {
	INSTANCE(new Guitarra());

	Guitarra guitarra;
	Spinetta(Guitarra g) {
		this.guitarra = g;
	}
	
	public void tocar(List<Instruccion> notas) {
		for (Instruccion instruccion : notas) {
			guitarra.hacerSonar(instruccion.getNota(), instruccion.getDuracion());
		}
	}
}
