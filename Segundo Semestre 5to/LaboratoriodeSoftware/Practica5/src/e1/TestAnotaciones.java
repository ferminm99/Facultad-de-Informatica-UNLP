package e1;

public class TestAnotaciones {

    public static void main(String arg[]) throws Exception{
        new TestAnotaciones().testearYa();
    }

    @SuppressWarnings({"deprecation"})
    public void testearYa(){
        TestDeprecated t2 = new TestDeprecated();
        t2.hacer();
    }

    /*

    a) Cuando se ejecuta TestAnotaciones, se imprime "Testeando: 'Deprecated'".
    b) Cuando se elimina la anotación en cuestión, si bien el resultado de la ejecución es el mismo se nos informa que el método "hacer" está deprecado.
    c) La diferencia está en que cuando anotamos el método testearYa, podemos trabajar en dicho método con métodos deprecados sin ver los warnings. Si anotamos la clase, podemos usar métodos deprecados sin warnings en toda la clase.

     */
}
