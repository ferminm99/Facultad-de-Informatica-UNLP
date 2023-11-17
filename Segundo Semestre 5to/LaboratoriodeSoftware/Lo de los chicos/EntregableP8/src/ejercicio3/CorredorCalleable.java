package ejercicio3;

import java.util.concurrent.Callable;
import java.util.concurrent.TimeUnit;

public class CorredorCalleable implements Callable<Boolean> {
	private int metrosRecorridos = 0;
	private String nombre;
	
	public CorredorCalleable(String nombre) {
		super();
		this.nombre = nombre;
	}

	public int getMetrosRecorridos() {
		return metrosRecorridos;
	}

	public void setMetrosRecorridos(int metrosRecorridos) {
		this.metrosRecorridos = metrosRecorridos;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}


	public Boolean call() {
		for (int i = 0; i < 10; i++) {
			try {
	            TimeUnit.MILLISECONDS.sleep(20);
	        } catch (InterruptedException e) {
	           e.printStackTrace();
	        }
			//Forzamos una condicion para que el corredor 1 abandone la carrera antes de los 100 metros
			if (this.nombre.equals("runner1") && this.metrosRecorridos == 50) {
				break;
			}
			this.metrosRecorridos = this.metrosRecorridos + 10;
			System.out.println(this.nombre+": "+this.metrosRecorridos);
		}
		return (this.metrosRecorridos == 100);
	}
}
