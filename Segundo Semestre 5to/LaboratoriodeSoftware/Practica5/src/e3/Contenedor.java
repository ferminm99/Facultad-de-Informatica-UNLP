package e3;

import com.sun.net.httpserver.Headers;
import com.sun.net.httpserver.HttpExchange;
import com.sun.net.httpserver.HttpHandler;
import com.sun.net.httpserver.HttpServer;

import java.io.IOException;
import java.io.OutputStream;
import java.lang.reflect.Method;
import java.net.InetSocketAddress;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Contenedor {
    public static void main(String[] args) {
        ClaseCualquiera cc = new ClaseCualquiera();
        try {
            proccess(cc);
        } catch (Exception e) {
            e.getMessage();
        }
    }
    
    private static void proccess(Object object) throws NotAServerException{
        Class myClass = object.getClass();
        Servidor servidor = (Servidor) myClass.getAnnotation(Servidor.class);
        if (servidor == null) throw new NotAServerException();
        List<Method> methodList = getMethodsToInvoke(myClass);

        // crear log file

        // escuchar en direccion y puerto de la annotation
        try {
            startServer(servidor.direccion(), servidor.puerto(), methodList, object);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private static void startServer(String direccion, int puerto, List<Method> methodList, Object object) throws IOException{
        HttpServer server = HttpServer.create(new InetSocketAddress(direccion,puerto), 0);
        server.createContext("/", new MyHandler(methodList, object));
        server.setExecutor(null); // creates a default executor
        server.start();
    }

    private static List<Method> getMethodsToInvoke(Class myClass) {
        List<Method> methodList = new ArrayList<>();
        for (Method method : myClass.getDeclaredMethods()) {
            if (method.isAnnotationPresent(Invocar.class)) methodList.add(method);
        }
        return methodList;
    }






    static class MyHandler implements HttpHandler {
        List<Method> methodList;
        Object object;

        public MyHandler(List<Method> methodList, Object object) {
            this.methodList = methodList;
            this.object = object;
        }

        // maneja los requests
        @Override
        public void handle(HttpExchange t){
            try {
                sendHttpResponse(t);
                invokeMethods();
                updateLog(t);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        private void updateLog(HttpExchange t) {
            // TODO hacer lo de escribir en un archivo
            Headers headers = t.getRequestHeaders();
            Object host = headers.get("Host");
            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            Date date = new Date();
            System.out.println("DATE: " + dateFormat.format(date) + ", HOST: " + host + "\n");

        }

        private void invokeMethods() throws Exception{
            for (Method method : methodList) {
                method.invoke(object);
            }
        }

        private void sendHttpResponse(HttpExchange t) throws IOException {
            String response = "This is the response";
            t.sendResponseHeaders(200, response.length());
            OutputStream os = t.getResponseBody();
            os.write(response.getBytes());
            os.close();
        }
    }
}
