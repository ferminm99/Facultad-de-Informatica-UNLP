/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba3;

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
        Cine c = new Cine("Cine LP","Fermin Moreno"," 50 entre 10 y 9");
        Salas s;
        Pelicula p;
        
        int numero,cupo,vendidas,duracion,sala;
        String nombre,director,termina;
        
        System.out.println("Ingrese el numero de la sala: ");
        numero = in.nextInt();
        
        while(numero!=5 && c.cantidadS()<5){
            if(c.sePuede(numero) && !c.salaExiste(numero)){
                
                System.out.println("Ingrese la cantidad de entradas vendidas: ");
                vendidas = in.nextInt();
                
                System.out.println("Ingrese el cupo de entradas: ");
                cupo = in.nextInt();
                
                s = new Salas(numero,cupo,vendidas);
                c.agregarSala(s);
                
                System.out.println("Ingrese el nombre de la pelicula: ");
                nombre = in.next();
                
                System.out.println("Ingrese el nombre del director de la pelicula: ");
                director = in.next();
                
                System.out.println("Ingrese la duracion de la pelicula en minutos: ");
                duracion = in.nextInt();
                
                p = new Pelicula(nombre,director,duracion);
                s.agregarPelicula(p);
                
                System.out.println("Ingrese el numero de la sala: ");
                numero = in.nextInt();
                
            }
        }
        
        System.out.println("Ingrese fin si no quiere comprar entradas");
        termina = in.next();
        
        while(!termina.equals("fin")){
            
            System.out.println("Ingrese la sala de la que quiere comprar entradas: ");
            sala = in.nextInt();
            
            if(c.salaExiste(sala)){
                if(c.quedanEntradas(sala)){
                    c.comprarEntrada(sala);
                }else{
                    System.out.println("No quedan entradas");
                }
            }
            
               
            System.out.println("Ingrese fin si no quiere comprar entradas");
            termina = in.next();
            
        }
        
        System.out.println("Ingrese fin si no quiere devolver entradas");
        termina = in.next();
        
        while(!termina.equals("fin")){
            
            System.out.println("Ingrese la sala de la que quiere devolver entradas: ");
            sala = in.nextInt();
            
            if(c.salaExiste(sala)){
                if(c.quedanEntradas(sala)){
                    c.devolverEntrada(sala);
                }else{
                    System.out.println("No quedan entradas");
                }
            }
                        
            System.out.println("Ingrese fin si no quiere devolver entradas");
            termina = in.next();
            
        }
        
        System.out.println("Ingrese la pelicula que quiere saber donde se proyecta: ");
        nombre = in.next();
        
        in.close();
        
        if(c.dondeSeProyecta(nombre)!=-1){
            System.out.println("La pelicula se proyecta en la sala: "+c.dondeSeProyecta(nombre));
        }else{
            System.out.println("La pelicula ingresada no se proyectara en ningun lado");
        }
        
        System.out.println("La sala con mas entradas vendidas es: "+c.salaConMasVendidas());
        System.out.println("La pelicula con mas entradas vendidas es: "+c.peliQueMasVendio());
        
    }
    
}
