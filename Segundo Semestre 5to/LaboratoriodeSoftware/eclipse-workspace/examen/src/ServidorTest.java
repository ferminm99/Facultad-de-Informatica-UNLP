import java.util.List;

public class ServidorTest {
    public static void main(String[] args) {
        // probar server
        SCM.iniciar();

        // CASO FELIZ: probamos Creador de Melodias con la clase MelodiaDePrueba
        System.out.println("* Caso feliz:");
        List list = CreadorDeMelodias.crearNotasYDuraciones(MelodiaDePrueba.class,5);
        System.out.println(list);

        // CASOS TRISTES: cuando no se puede crear la melodia
        System.out.println("* Casos tristes:");
        // probamos Creador de Melodias con una clase a partir de la que no se pueda crear una melodia
        List list2 = CreadorDeMelodias.crearNotasYDuraciones(NoMelodiaDePrueba1.class,5);

        // probamos Creador de Melodias con una clase a partir de la que no se pueda crear una melodia
        List list3 = CreadorDeMelodias.crearNotasYDuraciones(NoMelodiaDePrueba2.class,5);

    }
}
