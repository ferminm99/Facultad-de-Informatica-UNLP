/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba6;

import java.util.Scanner;

/**
 *
 * @author fer
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        Scanner in = new Scanner(System.in);
        
        Productos p;
        
        TicketN tn = new TicketN(1,"23/05/2019");
        int codigo,precio;
        String fecha,descripcion;
        
        System.out.println("Ingresa el codigo del producto: ");
        codigo = in.nextInt();
        
        while(codigo!=0){
            
            System.out.println("Ingrese el precio: ");
            precio = in.nextInt();
            
            System.out.println("Ingrese la descripcion: ");
            descripcion = in.next();
            
            p = new Productos(codigo,descripcion,precio);
            tn.cargarProducto(p);
            
            System.out.println("Ingresa el codigo del producto: ");
            codigo = in.nextInt();
            
        }
        
        TicketD td = new TicketD(2,"23/05/2019",50);
        
        System.out.println("Ingresa el codigo del producto: ");
        codigo = in.nextInt();
        
        while(codigo!=0){
            
            System.out.println("Ingrese el precio: ");
            precio = in.nextInt();
            
            System.out.println("Ingrese la descripcion: ");
            descripcion = in.next();
            
            p = new Productos(codigo,descripcion,precio);
            td.cargarProducto(p);
            
            System.out.println("Ingresa el codigo del producto: ");
            codigo = in.nextInt();
            
        }
        
        in.close();
        
        System.out.println("Resumen: "+tn.mostrarResumen());
        System.out.println("Resumen: "+td.mostrarResumen());
        
        if(tn.abonableConDebito()){
            System.out.println("El ticket 1 es abonable con debito");
        }else{
            System.out.println("El ticket 1 no es abonable con debito");
        }
        
        if(td.abonableConDebito()){
            System.out.println("El ticket 2 es abonable con debito");
        }else{
            System.out.println("El ticket 2 no es abonable con debito");
        }
        
    }
    
}
