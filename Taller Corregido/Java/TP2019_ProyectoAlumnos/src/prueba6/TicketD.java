/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba6;

/**
 *
 * @author fer
 */
public class TicketD extends Ticket{
    
    private double descuento;
    
    public TicketD(int nro, String fecha,double descuento) {
        super(nro,fecha);
        this.descuento = descuento;
    } 
    
    public double calcularPrecioFinal(){
        int i;
        double suma = 0;
        for(i=0;i<verCantDeProds();i++){
            suma+=p[i].getPrecio();
        }
        return suma*((100-descuento)/100);
    }
    
    public double calcularAhorroFinal(){
        int i;
        double suma = 0;
        for(i=0;i<verCantDeProds();i++){
            suma+=p[i].getPrecio();
        }
        return (suma-(suma*((100-descuento)/100)));
    }

    @Override
    public String mostrarResumen() {
        return super.mostrarResumen() + " Ahorro final: " + calcularAhorroFinal();
    }

    
  
}
