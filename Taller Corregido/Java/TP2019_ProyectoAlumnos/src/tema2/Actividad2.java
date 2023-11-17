/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema2;

import java.util.Random;
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
        
        Persona vector[] = new Persona[15];
        
        Scanner in = new Scanner(System.in);
        
        Random rand = new Random();
        
        int i;
        for (i=0;i<15;i++){
        
            System.out.println("Inserte el nombre: ");
            String nombre = in.next();
            
            //System.out.println("Inserte el dni: ");
            //int dni = in.nextInt();
        
            //System.out.println("Inserte la edad: ");
            //int edad = in.nextInt();
            
            vector[i] = new Persona(nombre,rand.nextInt(999999),rand.nextInt(100));
        }
        
        in.close();
        
        int cant = 0;
        int menor = 99999999;
 
        Persona per = new Persona();
        
        for(i=0;i<15;i++){
            System.out.println(vector[i].toString());
        }
        
        for(i=0;i<15;i++){
            
            if(vector[i].getEdad()>65){
                cant++;
            }
            if(vector[i].getDNI()< menor){
                menor = vector[i].getDNI();
                per = vector[i];
            }
        } 
        
        System.out.println("La cantidad de personas mayores de 65 son: "+cant+
                            " y  la persona con menor dni " + per.getNombre());
        
        
        // TODO code application logic here
    }
    
}