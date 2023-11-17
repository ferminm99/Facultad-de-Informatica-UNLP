/*
* RemoteClass.java
* Just implements the RemoteMethod interface as an extension to
* UnicastRemoteObject
*
*/
/* Needed for implementing remote method/s */
import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import java.io.FileOutputStream;
import java.io.File;

import java.nio.ByteBuffer;

/* This class implements the interface with remote methods */
public class RemoteClass extends UnicastRemoteObject implements IfaceRemoteClass {
    public static int PROCESAMIENTO = 1000;

    protected RemoteClass() throws RemoteException {
        super();
    }

    public byte[] leer(String name, int position, int totalReadBytes) throws RemoteException {

        FileInputStream stream = null;

        int readBytes = 0;
        byte[] fileContent = null;

        ByteBuffer buffer = null;

        try {
            stream = new FileInputStream(name);
            
            fileContent = new byte[totalReadBytes];
            // Se mueve a la posicion desde la que se va a leer el archivo
            stream.skip(position);

            // Se lee el archivo
            readBytes = stream.read(fileContent, 0, totalReadBytes); 

            // Aloca el tamanio para la cantidad de bytes leidos y el contenido del archivo
            buffer = ByteBuffer.allocate(totalReadBytes + 4);

            // Se colocan la cantidad de bytes leidos en los primeros 4 bytes
            buffer.putInt(readBytes);

            //Se coloca el contenido del archivo en lo que queda
            buffer.put(fileContent);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return buffer.array();
    }

    public long escribir(String name, int totalBytes, byte[] data) throws RemoteException {

        FileOutputStream stream = null;
        File file = null;

        try {
            file = new File(name);

            /*
               Si se mando -1 como cantidad de bytes se elimina el contenido del archivo para escribirlo desde 0,
               sino se agrega al final.
            */
            if (totalBytes == -1) {
                stream = new FileOutputStream(file);
            } else {
                stream = new FileOutputStream(file, true);

                // Escribimos en el archivo
                stream.write(data, 0, totalBytes);
            }

            stream.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return file.length();
    }

    public void simulacion() throws RemoteException {
    }

    public void loopInfinito() throws RemoteException {
        try {
            System.out.println("Se conecta el cliente");
            while (true) {
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}