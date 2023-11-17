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
public class Triangulo extends Figura {
    private double lado1;
    private double lado2;
    private double lado3;


    public Triangulo( double ellado1,  double ellado2, double ellado3, String unCR, String unCL) {
        super(unCR, unCL);
        lado1 = ellado1;
        lado2 = ellado2; 
        lado3= ellado3;
        
    }

    public double getLado1() {
        return lado1;
    }

    public void setLado1(double lado1) {
        this.lado1 = lado1;
    }

    public double getLado2() {
        return lado2;
    }

    public void setLado2(double lado2) {
        this.lado2 = lado2;
    }

    public double getLado3() {
        return lado3;
    }

    public void setLado3(double lado3) {
        this.lado3 = lado3;
    }
    
    public double calcularPerimetro(){
        return (lado1+lado2+lado3);
    }
    public double calcularArea(){
        double s = (lado1+lado2+lado3)/2;
        double area = (s*(s-lado1)*(s-lado2)*(s-lado3));
        return Math.sqrt(area);
    }

    @Override
    public String toString() {
        String aux = super.toString() + " Lado 1: " + getLado1() + " Lado 2: " 
                                      + getLado2() + " Lado 3: " + getLado3();
        return aux;
    }

 
   
    
}