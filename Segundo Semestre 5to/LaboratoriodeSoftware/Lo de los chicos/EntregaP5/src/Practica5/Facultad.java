package Practica5;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

public class Facultad {
	List<Alumno> alumnos = new ArrayList<Alumno>();
	
	public Facultad(List<Alumno> alumnos) {
		super();
		this.alumnos = alumnos;
	}

	public Alumno mejorEstudiante() {
		Collections.sort(this.alumnos, (n1, n2) -> Integer.compare(n1.getNota(), n2.getNota()));
		return this.alumnos.get(this.alumnos.size()-1);
	}
	
	public List<Alumno> cursoLabo() {
		return this.alumnos.stream()
				.filter(a -> a.getMateria().equals("Laboratorio de Software"))
				.collect(Collectors.toList());
	}
	
	public List<Alumno> caracterPMenorASeis() {
		return this.alumnos.stream()
				.filter(a -> a.getNombre().substring(0,1).equals("P") && a.getNombre().length() <= 6)
				.collect(Collectors.toList());
	}
	
	public List<Alumno> dosAlumnosPorNroAlumno(int n1, int n2){
		return this.alumnos.stream()
				.filter(a -> a.getNroAlumno() == n1 || a.getNroAlumno() == n2)
				.collect(Collectors.toList());
	}
	
	public List<Alumno> ordenarPorNota(){
		List<Alumno> lista = this.alumnos;
		lista.sort(new Ordenador().reversed());
		return lista;
	}
	
	public List<Alumno> ordenarPorNotaLambda() {
		List<Alumno> lista = this.alumnos;
		Collections.sort(lista,(n1, n2) -> Integer.compare(n2.getNota(), n1.getNota()));
		return lista;
	}
	
	public List<Alumno> ordenarPorNotaComparingInt() {
		List<Alumno> lista = this.alumnos;
		Comparator<Alumno> alumnoComparator = Comparator.comparingInt(Alumno::getNota);
		Collections.sort(lista,alumnoComparator.reversed());
		return lista;
	}
	
	private class Ordenador implements Comparator<Alumno>{
		public Ordenador() {
			super();
		}
		@Override
		public int compare(Alumno o1, Alumno o2) {
			return Integer.compare(o1.getNota(), o2.getNota());
		}
	}
}
