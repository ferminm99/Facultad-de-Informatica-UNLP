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
public class Circulos extends Figura{
    
    private double radio;

    public Circulos(double radio, String unCR, String unCL) {
        super(unCR, unCL);
        this.radio = radio;
    }
   

    public double calcularPerimetro(){
        return (2*Math.PI*radio);
    }
    
    public double calcularArea(){
        return (Math.PI*(radio*radio));
    }
    
}