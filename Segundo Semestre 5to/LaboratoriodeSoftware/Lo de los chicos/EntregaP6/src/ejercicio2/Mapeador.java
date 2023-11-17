package ejercicio2;

import java.io.FileWriter;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;

public class Mapeador {
	public void beanToFile(Object object){
        try {
            Class myClass = object.getClass();
            for(Annotation a : myClass.getAnnotations()){
                if(a.annotationType() == Archivo.class){
                    Archivo archivo = (Archivo) a;
					FileWriter fileWriter = new FileWriter(archivo.nombre());
                    fileWriter.write("<nombreClase>"+myClass.getSimpleName()+"</nombreClase>\n");
                    for(Field field : myClass.getDeclaredFields()){
                        for(Annotation an : field.getDeclaredAnnotations()){
                            if(an.annotationType() == AlmacenarAtributo.class){
                                field.setAccessible(true);
                                fileWriter.write("<nombreAtributo>"+field.getName()+"</nombreAtributo>\n");
                                fileWriter.write("<nombreValor>"+field.get(object)+"</nombreValor>\n");
                            }
                        }
                    }
                    fileWriter.close();
                }
            }
        }catch(Exception e) {
            System.out.println(e.getMessage());
            e.printStackTrace();
        }
    }
	
	public static void main(String[] args){
        Mapeador mapeador = new Mapeador();
        mapeador.beanToFile(new Mapeado());
    }
}
