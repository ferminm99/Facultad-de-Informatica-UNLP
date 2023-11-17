/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba2;

/**
 *
 * @author fer
 */
public class Discografica {
    
    private String nombre,dueño,ciudad;
    private int cantS,cantB;
    private Solistas[] s;
    private Bandas[] b;
    
    public Discografica(String nombre, String dueño, String ciudad) {
        this.nombre = nombre;
        this.dueño = dueño;
        this.ciudad = ciudad;
        
        cantS = 0;cantB = 0;
        s = new Solistas[50];
        b = new Bandas[50];
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDueño() {
        return dueño;
    }

    public void setDueño(String dueño) {
        this.dueño = dueño;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public Solistas[] getS() {
        return s;
    }

    public void setS(Solistas[] s) {
        this.s = s;
    }
    
    public void agregarSolista(Solistas solista){
        s[cantS] = solista;
        cantS++;
    }
    
    public void agregarBandas(Bandas banda){
        b[cantB] = banda;
        cantB++;
    }
    
    public int cantBandas(){
        return cantB;
    }
    
    public int cantArtistasQueTocanI(String instrumento){
        int i = 0,cant = 0;
        while(i<cantS){
            if(s[i].getInstrumento().equals(instrumento)){
                cant++;
            }
            i++;
        }
        return cant;    
        
    }
    
    public String bandaConMasIntegrantes(){
        int i = 0,max=0;
        String n = "";
        while(i<cantS){
            if(max<b[i].getIntegrantes()){
                max=b[i].getIntegrantes();
                n = b[i].getNombre();
            }
            i++;
        }
        return n;
    }
    
    public int cantBMismaCiudad(){
        int i = 0,cant=0;
        while(i<cantS){
            if(getCiudad().equals(b[i].getCiudad())){
                cant++;
            }
            i++;
        }
        return cant;
    }
        
    public Boolean estaLleno(){
        Boolean ok = false;
        if(cantS == 50 || cantB == 50)
            ok=true;
        return ok;
    }
    
}
