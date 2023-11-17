package e2;

import java.util.Scanner;
import static java.lang.Math.pow;

public class InnerStatic {
    static double PI= 3.1416;

    static class Circulo{
        static double radio;
        static double getArea(){
            Scanner input = new Scanner(System.in);
            System.out.println("Ingrese el radio del circulo");
            setRadio(input.nextInt());
            System.out.println("Ingresaste: " + radio);
            double a = PI * pow(radio, 2);
            System.out.println("El area es " + a);
            return a;
        }
        static double getLongCircunference(){
            double l = 2 * PI * radio;
            System.out.println("la longitud es: "  + l);
            return  l;
        }

        public static void setRadio(double radio) {
            Circulo.radio = radio;
        }
    }


}
