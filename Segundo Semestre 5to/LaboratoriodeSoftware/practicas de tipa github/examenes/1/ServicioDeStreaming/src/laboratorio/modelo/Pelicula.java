package laboratorio.modelo;

import java.util.ArrayList;

public class Pelicula {

    private ArrayList<Genero> generos;
    private EdadEspectador edadEspectador;
    private double valoracion;
    private Integer cantReproducciones;
    private String titulo,pais;
    private Integer año;

    public Pelicula(ArrayList<Genero> generos, EdadEspectador edadEspectador, double valoracion, Integer cantReproducciones, String titulo, String pais, Integer año) {
        this.generos = generos;
        this.edadEspectador = edadEspectador;
        this.valoracion = valoracion;
        this.cantReproducciones = cantReproducciones;
        this.titulo = titulo;
        this.pais = pais;
        this.año = año;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getPais() {
        return pais;
    }

    public void setPais(String pais) {
        this.pais = pais;
    }

    public Integer getAño() {
        return año;
    }

    public void setAño(Integer año) {
        this.año = año;
    }

    public ArrayList<Genero> getGeneros() {
        return generos;
    }

    public EdadEspectador getEdadEspectador() {
        return edadEspectador;
    }

    public double getValoracion() {
        return valoracion;
    }

    public Integer getCantReproducciones() {
        return cantReproducciones;
    }

    public void setGeneros(ArrayList<Genero> generos) {
        this.generos = generos;
    }

    public void setEdadEspectador(EdadEspectador edadEspectador) {
        this.edadEspectador = edadEspectador;
    }

    public void setValoracion(double valoracion) {
        this.valoracion = valoracion;
    }

    public void setCantReproducciones(Integer cantReproducciones) {
        this.cantReproducciones = cantReproducciones;
    }

    public boolean addGenero(Genero g){
        return this.generos.add(g);
    }

    public boolean removeGenero(Genero g){
       return this.generos.remove(g);
    }

    @Override
    public String toString() {
        return titulo + ":" + pais + ":"  + año + ":" + generos + ":" + edadEspectador + ":" + valoracion + ":" + cantReproducciones ;
    }
}
