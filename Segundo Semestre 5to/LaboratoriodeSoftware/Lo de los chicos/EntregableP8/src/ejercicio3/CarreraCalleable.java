package ejercicio3;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class CarreraCalleable {
	private ExecutorService exec = Executors.newFixedThreadPool(3);
	
	public CarreraCalleable() {
		super();
	}

	private void startRace() {
		List<CorredorCalleable> lista = new ArrayList<CorredorCalleable>();
		for (int i = 0; i < 5; i++) {
			CorredorCalleable r = new CorredorCalleable("runner"+i);
			lista.add(r);
        }
		try {
			List<Future<Boolean>> resultado = exec.invokeAll(lista);
			for (int i = 0; i < resultado.size(); i++) {
				if (!resultado.get(i).get()) {
					System.out.println("Abandono el "+lista.get(i).getNombre());
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		exec.shutdown();
	}
	
	public static void main(String[] args) {
        CarreraCalleable c = new CarreraCalleable();
        c.startRace();
    }
}
