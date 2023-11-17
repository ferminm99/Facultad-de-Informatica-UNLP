/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba1;

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
        Bandas b = new Bandas("La Vela Puerca","Montevideo","Rock");
        
        int fecha,duracion;
        String nombreD,nombreC;
        
        Disco d;
        Canciones c;
        
        System.out.println("Ingrese el nombre del disco: ");
        nombreD = in.next();
        
        while(!nombreD.equals("fin") && !b.estaLleno()){
            
            System.out.println("Ingrese la fecha del disco: ");
            fecha = in.nextInt();
        
            d = new Disco(nombreD,fecha);
            b.agregarDisco(d);
            
            System.out.println("Ingrese el nombre de la cancion: ");
            nombreC = in.next();
            
            while(!nombreC.equals("fin") && !b.estaCLleno()){
                
                System.out.println("Ingrese la duracion de la cancion: ");
                duracion = in.nextInt();
                
                c = new Canciones(nombreC,duracion);
                d.agregarCancion(c);
                
                System.out.println("Ingrese el nombre de la cancion: ");
                nombreC = in.next();
                
            }
            
            System.out.println("Ingrese el nombre del disco: ");
            nombreD = in.next();
            
            
        }
        
        System.out.println("Ingrese el nombre del disco del que quieres saber su duracion: ");
        nombreD= in.next();
        
        System.out.println("Ingrese nombre de la cancion que quieres saber su duracion: ");
        nombreC= in.next();
        in.close();
        duracion = b.duracionDisco(nombreD, nombreC);
        
        if(duracion == 0){
            System.out.println("No existe");
        }else{
            System.out.println("Su duracion es: " + duracion);
        }
        
        System.out.println("El tema mas largo es: "+b.temaMasLargo());
        System.out.println("La cantidad de temas del disco mas viejo son: "+b.cantTemasDiscoViejo());
        
    }
    
}
