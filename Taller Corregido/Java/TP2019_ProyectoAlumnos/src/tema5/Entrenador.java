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
public class Entrenador extends Empleado{
    
    private int campeonatos;

    public Entrenador(String nombre, double sueldobasico, int campeonatos) {
        super(nombre,sueldobasico);
        this.campeonatos = campeonatos;
    }

    public int getCampeonatos() {
        return campeonatos;
    }

    public void setCampeonatos(int campeonatos) {
        this.campeonatos = campeonatos;
    }
    
    public double calcularSueldoACobrar(){
        double sueldo= getSueldoBasico();
        if(campeonatos>0 && campeonatos<5){
            sueldo=getSueldoBasico()+5000;
        }else if(campeonatos<=10){
            sueldo=getSueldoBasico()+30000;
        }else if(campeonatos>10){
            sueldo=getSueldoBasico()+50000;
        }
        return sueldo;
    }

    @Override
    public String toString() {
        return  super.toString() + 
                "Entrenador{" + "campeonatos=" + campeonatos + '}';
    }
    
    

}