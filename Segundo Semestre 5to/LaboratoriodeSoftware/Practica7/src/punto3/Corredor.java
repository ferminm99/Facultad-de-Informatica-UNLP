package punto3;

public class Corredor implements Runnable {
	int nro;
	
	public Corredor(int nro) {
		this.nro=nro;
	}

	
	public String toString() {
		return "#" + this.nro;
	}

	@Override
	public void run() {
		for(int i=0;i<100;i++) {
			// Avanza un metro
			System.out.println(this+" en metro "+i);
		}
		System.out.println(this+" LLEGO A LA META");
	}

}
