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
public class Salas {
    
    private int numero,cupo,vendidas;
    private Pelicula p;

    public Salas(int numero, int cupo, int vendidas) {
        this.numero = numero;
        this.cupo = cupo;
        this.vendidas = vendidas;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public int getCupo() {
        return cupo;
    }

    public void setCupo(int cupo) {
        this.cupo = cupo;
    }

    public int getVendidas() {
        return vendidas;
    }

    public void setVendidas(int vendidas) {
        this.vendidas = vendidas;
    }

    public Pelicula getP() {
        return p;
    }

    public void setP(Pelicula p) {
        this.p = p;
    }
    
    public void agregarPelicula(Pelicula pelicula){
        p = pelicula;
    }
    
    public String quePelicula(){
        return p.getNombre();
    }
    
    
}
