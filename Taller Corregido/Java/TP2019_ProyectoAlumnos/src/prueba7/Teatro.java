/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package prueba7;

/**
 *
 * @author fer
 */
public class Teatro {
    
    private String titulo,fecha,hora;
    private Espectadores[][] e;
    private int[] butacasO;
   

    public Teatro(String titulo, String fecha,String hora) {
        this.titulo = titulo;
        this.fecha = fecha;
        this.hora = hora;
        e = new Espectadores[20][10]; 
        butacasO = new int[20];
        int i;
        for(i=0;i<20;i++)
            butacasO[i]=0;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }
    
    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }
    
    public Boolean validarFila(int f){
        Boolean ok = false;
        if(f>=0 && f<20)
            ok=true;
        return ok;
    }
    
    public Boolean hayButacaLibreEnFila(int f){
        Boolean ok = false;
        if(butacasO[f]<10){
            ok=true;
        }
        return ok;
    }
    
    public int agregarEspectadorAlaFila(Espectadores espectador,int f){
        e[f][butacasO[f]]=espectador;
        butacasO[f]++;
        return butacasO[f];
    }
        
    public int calcularButacasLibres(){
        int i= 0,bOcupadas = 0;
        for(i=0;i<20;i++){
            bOcupadas+=butacasO[i];
        }
        return (200-bOcupadas);
    }
    
    public int calcularEdadPromEspectadores(){
        int i,j,totalP = 0,totalE = 0;
        for(i=0;i<20;i++){
            for(j=0;j<butacasO[i];j++){
                totalP++;
                totalE+=e[i][j].getEdad();
            }
        }
        return (totalE/totalP);
    }
    
    public Boolean estaRegistradoEspectador(int d){
        int i = 0,j;
        Boolean ok = false;
        while(i<20 && !ok){
            j=0;
            while(j<butacasO[i]){
                if(e[i][j].getDni()==d){
                    ok=true;
                }
                j++;
               
            }
            i++;
        }
        return ok;
    }
    
}
