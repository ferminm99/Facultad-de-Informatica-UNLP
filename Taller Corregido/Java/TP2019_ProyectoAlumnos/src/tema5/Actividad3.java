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
public class Actividad3 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        
         Scanner in = new Scanner(System.in);
         
         System.out.println("Ingrese el nombre: ");
         String nombre = in.next();
         System.out.println("Ingrese el DNI: ");
         int dni = in.nextInt();
         System.out.println("Ingrese la edad: ");
         int edad = in.nextInt();
         System.out.println("Ingrese una tarea: ");
         String tarea = in.next();
         in.close();
         
         Personas p = new Personas(nombre,dni,edad);
         Trabajadores t = new Trabajadores(tarea,nombre,dni,edad);
                 
                 
         System.out.println(p.toString());
         System.out.println(t.toString());
              
         
         
    }
    
}