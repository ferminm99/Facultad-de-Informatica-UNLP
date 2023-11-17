/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba7;

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
        Teatro t = new Teatro("Cazafantasmas","22-10-2018","20:00");
        Espectadores e;
        
        int dni,edad,f,butaca;
        String nombre;
        
        System.out.println("Ingrese el dni: ");
        dni = in.nextInt();
    
        while(dni!=0 && t.calcularButacasLibres()!=0){
            
            System.out.println("Ingrese el nombre: ");
            nombre = in.next();
            
            System.out.println("Ingrese la edad: ");
            edad = in.nextInt();
            
            System.out.println("Ingrese la fila");
            f = in.nextInt();
             
            if(t.validarFila(f)){
                if(t.hayButacaLibreEnFila(f)){
                    if(!t.estaRegistradoEspectador(dni)){
                        e = new Espectadores(dni,edad,nombre);
                        butaca = t.agregarEspectadorAlaFila(e, f);
                        System.out.println("La butaca asignada es: "+butaca);
                    }else{
                        System.out.println("El espectador esta registrado");
                    }
                }else{
                    System.out.println("No hay butacas libres en la fila");
                }
            }else{
                System.out.println("La fila no es valida");
            }
            
            System.out.println("Ingrese el dni: ");
            dni = in.nextInt();
            
        }
        in.close();
        
        System.out.println("La cantidad de butacas libres son: "+t.calcularButacasLibres());
        System.out.println("La edad promedio de los espectadores es: "+t.calcularEdadPromEspectadores());
        
    }
    
}
