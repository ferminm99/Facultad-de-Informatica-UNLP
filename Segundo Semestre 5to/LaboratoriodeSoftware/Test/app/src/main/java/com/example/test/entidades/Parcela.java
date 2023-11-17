package com.example.test.entidades;

public class Parcela {

    private int id;
    private String descripcion;
    private String cubierta;

    public Parcela(String descripcion, String cubierta) {
        this.descripcion = descripcion;
        this.cubierta = cubierta;
    }

    public int getId() { return id; }

    public String getDescripcion() {
        return descripcion;
    }

    public String getCubierta() {
        return cubierta;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setCubierta(String cubierta) {
        this.cubierta = cubierta;
    }

    public void setId(int id) { this.id = id; }
}
