/*
* AskRemote.java
* a) Looks up for the remote object
* b) "Makes" the RMI
*/
import java.rmi.Naming; /* lookup */
import java.rmi.registry.Registry; /* REGISTRY_PORT */

import java.io.IOException;
import java.net.SocketTimeoutException;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.File;
import java.nio.ByteBuffer;
import java.rmi.RemoteException;

public class AskRemote {

    private static int limitBytes = 1024;
    private static IfaceRemoteClass remote;

    private static void leer(String origin, String destiny) throws RemoteException {
        /* Lee el archivo origen (servidor) y copia el contenido en el archivo destino (cliente) */

        int totalReadBytes = 0;
        int readBytes = 0;

        /* Comienzo de la lectura */
        try {
            FileOutputStream streamOut = new FileOutputStream(destiny);

            do {
                // Operacion remota de lectura
                byte[] buffer = remote.leer(origin, totalReadBytes, limitBytes);

                // Se transforma de bytes a buffer con el wrap
                ByteBuffer stream = ByteBuffer.wrap(buffer);

                // Se leen los primeros 4 bytes (tamanio del archivo)
                readBytes = stream.getInt();

                if (readBytes > 0) {
                    // Se lee el contenido del archivo 
                    buffer = new byte[readBytes];
                    stream.get(buffer);

                    // Escribe en el archivo destino el contenido recibido
                    streamOut.write(buffer);
                    
                    // Se aumenta el total de bytes leidos sumando el total leido en esta pasada
                    totalReadBytes += readBytes;
                }

            } while(readBytes > 0);
            

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static void escribir(String origin, String destiny) throws RemoteException {
        /* Escribe el contenido del archivo origen (cliente) en el archivo destino (servidor) */

        long totalWrittenBytes = 0;
        int bytesToSend;

        try {
            byte[] bufferOut = new byte[limitBytes];

        
            //  Se elimina el archivo existente con ese nombre y se crea uno nuevo (para eso se manda -1 en cant de bytes)
            
            remote.escribir(destiny, -1, bufferOut);

            // Se comienza a escribir el archivo al final
            
            File fileOrigin = new File(origin);
            long fileLength = fileOrigin.length();

            FileInputStream streamIn = new FileInputStream(origin);

            do {
                // Calculamos bytes a escribir
                long bytesToWrite = fileLength - totalWrittenBytes;

                // Se calculan los bytes a enviar
                  
                if(limitBytes > bytesToWrite){
                    bytesToSend = (int) bytesToWrite;
                }else{
                    bytesToSend = limitBytes;
                }

                // Se lee el archivo
                streamIn.read(bufferOut);

                // Operacion remota de escritura
                totalWrittenBytes = remote.escribir(destiny, bytesToSend, bufferOut);

            } while (totalWrittenBytes < fileLength);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {


        try {
            /* Binding con el remoto */
            String rname = "//localhost:" + Registry.REGISTRY_PORT + "/remote";
            remote = (IfaceRemoteClass) Naming.lookup(rname);

            String operacion = args[0];

            switch (operacion) {
            case "-ejercicio4" :
                /* Verificacion de los parametros */
                if (args.length != 4) {
                    System.err.println("Se necesitan 3 argumentos:");
                    System.err.println("java AskRemote -ejercicio3 archivo_original copia_cliente copia_servidor");

                    System.exit(1);
                }

                String archivoOriginal = args[1];
                String copiaCliente = args[2];
                String copiaServidor = args[3];

                /* Se lee el archivo original desde el servidor y
                 * se guarda en el archivo "copiaCliente" en el cliente.
                 */
                leer(archivoOriginal, copiaCliente);

                /* Se escribe el archivo "copiaCliente" desde el cliente
                 * en el archivo "copiaServidor" del servidor.
                 */
                escribir(copiaCliente, copiaServidor);
                break;

            case "-ejercicio5" :

                if (args.length != 3) {
                    System.err.println("Se necesitan 2 argumentos:");
                    System.err.println("java AskRemote -ejercicio4 archivo_fuente archivo_destino");

                    System.exit(1);
                }

                limitBytes = 5;

                String fuente = args[1];
                String destino = args[2];

                escribir(fuente, destino);
                break;

            case "-ejercicio6a":

                long startTime = System.nanoTime();
                remote.simulacion(); 
                System.out.println(System.nanoTime() - startTime);
                break;
            case "-ejercicio6b":
             
                try {
                    remote.loopInfinito();
                } catch (RemoteException e) {
                    System.err.println("Se supero el tiempo de espera seteado en el responseTimeOut.");
                }
                break;

            default:
                System.err.println("Operacion invalida");
                System.err.println("Especificar: -operacion parametros_de_la_operacion");

            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}