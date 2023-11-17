import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

public class CreadorDeMelodias {
    public static <T> List crearNotasYDuraciones(Class<T> elClass, int cant){
        List list = null;
        Melodia melodia = (Melodia) elClass.getAnnotation(Melodia.class);
        try {
            if (melodia == null) {
                throw new NoEsUnaMelodiaException();
            }else{
                list= armarLista(elClass, cant);
            }
        } catch (NoEsUnaMelodiaException e) {
                e.printStackTrace();
        }
        return list;
    }



    // arma y devuelve la lista con instancias de MelodiaDePrueba con campos escala y duracion aleatorios
    private static <T> List armarLista(Class<T> elClass, int cant) throws NoEsUnaMelodiaException {
        List list = new ArrayList();
        for (int i = 0; i < cant; i++) {
            ParOrdenado<String, String> par = armarPar(elClass);
            list.add(new MelodiaDePrueba(par.getA(), par.getB()));
        }
        return list;
    }


    // genera el par nota-duracion y lo devuelve
    private static <T> ParOrdenado<String, String> armarPar(Class<T> elClass) throws NoEsUnaMelodiaException {
        Escala escala = null;
        Duracion duracion = null;
        for (Field declaredField : elClass.getDeclaredFields()) {
            if (declaredField.isAnnotationPresent(Escala.class)) {
                escala = declaredField.getAnnotation(Escala.class);
            }else {
                if (declaredField.isAnnotationPresent(Duracion.class)){
                    duracion = declaredField.getAnnotation(Duracion.class);
                }else {
                    throw new NoEsUnaMelodiaException();
                }
            }
        }
        return new ParOrdenado<String, String>(randomElementFor(escala.value()), randomElementFor(duracion.value()));
    }



    // devuelve un elemento random de un arreglo parametrizado
    private static <T> T randomElementFor(T[] arreglo) {
        Random generator = new Random();
        int randomIndex = generator.nextInt(arreglo.length);
        return arreglo[randomIndex];
    }


}
