/*

* IfaceRemoteClass.java
* Interface defining only one method which can be invoked remotely
*
*/
/* Needed for defining remote method/s */
import java.rmi.Remote;
import java.rmi.RemoteException;

/* This interface will need an implementing class */
public interface IfaceRemoteClass extends Remote {
    public byte[] leer(String name, int position, int totalBytes) throws RemoteException;

    public long escribir(String name, int totalBytes, byte[] data) throws RemoteException;

    public void simulacion() throws RemoteException;

    public void loopInfinito() throws RemoteException;
}