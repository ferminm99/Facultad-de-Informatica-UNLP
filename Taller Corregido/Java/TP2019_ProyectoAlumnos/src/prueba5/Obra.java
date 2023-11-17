/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba5;

/**
 *
 * @author fer
 */
public class Obra {
    
    private String nombre,director;
    private Actores[] a;
    private int cantA;

    public Obra(String nombre, String director) {
        this.nombre = nombre;
        this.director = director;
        cantA=0;
        a = new Actores[100];
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public Actores[] getA() {
        return a;
    }

    public void setA(Actores[] a) {
        this.a = a;
    }
    
    public void agregarActor(Actores actor){
        a[cantA]=actor;
        cantA++;
    }
    
    public int cantidadActores(){
        return cantA;
    }
    
    public Boolean dondeActua(String nombre, String apellido){
        int i = 0;String n = "";Boolean ok = false;
        while((i<cantA) && ((!a[i].getNombre().equals(nombre)) || (!a[i].getApellido().equals(apellido))))
            i++;
        if(i!=cantA){
            ok=true;
        }
           
        return ok;
    }
    
    public Boolean estaLleno(){
        Boolean ok = false;
        if(cantA == 100)
            ok= true;
        return ok;
    }
     
}
