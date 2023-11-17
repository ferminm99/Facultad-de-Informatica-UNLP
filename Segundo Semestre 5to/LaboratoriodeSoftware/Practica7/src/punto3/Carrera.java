package punto3;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Carrera {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ExecutorService exec =Executors.newFixedThreadPool(3);
		System.out.println("PREPARADOS...");
		System.out.println("LISTOS...");
		System.out.println("¡YA!");
		for ( int i = 0; i < 5; i++)
			exec.execute(new Corredor(i));
		exec.shutdown();
	}

}
