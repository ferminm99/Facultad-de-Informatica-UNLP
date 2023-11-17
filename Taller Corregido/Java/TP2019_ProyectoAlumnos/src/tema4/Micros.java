/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4;

/**
 *
 * @author Alumno
 */
public class Micros {
    
    private String patente;
    private String destino;
    private String hs;
    Boolean vector[] = new Boolean[20];
    private int ocupados = 0; 
    private Boolean estalleno = false;
    
    public Micros(String patente, String destino, String hs) {
        this.patente = patente;
        this.destino = destino;
        this.hs = hs;
        int i;
        for (i=0;i<20;i++){
            vector[i]=false;
        }
    }

    public Boolean devolver(int num){
        Boolean bool;
        bool = vector[num];
        return bool;
    }
    
    public void primerAsientoD(){
        int i = 0;
        while(vector[i]){
            i++;
        }
        if(!vector[i]){
            System.out.println("El primer asiento desocupado es: " + ocupados);
        }
    }
    
    public Boolean validar(int num){ 
        Boolean valido = false;
        if(num<20 && num>=0){
           valido= true; 
        }
        return valido;
    }
    
    public void Ocupar(int num){
         vector[num]=true;
         ocupados++;
    }
    
    public void Desocupar(int num){
         vector[num]=false;
         ocupados--;
    }

    public int getOcupados() {
        return ocupados;
    }
    
    public Boolean getLleno(){
        int recorrer=0;
        
        while(recorrer<20 && vector[recorrer]){
            recorrer++;
        }
        if(recorrer==20){
            estalleno=true;
        }
      
        return estalleno;
    }

    
    public String getPatente() {
        return patente;
    }

    public void setPatente(String patente) {
        this.patente = patente;
    }

    public String getDestino() {
        return destino;
    }

    public void setDestino(String destino) {
        this.destino = destino;
    }

    public String getHs() {
        return hs;
    }

    public void setHs(String hs) {
        this.hs = hs;
    }
    
    
    
}