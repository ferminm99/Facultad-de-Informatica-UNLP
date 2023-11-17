/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema3;

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
        
        Entrenadores e = new Entrenadores();
        Scanner in = new Scanner(System.in);
        
        System.out.println("Ingrese el nombre: ");
        e.setNombre(in.next());
        System.out.println("Ingrese el sueldo: ");
        e.setSueldo(in.nextDouble());
        System.out.println("Ingrese la cantidad de campeonatos ganados: ");
        e.setCampeonatos(in.nextInt());
        
        in.close();
        
        System.out.println(e.toString());
        // TODO code application logic here
    }
    
}