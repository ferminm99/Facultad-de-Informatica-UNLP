/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4;

/**
 *
 * @author Alumno
 */
public class Entrenador {
    
    private String nombre;
    private double sueldobasico;
    private int campeonatos;

    public Entrenador(String nombre, double sueldobasico, int campeonatos) {
        this.nombre = nombre;
        this.sueldobasico = sueldobasico;
        this.campeonatos = campeonatos;
    }

    public Entrenador(){
        
    }
    
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getSueldobasico() {
        return sueldobasico;
    }

    public void setSueldobasico(double sueldobasico) {
        this.sueldobasico = sueldobasico;
    }

    public int getCampeonatos() {
        return campeonatos;
    }

    public void setCampeonatos(int campeonatos) {
        this.campeonatos = campeonatos;
    }
    
    
    
}