/*
 * Client.java
 * Just sends stdin read data to and receives back some data from the server
 *
 * usage:
 * java Client serverhostname port
 */
import java.io.*;
import java.net.*;
import java.lang.Math;
import checksum.MD5Checksum;


public class Client
{

    public static void main(String[] args) throws IOException
    {
        byte[] buffer;
        byte[] checksum;

        int bufferSize;
        long startTime;

        /* Check the number of command line parameters */
        if ((args.length != 2) || (Integer.valueOf(args[1]) <= 0) )
        {
            System.out.println("2 arguments needed: serverhostname port");
            System.exit(1);
        }

        /* The socket to connect to the echo server */
        Socket socketwithserver = null;

        try /* Connection with the server */
        {
            socketwithserver = new Socket(args[0], Integer.valueOf(args[1]));
        }
        catch (Exception e)
        {
            System.out.println("ERROR connecting");
            System.exit(1);
        }

        /* Streams from/to server */
        DataInputStream  fromserver;
        DataOutputStream toserver;

        /* Streams for I/O through the connected socket */
        fromserver = new DataInputStream(socketwithserver.getInputStream());
        toserver   = new DataOutputStream(socketwithserver.getOutputStream());


        bufferSize = (int)Math.pow(10, 4);

        buffer = new byte[bufferSize];

        // Lleno el buffer 
        for (int i = 0; i < bufferSize; i++)
            buffer[i] = 1;

        checksum = MD5Checksum.create(buffer);

        //Empieza la cuenta para el tiempo de comunicacion
        startTime = System.currentTimeMillis();

        // Escribe los 4 primeros bytes (tamanio del mensaje)
        toserver.writeInt(bufferSize);

        // Escribe 16 bytes (MD5 Checksum)
        toserver.write(checksum, 0, checksum.length);

        // Escribe el mensaje
        toserver.write(buffer, 0, bufferSize);

        buffer = new byte[bufferSize];
        // Espera la respuesta 
        fromserver.read(buffer, 0, bufferSize);


        System.out.println((System.currentTimeMillis() - startTime)/2);

        fromserver.close();
        toserver.close();
        socketwithserver.close();
    }
}