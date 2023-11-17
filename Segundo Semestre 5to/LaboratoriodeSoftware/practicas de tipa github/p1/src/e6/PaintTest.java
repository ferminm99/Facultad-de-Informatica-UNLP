package e6;
import java.util.Arrays;
import java.util.Collections;
public class PaintTest {
    public static void main(String[] args) {
        Paint p = new Paint();
        p.init();
        FiguraGeometrica[] fg = p.getPaleta();
//      Arrays.sort(fg, Collections.reverseOrder());
        Arrays.sort(fg);

        for (int i = 0; i < fg.length; i++) {
            FiguraGeometrica f = fg[i];
            System.out.println(f + " -----------------------> AREA " + f.area());
            if (f instanceof Circulo ) {
                Circulo casted = (Circulo)f;
                System.out.println("                             ----> con radio " + casted.getRadio());
            }
        }
    }
}
