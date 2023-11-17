/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema2;

import java.util.Scanner;

/**
 *
 * @author Alumno
 */
public class Actividad1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
        Scanner in = new Scanner(System.in);
        
        System.out.println("Inserte el nombre: ");
        String nombre = in.nextLine();
        
        System.out.println("Inserte el dni: ");
        int dni = in.nextInt();
        
        System.out.println("Inserte la edad: ");
        int edad = in.nextInt();
        
        in.close();
        
        Persona per = new Persona(nombre,dni,edad);
        
        System.out.println(per.toString());
    }
    
}