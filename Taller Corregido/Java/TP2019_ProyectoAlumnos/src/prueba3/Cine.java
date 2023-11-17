/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba3;

/**
 *
 * @author fer
 */
public class Cine {
    
    private String nombre,dueño,direccion;
    private int cantS;
    private Salas[] s;

    public Cine(String nombre, String dueño, String direccion) {
        this.nombre = nombre;
        this.dueño = dueño;
        this.direccion = direccion;
        cantS=0;
        s = new Salas[5];
            
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

    public Salas[] getS() {
        return s;
    }

    public void setS(Salas[] s) {
        this.s = s;
    }
    
    public void agregarSala(Salas sala){      
        s[sala.getNumero()]=sala;
        cantS++;       
    }
    
    public Boolean salaExiste(int sala){
        Boolean ok = false;
        if(s[sala]!=null)
            ok=true;
        return ok;
    }
    
    public void comprarEntrada(int sala){
        s[sala].setVendidas(s[sala].getVendidas()+1);
    }
    
    public void devolverEntrada(int sala){
        s[sala].setVendidas(s[sala].getVendidas()-1);
    }
    public Boolean quedanEntradas(int n){
        Boolean ok =false;
        if(s[n].getVendidas()<s[n].getCupo() && s[n].getVendidas()>0){
            ok=true;
        }         
        return ok;
    }
    
    public int dondeSeProyecta(String peli){
        int i=0,donde = -1;Boolean ok = true;
        while(i<5 && ok){
            if(s[i]!=null){
                if(s[i].quePelicula().equals(peli)){
                    donde=i;
                    ok=false;
                }
            }
            i++;
        }
        return donde;
    }
    
    public int salaConMasVendidas(){
        int i=0,donde = 0,max=0;
        while(i<5){
            if(s[i]!=null){
                if(max<s[i].getVendidas()){
                    max=s[i].getVendidas();
                    donde=i;
                }
            }      
            i++;
        }
            
        return donde;
    }
    
    public String peliQueMasVendio(){
        int i=0,max=0;
        String peli = "";
        while(i<5){
            if(s[i]!=null){
                if(max<s[i].getVendidas()){
                    max=s[i].getVendidas();
                    peli=s[i].quePelicula();
                }
            }
            
            i++;
        }
            
        return peli;
    }
    
    public Boolean sePuede(int n){
        Boolean ok = false;
        if(n>=0 && n<5)
            ok=true;
        return ok;
    }
    
    public int cantidadS(){
        return cantS;
    }
    
}
