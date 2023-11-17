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
public class Actividad2 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        BalanzaComercial bc = new BalanzaComercial();
        Scanner in = new Scanner(System.in);
        
        bc.iniciarCompra();
        
        System.out.println("Ingrese el peso: ");
        double peso = in.nextDouble();
        double precio;
        String nombre;
      
        while(peso!=0){
            System.out.println("Ingrese el precio: ");
            precio = in.nextDouble();
            System.out.println("Ingrese la cantidad de productos: ");
            bc.setCantidad(in.nextInt());
            System.out.println("Ingrese el nombre de producto: ");
            bc.setNombre(in.next());
            bc.registrarProducto(peso,precio);
            System.out.println("Ingrese el peso: ");
            peso = in.nextDouble();
            bc.MontoAPagar();
        }
        
        in.close();
        
        System.out.println(bc.ResumenDeCompra());
        
    }
    
}