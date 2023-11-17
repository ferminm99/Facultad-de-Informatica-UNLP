package e6;

public class Rectangulo extends FiguraGeometrica{
    private int ancho;
    private int alto;

    public Rectangulo(String color, int ancho, int alto) {
        super(color);
        this.ancho = ancho;
        this.alto = alto;
    }


    @Override
    public void dibujar() {
        System.out.println("Se dibuja un circulo de ancho " + ancho
                + " alto " + alto
                + " y color " + this.getColor());
    }

    @Override
    public int area() {
        return ancho * alto;
    }

    @Override
    public String toString() {
        return "Rectangulo{" +
                "color=" + this.getColor() +
                ", ancho=" + ancho +
                ", alto=" + alto +
                '}';
    }
}
