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
public class Autor {
    
    private String nombre;
    private String biografia;

    public Autor(String nombre1, String biografia2) {
        nombre = nombre1;
        biografia = biografia2;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getBiografia() {
        return biografia;
    }

    public void setBiografia(String biografia) {
        this.biografia = biografia;
    }

    @Override
    public String toString() {
        return "Autor{" + "nombre=" + nombre + ", biografia=" + biografia + '}';
    }
    
    
    
}