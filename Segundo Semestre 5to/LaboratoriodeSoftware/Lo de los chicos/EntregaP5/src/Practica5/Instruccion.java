package Practica5;

public class Instruccion {
	private Notas nota;
	private int duracion;
	
	public Instruccion(Notas nota, int duracion) {
		super();
		this.nota = nota;
		this.duracion = duracion;
	}
	
	public Notas getNota() {
		return nota;
	}
	public void setNota(Notas nota) {
		this.nota = nota;
	}
	public int getDuracion() {
		return duracion;
	}
	public void setDuracion(int duracion) {
		this.duracion = duracion;
	}
	
}
