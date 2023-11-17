/*
 * Client.java
 * Just sends stdin read data to and receives back some data from the server
 *
 * usage:
 * java Client serverhostname port
 */
import java.io.*;
import java.net.*;

import java.security.*;

import java.lang.Math;

import checksum.MD5Checksum;


public class Client
{

    public static void main(String[] args) throws IOException
    {
        
        int bufferSize;
        byte[] buffer;
        byte[] checksum;


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

        /* Envia los 4 mensajes al servidor, desde el 10^3 bytes hasta el 10^6 bytes */
        for (byte i = 3; i <= 6; i++)
        {
            bufferSize = (int)Math.pow(10, i);

            buffer = new byte[bufferSize];

            // Llena el buffer
            for (int j = 0; j < bufferSize; j++)
                buffer[j] = 1;

            checksum = MD5Checksum.create(buffer);

            // Escribe los 4 primeros bytes (tamanio del mensaje)
            toserver.writeInt(bufferSize);

            // Escribe 16 bytes (MD5 Checksum)
            toserver.write(checksum, 0, checksum.length);

            // Escribe el mensaje
            toserver.write(buffer, 0, bufferSize);

            System.out.println("Bytes escritos: " + bufferSize);
            System.out.println("--------------------------------");
        }

        fromserver.close();
        toserver.close();
        socketwithserver.close();
    }
}