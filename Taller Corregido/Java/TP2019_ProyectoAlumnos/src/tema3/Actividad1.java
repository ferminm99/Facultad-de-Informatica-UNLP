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

public class Actividad1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Triangulo t = new Triangulo();
        
        Scanner in = new Scanner(System.in);
        
        System.out.println("Inserte el lado 1: ");
        t.setLado1(in.nextDouble());
        System.out.println("Inserte el lado 2: ");
        t.setLado2(in.nextDouble());
        System.out.println("Inserte el lado 3: ");
        t.setLado3(in.nextDouble());
        System.out.println("Inserte el relleno: ");
        t.setRelleno(in.next());
        System.out.println("Inserte el color: ");
        t.setColor(in.next());
        in.close();
    
        double p = t.perimetro();
        double area = t.calcularArea();
        
        System.out.println("El perimetro es " + p + " y el area es "+area);
        
        
    }
    
}