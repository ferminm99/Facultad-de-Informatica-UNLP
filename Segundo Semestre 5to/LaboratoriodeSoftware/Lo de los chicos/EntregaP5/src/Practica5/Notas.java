package Practica5;

public enum Notas {
	DO("C"),
	RE("D"),
	MI("E"),
	FA("F"),
	SOL("G"),
	LA("A"),
	SI("B");

	private String americano;
	Notas(String a) {
		this.americano = a;
	}
}
