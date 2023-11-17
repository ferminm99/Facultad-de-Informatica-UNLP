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
public class BalanzaComercial {
    
    private double monto,total;
    private int cantidad,tcantidad;
    private String resumen,nombre;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    
    public double getMonto() {
        return monto;
    }

    public void setMonto(double monto) {
        this.monto = monto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }
    
    public void iniciarCompra(){
        total = 0;
        monto = 0;
        cantidad = 0;
        tcantidad = 0;
        resumen = "";
    }
    
    public void registrarProducto(double pesoEnKg, double precioPorKg){
        monto = pesoEnKg * precioPorKg;
        total +=monto;
        resumen = resumen + (nombre+" "+(monto)+ " pesos - ");
        tcantidad+=cantidad;
    }
    
    public double MontoAPagar(){
        return total;
    }
    
    public String ResumenDeCompra(){
        return resumen + " Total a pagar " + MontoAPagar() + " por la compra de " + tcantidad + 
               " productos, donde " + MontoAPagar()  + " es el monto e " + tcantidad +
               " es la cantidad de items";
    }
    
}