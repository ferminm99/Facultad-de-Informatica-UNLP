/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4;

import java.util.Scanner;

/**
 *
 * @author henry
 */
public class Actividad5 {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        Flota f = new Flota();
        Micros m;
        System.out.println("se ingresa una patente: ");
        String patente = in.next();
        String destino,horaS;
        while (!patente.equals("ZZZ000") && !f.SiEstaLleno()){
            System.out.println("se ingresa un destino: ");
            destino = in.next();
            System.out.println("se ingresa una hora: ");
            horaS = in.next();
            f.agregarMicro(new Micros(patente,destino,horaS));
            System.out.println("se ingresa una patente: ");
            patente = in.next();
        }
        System.out.println("se ingresa una patente a buscar en la flota: ");
        patente = in.next();
        if (f.eliminarMicro(patente))
            System.out.println("se encontró el micro y se borró");
        else
            System.out.println("no se encontró el micro");
        System.out.println("se ingresa un destino a buscar en la flota");
        destino = in.next();
        m = f.buscarMicroD(destino);
        if (m == null){
            System.out.println("el micro a buscar con destino leido no se encontró");
        }
        else{
            System.out.println("patente del micro retornado: "+m.getPatente());
            System.out.println("hora de salida del micro retornado: "+m.getHs());
        }
        
    }
    
}