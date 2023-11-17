/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4;

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
       Micros micro1 = new Micros("ABC123", "Mar del plata", "5:00 AM");
       Scanner in = new Scanner(System.in);
       System.out.println("Inserte el asiento que quiere ocupar: ");
       int asiento = in.nextInt();
       while(asiento!=-1 && !micro1.getLleno()){
           
           if(micro1.validar(asiento)){
               if(!micro1.devolver(asiento)){
                  micro1.Ocupar(asiento);
                  System.out.println("El asiento "+asiento+ " estaba libre");  
               }else{
               System.out.println("El asiento "+asiento+ " estaba ocupado");
               micro1.primerAsientoD();
                }      
           }else{
               System.out.println("El asiento no es valido, ingrese un asiento entre 0 y 20");
           }
           
           
           System.out.println("Inserte el asiento que quiere ocupar: ");
           asiento = in.nextInt();
           
       }
        System.out.println("La cantidad de asientos ocupados es: "+micro1.getOcupados());
    }
    
}