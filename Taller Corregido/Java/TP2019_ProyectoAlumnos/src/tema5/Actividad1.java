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
public class Actividad1 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Scanner in = new Scanner(System.in);
        System.out.println("Inserte el lado 1: ");
        Double lado1 = in.nextDouble();
        System.out.println("Inserte el lado 2: ");
        Double lado2 = in.nextDouble();
        System.out.println("Inserte el lado 3: ");
        Double lado3 = in.nextDouble();
        System.out.println("Inserte el relleno: ");
        String relleno = in.next();
        System.out.println("Inserte el color: ");
        String color = in.next();
        
        Triangulo t = new Triangulo(lado1,lado2,lado3,relleno,color);
        

        System.out.println("Inserte el lado 1: ");
        Double lado = in.nextDouble();
        System.out.println("Inserte el relleno: ");
        String relleno2 = in.next();
        System.out.println("Inserte el color: ");
        String color2 = in.next();
        
        System.out.println("Inserte el radio: ");
        Double radio = in.nextDouble();
        System.out.println("Inserte el relleno: ");
        String relleno3 = in.next();
        System.out.println("Inserte el color: ");
        String color3 = in.next();
        
        Circulos circulo = new Circulos(radio,relleno3,color2);
        
        in.close();
        
        Cuadrado c = new Cuadrado(lado,relleno2,color2);
        
        System.out.println("Cuadrado: ");
        System.out.println(c.toString());
        System.out.println("Triangulo: ");
        System.out.println(t.toString());       
        System.out.println("Circulo: ");
        System.out.println(circulo.toString());    
        
    }
    
}