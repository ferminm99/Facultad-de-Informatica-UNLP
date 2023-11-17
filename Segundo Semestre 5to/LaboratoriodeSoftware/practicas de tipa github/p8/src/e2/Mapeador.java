package e2;

import java.io.FileWriter;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;

public class Mapeador {

    public void beanToFile(Object object){
        try {
            Class myClass = object.getClass();
            for(Annotation a : myClass.getAnnotations()){
                if(a.annotationType() == Archivo.class){
                    Archivo archivo = (Archivo) a;
                    FileWriter fileWriter = this.createFileWriter(archivo.nombre());
                    this.appendToFileWriter("<nombreClase>"+myClass.getName()+"</nombreClase>", fileWriter);
                    for(Field field : myClass.getDeclaredFields()){
                        for(Annotation an : field.getDeclaredAnnotations()){
                            if(an.annotationType() == AlmacenarAtributo.class){
                                field.setAccessible(true);
                                this.appendToFileWriter("<nombreAtributo>"+field.getName()+"</nombreAtributo>", fileWriter);
                                this.appendToFileWriter("<nombreValor>"+field.get(object)+"</nombreValor>", fileWriter);
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

    public FileWriter createFileWriter(String fileName) throws IOException {
        return new FileWriter(fileName, true);
    }

    public void appendToFileWriter(Object obj, FileWriter fileWriter) throws IOException {
        fileWriter.write(obj.toString());
        fileWriter.write("\n");
    }

    public static void main(String[] args){
        Mapeador mapeador = new Mapeador();
        mapeador.beanToFile(new Mapeado());
    }
}
