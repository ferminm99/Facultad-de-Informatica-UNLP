/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba4;

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
        
        Sondeo s = new Sondeo("¿Es adecuada la limpieza?");
        
        int opinion,cliente,sucursal;
        
        System.out.println("Ingrese la opinion");
        opinion = in.nextInt();
        
        while(opinion!=0){
            
            System.out.println("Ingrese el tipo de cliente");
            cliente = in.nextInt();
            
            System.out.println("Ingrese la sucursal");
            sucursal = in.nextInt();
            
            if(s.validarCliente(cliente) && s.validarSucursal(sucursal)){
                if(opinion>0){
                    s.devolverUrna(cliente, sucursal).setPositivas();
                }else{
                    s.devolverUrna(cliente, sucursal).setNegativas();
                }
            }
            
            System.out.println("Ingrese la opinion");
            opinion = in.nextInt();
            
        }
        
        in.close();
        
        System.out.println("El cliente mas exigente es: "+s.clienteMasExigente());
        System.out.println("El nro de la sucursal ganadora es: "+s.sucursalGanadora());
        System.out.println("El resultado del sondeo es: "+s.imprimirUrnas());
        
    }
    
}
