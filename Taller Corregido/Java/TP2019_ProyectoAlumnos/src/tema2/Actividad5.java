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
public class Actividad5 {
    
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        String vector[] = new String[10];
        Scanner in = new Scanner(System.in);
        
        int i;
        String palabra;
        for (i=0;i<10;i++){
            System.out.println("Inserte la palabra: ");
            palabra = in.next();
            vector[i]=palabra;
        }
        
        char letra;
        String nuevo = "";
        
        for (i=0;i<10;i++){
            letra = vector[i].charAt(0);
            nuevo += letra;
        }
        
        System.out.println(nuevo);
        
        // TODO code application logic here
    }
    
}