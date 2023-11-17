/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba5;

/**
 *
 * @author fer
 */
public class Teatro {
    
    private String nombre,dueño,direccion;
    private int cantO;
    private Obra[] o;

    public Teatro(String nombre, String dueño, String direccion) {
        this.nombre = nombre;
        this.dueño = dueño;
        this.direccion = direccion;
        cantO=0;
        o = new Obra[5]; 
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

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
    
    public void agregarObra(Obra obra){
        
        o[cantO]=obra;
        cantO++;
        
    }
    
    public String nombreDirector(String obra){
        int i = 0;String director = "";
        while(i<cantO && !o[i].getNombre().equals(obra))
            i++;
        if(i!=cantO){
            director = o[i].getDirector();
        }
            
        return director;
    }
    
    public String obraConMenosActores(){
        int i = 0,min=99999;
        String obra = "";
        while(i<cantO){
            if(min>o[i].cantidadActores()){
                min=o[i].cantidadActores();
                obra = o[i].getNombre();
            }
            i++;
        }
        return obra;
    }
    
    public String dondeActua(String nombre, String apellido){
        int i = 0;String obra = "";
        while(i<cantO && !o[i].dondeActua(nombre, apellido))
            i++;                 
        if(i!=cantO)
            obra = o[i].getNombre();
        return obra;
    }
    
    public String actorMasViejo(){
        int i = 0,j = 0,max = -1;String nombreC = "";
        while(i<cantO){
            j=0;
            if(j<o[i].cantidadActores()){
                if(max<o[i].getA()[j].getEdad()){
                    max = o[i].getA()[j].getEdad();
                    nombreC = o[i].getA()[j].getNombre() + " " + o[i].getA()[j].getApellido();
                }
                j++;
            }
            i++;
        }
        return nombreC;
    }
    
    public Boolean estaLleno(){
        Boolean ok = false;
        if(cantO == 5)
            ok= true;
        return ok;
    }
    
    public Boolean estaLlenoA(){
        return o[cantO].estaLleno();
    }
            
}
