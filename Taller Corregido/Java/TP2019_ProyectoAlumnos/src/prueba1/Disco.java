/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba1;

/**
 *
 * @author fer
 */
public class Disco {
    
    private String nombre;
    private int fecha,cantC;
    Canciones c[];

    public Disco(String nombre, int fecha) {
        this.nombre = nombre;
        this.fecha = fecha;
        cantC= 0;
        c = new Canciones[25];
            
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public int getFecha() {
        return fecha;
    }

    public void setFecha(int fecha) {
        this.fecha = fecha;
    }

    public Canciones[] getC() {
        return c;
    }

    public void setC(Canciones[] c) {
        this.c = c;
    }
    
    public void agregarCancion(Canciones cancion){
        c[cantC]=cancion;
        cantC++;
    }
    
    public int buscarCancion(String nombreC){
        int i = 0,duracion = 0;
        while(i<cantC && !c[i].getNombre().equals(nombreC))
            i++;
        if(i!=cantC){
            duracion = c[i].getDuracion();
        }
        return duracion;
    }
    
    public int cantCanciones(){
        return cantC;
    }
    
    public Boolean estaLleno(){
        Boolean ok = false;
        if(25 == cantC)
            ok=true;
        return ok;
    }
    
}
