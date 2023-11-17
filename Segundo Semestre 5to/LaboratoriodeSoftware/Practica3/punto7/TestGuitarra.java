package punto7;

import java.util.ArrayList;

public class TestGuitarra {

	public static void main(String[] args) {
		Guitarra guitarra = new Guitarra();
		
		// Seleccion manual de una frecuencia
		//FrecuenciasDeLA frecuencia = FrecuenciasDeLA.Renacimiento;
		
		// Recorrido automatico por todas las frecuencias
		for (FrecuenciasDeLA frecuencia: FrecuenciasDeLA.values()) {
			guitarra.afinar(frecuencia);
		}
		
		// Recorrido automatico por todas las notas
		for (Notas nota: Notas.values()) {
			guitarra.hacerSonar(nota, 10);
		}
		
		System.out.println("...");
		System.out.println("OH POR DIOS");
		System.out.println("AH LLEGADO LUUIS AALBERTO SPINETTAA");
		System.out.println("A CONTINUACION NOS TOCARA SU NUEVO EXTO (me atrevo a dudar de esti ultimo)");
		
		ArrayList<Notas> notas = new ArrayList<Notas>();
		notas.add(Notas.Re);
		notas.add(Notas.Do);
		notas.add(Notas.Sol);
		notas.add(Notas.Sol);
		notas.add(Notas.La);
		notas.add(Notas.Mi);
		notas.add(Notas.Fa);
		notas.add(Notas.Si);
		notas.add(Notas.Do);
		notas.add(Notas.Si);
		
		ArrayList<Integer> tiempos = new ArrayList<Integer>();
		tiempos.add(1);
		tiempos.add(2);
		tiempos.add(3);
		tiempos.add(4);
		tiempos.add(5);
		tiempos.add(6);
		tiempos.add(7);
		tiempos.add(8);
		tiempos.add(9);
		tiempos.add(10);
		
		Musicos.Luis_Alberto_Spinetta.tocarCancion(notas, tiempos);
		
		
		
	}

}
