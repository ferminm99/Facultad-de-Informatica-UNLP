/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba5;

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
        Teatro t = new Teatro("Teatro","Fermin Moreno","50 y 10");
        Obra o;
        Actores a;
        
        String nombreO,director,nombreA,apellidoA;
        int edad;
        
        System.out.println("Ingresa el nombre de la obra");
        nombreO = in.next();
        
        while(!nombreO.equals("fin") && !t.estaLleno()){
            
            System.out.println("Ingrese el nombre del director: ");
            director = in.next();
            
            o = new Obra(nombreO,director);
            t.agregarObra(o);
            
            System.out.println("Ingrese el nombre del actor: ");
            nombreA = in.next();
            
            while(!nombreA.equals("fin") && !t.estaLlenoA()){
                
                System.out.println("Ingrese el apellido del actor: ");
                apellidoA = in.next();
                
                System.out.println("Ingrese la edad del actor: ");
                edad = in.nextInt();
                
                a = new Actores(nombreA,apellidoA,edad);
                o.agregarActor(a);
                
                System.out.println("Ingrese el nombre del actor: ");
                nombreA = in.next();
                
            }
            
            System.out.println("Ingresa el nombre de la obra");
            nombreO = in.next();
            
        }
        
        System.out.println("Ingrese el nombre de la obra que quiere saber que director trabaja: ");
        nombreO = in.next();
        
        if(!t.nombreDirector(nombreO).equals("")){
            System.out.println("El nombre del director es: " + t.nombreDirector(nombreO));
        }else{
            System.out.println("La obra ingresada no existe");
        }
        
        System.out.println("Ingrese el nombre del actor del cual quieres saber en que obra actua: ");
        nombreA = in.next();
        
        System.out.println("Ingrese el apellido del actor del cual quieres saber en que obra actua: ");
        apellidoA = in.next();
        
        in.close();
        
        if(!t.dondeActua(nombreA, apellidoA).equals("")){
            System.out.println("El actor actua en la obra: "+t.dondeActua(nombreA, apellidoA));
        }else{
            System.out.println("El actor no existe");
        }
        
        System.out.println("La obra con menos actores es: "+t.obraConMenosActores());
        System.out.println("El actor mas viejo es: "+t.actorMasViejo());
        
    }
    
}
