package punto1;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class solucion_c {
	
	public static void main(String[] args) {
		ExecutorService exec =Executors.newCachedThreadPool();
		exec.execute(new Reloj());
		while(true) {
			System.out.println("Haciendo cosas importantes en Main...");
			try {
				Thread.sleep(1500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}

