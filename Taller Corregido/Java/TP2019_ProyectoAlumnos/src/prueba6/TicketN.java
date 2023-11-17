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
public class TicketN extends Ticket{

    public TicketN(int nro, String fecha) {
        super(nro,fecha);
        
    } 
    
    public double calcularPrecioFinal(){
        int i;
        double suma = 0;
        for(i=0;i<verCantDeProds();i++){
            suma+=p[i].getPrecio();
        }
        return suma;
    }

    @Override
    public String mostrarResumen() {
        return super.mostrarResumen(); //To change body of generated methods, choose Tools | Templates.
    }
 
}
