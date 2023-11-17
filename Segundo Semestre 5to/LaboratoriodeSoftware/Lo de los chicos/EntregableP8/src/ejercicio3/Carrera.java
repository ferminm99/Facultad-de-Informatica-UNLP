package ejercicio3;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class Carrera {
	private ExecutorService exec = Executors.newFixedThreadPool(3);
	
	public Carrera() {
		super();
	}

	private void startRace() {
		for (int i = 0; i < 5; i++) {
			Corredor r = new Corredor("runner"+i);
            exec.execute(r);
        }
		exec.shutdown();
	}
	
	public static void main(String[] args) {
        Carrera c = new Carrera();
        c.startRace();
    }
}
