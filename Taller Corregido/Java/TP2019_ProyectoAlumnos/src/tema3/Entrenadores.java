/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema3;

/**
 *
 * @author Alumno
 */
public class Entrenadores {
    
    private String nombre;
    private double sueldobasico;
    private int campeonatos;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getSueldo() {
        return sueldobasico;
    }

    public void setSueldo(double sueldo) {
        this.sueldobasico = sueldo;
    }

    public int getCampeonatos() {
        return campeonatos;
    }

    public void setCampeonatos(int campeonatos) {
        this.campeonatos = campeonatos;
    }
    
    public double calcularSueldoACobrar(){
        double sueldo= sueldobasico;
        if(campeonatos>0 && campeonatos<5){
            sueldo=sueldobasico+5000;
        }else if(campeonatos<=10){
            sueldo=sueldobasico+30000;
        }else if(campeonatos>10){
            sueldo=sueldobasico+50000;
        }
        return sueldo;
    }

    @Override
    public String toString() {
        return "Entrenadores{" + "nombre=" + nombre + ", sueldo=" + this.calcularSueldoACobrar() + ", campeonatos=" + campeonatos + '}';
    }
    
    
}