package punto1;

public class solucion_b {
	
	public static void main(String[] args) {
		new Thread(new Reloj(), "Reloj#1").start();
		while(true) {
			System.out.println("Haciendo cosas importantes en Main");
			try {
				Thread.sleep(800);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
}

