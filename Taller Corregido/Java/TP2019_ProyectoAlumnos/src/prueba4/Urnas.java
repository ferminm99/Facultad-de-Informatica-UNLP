/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba4;

/**
 *
 * @author fer
 */
public class Urnas {
    
    private int positivas,negativas;

    public Urnas() {
        positivas = 0;
        negativas = 0;
    }

    public int getPositivas() {
        return positivas;
    }

    public void setPositivas() {
        positivas++;
    }

    public int getNegativas() {
        return negativas;
    }

    public void setNegativas() {
        negativas++;
    }

    @Override
    public String toString() {
        return positivas+"|"+negativas;
    }
    
}
