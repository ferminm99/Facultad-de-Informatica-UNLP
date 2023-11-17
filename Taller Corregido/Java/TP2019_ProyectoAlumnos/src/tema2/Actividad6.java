/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema2;

import java.util.Scanner;
import java.util.Random;

/**
 *
 * @author Alumno
 */
public class Actividad6 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        Partido vector[] = new Partido[20];
        
        Scanner in = new Scanner(System.in);
        
        Random rand = new java.util.Random();
        
        System.out.println("Inserte el nombre del equipo visitante: ");
        String visitante = in.next();
        String local;
        
        int max = 0;
        
        while (!(visitante.equals("ZZZ") && (max<20))){
            
            System.out.println("Inserte el nombre del equipo local: ");
            local = in.next();
            
            vector[max]= new Partido(local,visitante,rand.nextInt(6),rand.nextInt(6));
            
            max++;
            
            System.out.println("Inserte el nombre del equipo visitante: ");
            visitante = in.next();
        }
        int i,cant = 0,goles = 0,cante=0;
        for (i=0;i<max;i++){
            System.out.println(vector[i].getLocal() + " " + vector[i].getGolesLocal() + " - " + " "+
                               vector[i].getGolesVisitante()+ " " + vector[i].getVisitante()); 
            if(vector[i].hayGanador()){
               if(vector[i].getGanador().equals("River")) {
                   cant++;
               }
            }
            if(vector[i].getLocal().equals("Boca")){
                goles+=vector[i].getGolesLocal();
            }
            if(vector[i].hayEmpate()){
                cante++;
            }
        }
        
        System.out.println("La cantidad de veces que gano River es: " + cant);
        System.out.println("El total de goles que hizo Boca de local es: " +goles);
        System.out.println("El porcentaje de partidos que terminaron en empate son: " +((cante*100)/max)+ "%");
        // TODO code application logic here
    }
    
}