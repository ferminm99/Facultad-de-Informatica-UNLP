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
public class Solistas {
    
    private String nombre,instrumento;
    private int temas;

    public Solistas(String nombre, String instrumento, int temas) {
        this.nombre = nombre;
        this.instrumento = instrumento;
        this.temas = temas;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getInstrumento() {
        return instrumento;
    }

    public void setInstrumento(String instrumento) {
        this.instrumento = instrumento;
    }

    public int getTemas() {
        return temas;
    }

    public void setTemas(int temas) {
        this.temas = temas;
    }
    
    
    
}
