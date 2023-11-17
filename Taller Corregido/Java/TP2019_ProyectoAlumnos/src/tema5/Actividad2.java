/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema5;

import java.util.Scanner;

/**
 *
 * @author Alumno
 */
public class Actividad2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        
        Scanner in = new Scanner(System.in);
        
        System.out.println("Ingrese el nombre: ");
        String nombre = in.next();
        System.out.println("Ingrese el sueldo: ");
        double sueldo = in.nextDouble();
        System.out.println("Ingrese la cantidad de campeonatos ganados: ");
        int campeonatos = in.nextInt();
        
        Entrenador e = new Entrenador(nombre,sueldo,campeonatos);

        System.out.println("Ingrese el nombre: ");
        String nombre2 = in.next();
        System.out.println("Ingrese el sueldo: ");
        double sueldo2 = in.nextDouble();
        System.out.println("Ingrese la cantidad de partidos: ");
        double partidos = in.nextDouble();
        System.out.println("Ingrese la cantidad de goles: ");
        double goles = in.nextDouble();
        in.close();
        
        Jugadores j = new Jugadores(partidos,goles,nombre2,sueldo2);
        
        System.out.println(e.toString());
        System.out.println(j.toString());
        
        
        
        // TODO code application logic here
    }
    
}