/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba2;

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
        
        Discografica d = new Discografica("Re Loco","Fermin","Saladillo");
        
        Solistas s;
        Bandas b;
        
        String nombreS,nombreB,inst,ciudad;
        int temas,integrantes;
        
        System.out.println("Ingrese el nombre del solista: ");
        nombreS = in.next();
        System.out.println("Ingrese el nombre de la banda: ");
        nombreB = in.next();
        
        while(!nombreS.equals("fin") && !nombreB.equals("fin") && !d.estaLleno()){
            
            System.out.println("Ingrese el instrumento del solista: ");
            inst=in.next();
            
            System.out.println("Ingrese la cantidad de temas del solista");
            temas = in.nextInt();
            
            s = new Solistas(nombreS,inst,temas);
            d.agregarSolista(s);
            
            System.out.println("Ingrese la ciudad de la banda: ");
            ciudad=in.next();
            
            System.out.println("Ingrese la cantidad de integrantes");
            integrantes = in.nextInt();
            
            b = new Bandas(nombreB,ciudad,integrantes);
            d.agregarBandas(b);
            
            System.out.println("Ingrese el nombre del solista: ");
            nombreS = in.next();
            System.out.println("Ingrese el nombre de la banda: ");
            nombreB = in.next();
            
        }
        
        System.out.println("Ingrese el instrumento del que quiere saber la cantidad de artistas que lo tocan: ");
        inst = in.next();
        
        in.close();
        
        System.out.println("La cantidad de artistas que tocan ese instrumento son : "+d.cantArtistasQueTocanI(inst));
        
        System.out.println("La banda con mas integrantes es: "+d.bandaConMasIntegrantes());
        System.out.println("La cantidad de bandas en la misma ciudad que tiene la discografica son: "+d.cantBMismaCiudad());
        
    }
    
}
