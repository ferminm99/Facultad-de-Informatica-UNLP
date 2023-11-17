package ejercicio3;

import java.util.concurrent.TimeUnit;

public class Corredor implements Runnable {
	private int metrosRecorridos = 0;
	private String nombre;
	
	public Corredor(String nombre) {
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


	public void run() {
		for (int i = 0; i < 10; i++) {
			try {
	            TimeUnit.MILLISECONDS.sleep(20);
	        } catch (InterruptedException e) {
	           e.printStackTrace();
	        }
			this.metrosRecorridos = this.metrosRecorridos + 10;
			System.out.println(this.nombre+": "+this.metrosRecorridos);
		}
	}
}
