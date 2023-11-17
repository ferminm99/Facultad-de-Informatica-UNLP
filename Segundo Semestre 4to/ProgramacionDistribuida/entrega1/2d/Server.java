/*
 * EchoServer.java
 * Just receives some data and sends back a "message" to a client
 *
 * Usage:
 * java Server port
 */
import java.io.*;
import java.net.*;
import checksum.MD5Checksum;


public class Server
{

    public static void main(String[] args) throws IOException
    {

        byte[] buffer;

        int bufferSize;
        int readBytes;

        /* Check the number of command line parameters */
        if ((args.length != 1) || (Integer.valueOf(args[0]) <= 0) )
        {
            System.out.println("1 arguments needed: port");
            System.exit(1);
        }

        /* The server socket */
        ServerSocket serverSocket = null;
        try
        {
            serverSocket = new ServerSocket(Integer.valueOf(args[0]));
        }
        catch (Exception e)
        {
            System.out.println("Error on server socket");
            System.exit(1);
        }

        /* The socket to be created on the connection with the client */
        Socket connected_socket = null;

        try /* To wait for a connection with a client */
        {
            connected_socket = serverSocket.accept();
        }
        catch (IOException e)
        {
            System.err.println("Error on Accept");
            System.exit(1);
        }

        /* Streams from/to client */
        DataInputStream fromclient;
        DataOutputStream toclient;

        /* Get the I/O streams from the connected socket */
        fromclient = new DataInputStream(connected_socket.getInputStream());
        toclient   = new DataOutputStream(connected_socket.getOutputStream());

        // Lee los primeros 4 bytes (tamanio del mensaje)
        bufferSize = fromclient.readInt();

        // Lee 16 bytes (MD5 Checksum)
        byte[] checksum = new byte[16];
        fromclient.read(checksum);

        
        buffer = new byte[bufferSize];

        int totalreadBytes = 0;

        //Lee el mensaje hasta que se llene el buffer
        while (bufferSize > totalreadBytes)
        {
            readBytes = fromclient.read(buffer, totalreadBytes, bufferSize - totalreadBytes);

            if ( 0 > readBytes)
            {
                System.err.println("Error al leer el buffer");
                System.exit(1);
            }

            totalreadBytes += readBytes;

            System.out.println("Bytes leidos: " + readBytes);
            System.out.println("Total de bytes leidos: " + totalreadBytes);
            System.out.println();
        }

        System.out.println("Los bytes son correctos? " + MD5Checksum.isValid(checksum, buffer));
        System.out.println("--------------------------------");
        
        /* Devuelve los bytes */
        toclient.write(buffer, 0, bufferSize);

   
        fromclient.close();
        toclient.close();
        connected_socket.close();
        serverSocket.close();
    }
}