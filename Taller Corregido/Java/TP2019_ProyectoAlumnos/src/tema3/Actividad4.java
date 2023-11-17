package tema3;


import java.util.Scanner;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Alumno
 */
public class Actividad4 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        Circulos c = new Circulos();
        
        Scanner in = new Scanner(System.in);
        
        System.out.println("Ingrese el radio: ");
        c.setRadio(in.nextDouble());
        System.out.println("Inserte el relleno: ");
        c.setRelleno(in.next());
        System.out.println("Inserte la linea: ");
        c.setLinea(in.next());
        in.close();
    
        double p = c.calcularPerimetro();
        double area = c.calcularArea();
        
        System.out.println("El perimetro es " + p + " y el area es "+area);
        // TODO code application logic here
    }
    
}