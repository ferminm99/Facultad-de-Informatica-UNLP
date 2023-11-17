package com.example.test.entidades;

public class Verdura {

    private int id;
    private String descripcion;
    private String cosecha;
    private String siembra;

    public Verdura(int id, String descripcion, String cosecha, String siembra) {
        this.id = id;
        this.descripcion = descripcion;
        this.cosecha = cosecha;
        this.siembra = siembra;
    }

    public int getId() {
        return id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public String getCosecha() {
        return cosecha;
    }

    public String getSiembra() {
        return siembra;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public void setCosecha(String cosecha) {
        this.cosecha = cosecha;
    }

    public void setSiembra(String siembra) {
        this.siembra = siembra;
    }
}
