package e6;

public abstract class FiguraGeometrica implements Comparable<FiguraGeometrica>{
    private String color;

    public FiguraGeometrica(String color) {
        this.color = color;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public abstract void dibujar();
    public abstract int area();

    @Override
    public int compareTo(FiguraGeometrica o) {
        if (this.area() > o.area()) return 1;
        if (this.area() == o.area()) return 0;
        return -1;
    }
}
