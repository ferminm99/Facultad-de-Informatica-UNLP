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

public abstract class Empleado {
    private String nombre;
    private double sueldoBasico;
   
  
    public Empleado(String nombre, double sueldo){
        setNombre(nombre);
        setSueldoBasico(sueldo);
    }
    

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public double getSueldoBasico() {
        return sueldoBasico;
    }

    public void setSueldoBasico(double sueldoBasico) {
        this.sueldoBasico = sueldoBasico;
    }
     
    public abstract double calcularSueldoACobrar();

    @Override
    public String toString() {
        return "Empleado{" + "nombre=" + nombre + ", Sueldo a cobrar =" + calcularSueldoACobrar() + '}';
    }
    
    
    
}