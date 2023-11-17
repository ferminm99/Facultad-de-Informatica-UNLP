package test;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class Test {
    public static void main(String[] args) {
        PrintWriter out = null;
        try {
            out = new PrintWriter(new FileWriter("test.txt"));
            for (int i = 0; i < 5; i++) {
                out.println(i);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            if (out != null){
                System.out.println("Cerrando print writer");
                out.close();
            }else{
                System.out.println("print writer no fue abierto");
            }
        }

    }
}
