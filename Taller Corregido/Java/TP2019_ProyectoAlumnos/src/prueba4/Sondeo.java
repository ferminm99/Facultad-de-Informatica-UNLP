/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba4;


/**
 *
 * @author fer
 */
public class Sondeo {
    
    private String pregunta;
    private Urnas[][] u;
    private static int c = 3,s = 4;

    public Sondeo(String pregunta) {
        this.pregunta = pregunta;
        
        u = new Urnas[c][s];
        int i,j;
        for (i=0;i<c;i++){
            for(j=0;j<s;j++){
                u[i][j] = new Urnas();
            }
        }
        
    }

    public String getPregunta() {
        return pregunta;
    }
    
    public Boolean validarCliente(int cliente){
        Boolean ok = false;
        if(cliente>=0 && cliente<c)
            ok=true;
        return ok;
    }
    
    public Boolean validarSucursal(int sucursal){
        Boolean ok = false;
        if(sucursal>=0 && sucursal<s)
            ok=true;
        return ok;
    }
    
    public Urnas devolverUrna(int cliente, int sucursal){
        return u[cliente][sucursal];
    }
    
    public String imprimirUrnas(){
        int i,j;
        
        String imp = "";
        for (i=0;i<c;i++){
            for(j=0;j<s;j++){
                imp+= "Cliente numero: "+i+" Sucursal numero: "+j+ " (" +u[i][j].toString()+")" + " ";
            }
        }
        return imp;
    }

    public int sucursalGanadora(){
        int i,max=-1,j,sGanadora=-1,suma;
        
        for(i=0;i<s;i++){
            suma = sucursalSuma(i);
            if(max<suma){
                max=suma;
                sGanadora = i;
            }
        }
        return sGanadora;
    }
    
    public int clienteMasExigente(){
        int i,max=-1,j,clienteE=-1,suma;
        
        for(i=0;i<c;i++){
            suma = clientesSuma(i);
            if(max<suma){
                max=suma;
                clienteE = i;
            }
        }
        return clienteE;
    }
    
    public int sucursalSuma(int j){
        int i,suma=0;
    
        for (i=0;i<c;i++){
            suma+=u[i][j].getPositivas();
        }
        return suma;
    }
    
    public int clientesSuma(int j){
        int i,suma=0;
    
        for (i=0;i<s;i++){
            suma+=u[j][i].getNegativas();
        }
        return suma;
    }
    
    
}
