package Practica5;

import java.util.ArrayList;
import java.util.List;

public class TestFacultad {

	public static void main(String[] args) {
		Alumno a1 = new Alumno(156534,"Lautaro","Aria",22,"Laboratorio de Software",8);
		Alumno a2 = new Alumno(156543,"Palej","Santi",21,"Objetos 2",6);
		Alumno a3 = new Alumno(143123,"Fermin","Moreno",24,"Laboratorio de Software",7);
		List<Alumno> l = new ArrayList<Alumno>();
		l.add(a1);
		l.add(a2);
		l.add(a3);
		Facultad f = new Facultad(l);
		System.out.println(f.mejorEstudiante().getNombre());
		System.out.println("Los que cursaron labo");
		for (Alumno alumno : f.cursoLabo()) {
			System.out.println(alumno.getNombre());
		}
		System.out.println("Arranca con P y el nombre tiene menos de 6 caracteres");
		for (Alumno alumno : f.caracterPMenorASeis()) {
			System.out.println(alumno.getNombre());
		}
		System.out.println("Dos alumnos");
		for (Alumno alumno : f.dosAlumnosPorNroAlumno(156534, 156543)) {
			System.out.println(alumno.getNombre());
		}
		System.out.println("Ordenados por nota");
		for (Alumno alumno : f.ordenarPorNota()) {
			System.out.println(alumno.getNombre());
		}
		System.out.println("Ordenados por nota lambda");
		for (Alumno alumno : f.ordenarPorNotaLambda()) {
			System.out.println(alumno.getNombre());
		}
		System.out.println("Ordenados por nota ComparingInt"); //Recibe como parametro una referencia a metodo
		for (Alumno alumno : f.ordenarPorNotaComparingInt()) {
			System.out.println(alumno.getNombre());
		}
	}

}
