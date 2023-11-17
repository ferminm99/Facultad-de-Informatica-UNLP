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
public class Ejercicio6{
public void imprimirInfo(Figura f){
System.out.println(f.calcularArea ());
System.out.println(f.calcularPerimetro());
}
public void ejecutar(){
Figura [] figus = new Figura[3];
figus[0]= new Cuadrado(10,"Violeta","Rosa");
figus[1]= new Rectangulo(20,10,"Azul","Celeste");
 figus[2]= new Cuadrado(30,"Rojo","Naranja");
int i;
for (i=0; i < 3; i++){
imprimirInfo(figus[i]);
}
}
}