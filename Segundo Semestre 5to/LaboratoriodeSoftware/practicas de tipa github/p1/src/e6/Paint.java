package e6;

public class Paint {
    private FiguraGeometrica[] paleta;

    public Paint(FiguraGeometrica[] paleta) {
        this.paleta = paleta;
    }

    public Paint(){

    }

    public FiguraGeometrica[] getPaleta() {
        return paleta;
    }

    public void setPaleta(FiguraGeometrica[] paleta) {
        this.paleta = paleta;
    }

    public void init(){
        Circulo c1 = new Circulo("Azul", 2);
        Circulo c2 = new Circulo("Amarillo", 3);
        Rectangulo r1 = new Rectangulo("Verde", 3, 2);
        Rectangulo r2 = new Rectangulo("Rojo", 10, 4);
        FiguraGeometrica[] a = {c1,c2,r1,r2};
        this.setPaleta(a);

    }
}
