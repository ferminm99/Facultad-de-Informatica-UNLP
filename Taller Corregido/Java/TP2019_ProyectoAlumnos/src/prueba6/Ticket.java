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
public abstract class Ticket {
    
    private int nro,cantP;
    private String fecha;
    Productos p[];

    public Ticket(int nro, String fecha) {
        this.nro = nro;
        this.fecha = fecha;
        cantP=0;
        p = new Productos[100];
    }

    public int getNro() {
        return nro;
    }

    public void setNro(int nro) {
        this.nro = nro;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
    
    public void cargarProducto(Productos producto){
        p[cantP]=producto;
        cantP++;
    }
    
    public Boolean estaCompleto(){
        Boolean ok = false;
        if(cantP == 100)
            ok=true;
        return ok;
    }
    
    public int verCantDeProds(){
        return cantP;
    }
    
    public abstract double calcularPrecioFinal();
    
    public Boolean abonableConDebito(){
        Boolean ok = false;
        if(calcularPrecioFinal()>200)
            ok=true;
        return ok;
    }
    
    public String mostrarResumen(){
        int i; String mensaje = "",ticket = "";
        ticket = "Ticket numero: " + String.valueOf(getNro()) + ": ";
        for(i=0;i<cantP;i++){
            mensaje += "Descripcion: " + p[i].getDescripcion() + " Codigo: " + p[i].getCodigo() + " Precio: " + p[i].getPrecio() + "||" ;
        }
        mensaje += calcularPrecioFinal();
        return ticket+mensaje;
    }
    
    
    
}
