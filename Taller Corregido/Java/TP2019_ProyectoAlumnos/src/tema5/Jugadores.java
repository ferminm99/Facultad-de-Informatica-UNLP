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
public class Jugadores extends Empleado{
    
    private double partidos,goles;

    public Jugadores(double partidos, double goles, String nombre, double sueldo) {
        super(nombre, sueldo);
        this.partidos = partidos;
        this.goles = goles;
    }

    public double getPartidos() {
        return partidos;
    }

    public void setPartidos(double partidos) {
        this.partidos = partidos;
    }

    public double getGoles() {
        return goles;
    }

    public void setGoles(double goles) {
        this.goles = goles;
    }
    
    public double calcularSueldoACobrar(){
        double promedio = goles/partidos;
        double sueldo= getSueldoBasico();
        if(promedio>0.5){
            sueldo=getSueldoBasico()+1000;
        }
        return sueldo;
    } 

    @Override
    public String toString() {
        return super.toString() + 
                "Jugadores{" + "partidos=" + partidos + ", goles=" + goles + '}';
    }
  
    
}
