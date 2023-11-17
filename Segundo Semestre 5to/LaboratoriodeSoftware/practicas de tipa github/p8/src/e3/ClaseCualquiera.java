package e3;

@Servidor(direccion = "localhost", archivo = "test.txt", puerto = 8080)
public class ClaseCualquiera {
    @Invocar
    public static void toBeInvoked(){
        System.out.println("Me invocaron! Eso significa que hay una petición :)");
    }

    @Invocar
    public static void anotherToBeInvoked(){
        System.out.println("A mi también me invocaron!");
    }

    public static void notToBeInvoked(){
        System.out.println("A mi nadie me llama :(");
    }
}
