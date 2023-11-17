/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema5;

/**
 *
 * @author Alumno
 */
public class Trabajadores extends Persona{
    
    private String tarea;

    public Trabajadores(String tarea, String unNombre, int unDNI, int unaEdad) {
        super(unNombre, unDNI, unaEdad);
        this.tarea = tarea;
    }

    public Trabajadores(String tarea) {
        this.tarea = tarea;
    }
    
    public String getTarea() {
        return tarea;
    }

    public void setTarea(String tarea) {
        this.tarea = tarea;
    }

    @Override
    public String toString() {
        return super.toString() + " Soy " + tarea ;
    }
    
    
    
    
    
}