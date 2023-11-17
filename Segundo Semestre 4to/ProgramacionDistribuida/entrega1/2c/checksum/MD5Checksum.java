package checksum;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;
import java.security.*;

public class MD5Checksum
{
    public static byte[] create(byte[] message)
    {
        MessageDigest messageDigest = null;

        try
        {
            //Convierte mensaje a formato checksum MD5
            messageDigest = MessageDigest.getInstance("MD5");

            return messageDigest.digest(message);
        }
        catch (NoSuchAlgorithmException exception)
        {
            exception.printStackTrace();

            return null;
        }
    }

    private static String checksumToString(byte[] checksum)
    {
        StringBuilder stringBuilder = new StringBuilder();

        for (byte bytes : checksum)
        stringBuilder.append(String.format("%02x", bytes & 0xff));

        return new String(stringBuilder);
    }

    public static boolean isValid(byte[] checksum, byte[] message)
    {
        /* Convierte el campo checksum en un string */
        String checksumString = checksumToString(checksum);

        /* Crea el checksum del mensaje */
        byte[] checksumMessageInBytes = MD5Checksum.create(message);
        String checksumMessage = checksumToString(checksumMessageInBytes);

        //Compara para verificar si no hubo fallos en el envio o recepcion del mensaje
        return checksumString.equals(checksumMessage);
    }

}