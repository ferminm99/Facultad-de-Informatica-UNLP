package e5;

public class Suma {
    public static void main(String[] args){
        int suma=0;
        for(int i=0;i<args.length;i++){
            try {
                suma += Integer.parseInt(args[i]);
            } catch (NumberFormatException e) {
                System.out.println("Param not added: " + e.getMessage());
            }
        }
        System.out.print("La suma es:" + suma);
    }
}
