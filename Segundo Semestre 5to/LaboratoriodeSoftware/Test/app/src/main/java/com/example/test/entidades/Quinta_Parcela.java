package com.example.test.entidades;

public class Quinta_Parcela {

    private int id;
    private int idQuinta;
    private int idParcela;
    private int idVerdura;
    private int cantidadSurcos;
    private double superficieParcela;

    public Quinta_Parcela(int id, int idQuinta, int idParcela, int idVerdura, int cantidadSurcos, double superficieParcela) {
        this.id = id;
        this.idQuinta = idQuinta;
        this.idParcela = idParcela;
        this.idVerdura = idVerdura;
        this.cantidadSurcos = cantidadSurcos;
        this.superficieParcela = superficieParcela;
    }

    public int getId() {
        return id;
    }

    public int getIdQuinta() {
        return idQuinta;
    }

    public int getIdParcela() {
        return idParcela;
    }

    public int getIdVerdura() {
        return idVerdura;
    }

    public int getCantidadSurcos() {
        return cantidadSurcos;
    }

    public double getSuperficieParcela() {
        return superficieParcela;
    }

    public void setId(int id) {
        this.id = id;
    }

    public void setIdQuinta(int idQuinta) {
        this.idQuinta = idQuinta;
    }

    public void setIdParcela(int idParcela) {
        this.idParcela = idParcela;
    }

    public void setIdVerdura(int idVerdura) {
        this.idVerdura = idVerdura;
    }

    public void setCantidadSurcos(int cantidadSurcos) {
        this.cantidadSurcos = cantidadSurcos;
    }

    public void setSuperficieParcela(double superficieParcela) {
        this.superficieParcela = superficieParcela;
    }
}
