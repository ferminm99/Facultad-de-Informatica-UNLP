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
public class Actividad4 {
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Persona matriz[][] = new Persona[5][8];
        
        Scanner in = new Scanner(System.in);
        
        Random rand = new Random();
        
        System.out.println("Inserte el nombre: ");
        String nombre = in.next();
       
        int max = 1,filas = 0,columnas = 0;
        while(!(nombre.equals("ZZZ")) && (filas<5)){
            columnas = 0;
            while(!(nombre.equals("ZZZ")) && (columnas<8)){
                System.out.println("Inserte el nombre: ");
                nombre = in.next();
                matriz[filas][columnas] = new Persona(nombre,rand.nextInt(999999),rand.nextInt(100));
                columnas++;
            }
            filas++;
        }
        
        in.close();
        
        int i,j;
        for (i=0;i<filas;i++){
            for (j=0;j<columnas;j++){
                System.out.println("La persona "+ matriz[i][j].getNombre() + " tiene el turno "+
                                    j + " el dia "+i);
            }          
        }
    }
    
}