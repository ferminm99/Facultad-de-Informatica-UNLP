/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba1;

/**
 *
 * @author fer
 */
public class Bandas {
    
    private String nombre,ciudad,estilo;
    private int cantD;
    private Disco d[];

    public Bandas(String nombre, String ciudad, String estilo) {
        this.nombre = nombre;
        this.ciudad = ciudad;
        this.estilo = estilo;
        cantD = 0;

        d = new Disco[20];
        
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCiudad() {
        return ciudad;
    }

    public void setCiudad(String ciudad) {
        this.ciudad = ciudad;
    }

    public String getEstilo() {
        return estilo;
    }

    public void setEstilo(String estilo) {
        this.estilo = estilo;
    }

    public Disco[] getD() {
        return d;
    }

    public void setD(Disco[] d) {
        this.d = d;
    }
    
    public int cantDiscos(){
        return cantD;
    }
    
    public void agregarDisco(Disco disco){
        d[cantD]=disco;
        cantD++;
    }
    
    public int duracionDisco(String nombreD, String nombreC){
        int i = 0,duracion = 0;
        while(i<cantD && !d[i].getNombre().equals(nombreD))
            i++;
        if(i!=cantD){
            duracion = d[i].buscarCancion(nombreC);
        }
        return duracion;
    }
    
    public String temaMasLargo(){
        int i=0,j,max=-1;
        String nom = "";
        while(i<cantD){
            j=0;
            while(j<d[i].cantCanciones()) {
                if(max<d[i].getC()[j].getDuracion()){
                    max=d[i].getC()[j].getDuracion();
                    nom=d[i].getC()[j].getNombre();
                }
                j++;
            }
            i++;
        } 
        return nom;       
    }   
    
    public Boolean estaLleno(){
        Boolean ok = false;
        if(cantD == 20)
            ok=true;
        return ok;
    }
     
    public Boolean estaCLleno(){
        return d[cantD].estaLleno();
    }
    
    public int cantTemasDiscoViejo(){
        int i=0,min=2020,temas = 0;
        
        while(i<cantD){
            if(min>d[i].getFecha()){
                min=d[i].getFecha();
                temas = d[i].cantCanciones();
            }
            i++;
        }
        return temas;
        
    }
    
   
    
}
