/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tema4;

/**
 *
 * @author henry
 */
public class Flota {
    private Micros [] m = new Micros[15];
    private int cantM;

    public Flota (){
        int i;
        for (i=0;i<15;i++)
            m[i] = null;
        cantM = 0;
    }
    public boolean SiEstaLleno (){
        
        boolean ok = false;
        if (cantM ==15)
            ok = true;
        return ok;
    }

    public void agregarMicro(Micros unMicro){
        int i = 0;
        while (m[i]!= null)
            i++;
        m[i] = unMicro;
        cantM++;
    }
 
    public boolean eliminarMicro (String unaPatente){
        int i = 0,j ;
        boolean ok;
        while (i<cantM && !m[i].getPatente().equals(unaPatente)){
            i++;
        }    
        if (cantM==15){
            ok = false;
        }    
        else{
            ok = true;
            for (j=i;j<cantM-1;j++){
                m[j]=m[j+1];
            }
            
            m[cantM] = null;
            cantM--;
            
        }    
        return ok;
    }
     
    public Micros buscarMicro (String unaPatente){
        Micros m2;
        int i = 0;
        while (i<cantM && !m[i].getDestino().equals(unaPatente)){
            i++;
        }
        if (cantM==15){
            m2 = null;
        }     
        else{
            m2 = m[i];
        }     
        return m2;
    }
    
    public Micros buscarMicroD (String unDestino){
        Micros m2;
        int i = 0;
        while (i<cantM && !m[i].getDestino().equals(unDestino)){
            i++;
        }
        if (cantM==15){
            m2 = null;
        }     
        else{
            m2 = m[i];
        }     
        return m2;
    }
    
    public Micros[] getM() {
        return m;
    }

    public void setM(Micros[] m) {
        this.m = m;
    }

    public int getCantM() {
        return cantM;
    }

    public void setCantM(int cantM) {
        this.cantM = cantM;
    }
    
}