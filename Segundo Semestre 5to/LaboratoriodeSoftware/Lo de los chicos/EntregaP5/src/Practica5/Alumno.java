package Practica5;

public class Alumno implements Comparable<Alumno>{
	private int nroAlumno;
	private String nombre;
	private String apellido;
	private int edad;
	private String materia;
	private int nota;

	
	public Alumno(int nroAlumno, String nombre, String apellido, int edad, String materia, int nota) {
		super();
		this.nroAlumno = nroAlumno;
		this.nombre = nombre;
		this.apellido = apellido;
		this.edad = edad;
		this.materia = materia;
		this.nota = nota;
	}


	@Override
	public int compareTo(Alumno f1) {
		return Integer.compare(this.nota, f1.getNota());
	}


	public int getNroAlumno() {
		return nroAlumno;
	}


	public void setNroAlumno(int nroAlumno) {
		this.nroAlumno = nroAlumno;
	}


	public String getNombre() {
		return nombre;
	}


	public void setNombre(String nombre) {
		this.nombre = nombre;
	}


	public String getApellido() {
		return apellido;
	}


	public void setApellido(String apellido) {
		this.apellido = apellido;
	}


	public int getEdad() {
		return edad;
	}


	public void setEdad(int edad) {
		this.edad = edad;
	}


	public String getMateria() {
		return materia;
	}


	public void setMateria(String materia) {
		this.materia = materia;
	}


	public int getNota() {
		return nota;
	}


	public void setNota(int nota) {
		this.nota = nota;
	}

	
	
}
