package unlp.laboratorio;



public class NecesitaTomarAgua implements Runnable{
	
	public String toString() {
		return Thread.currentThread().getName();
	}
	
	@Override
	public void run() {
		
		//while (true) {
			System.out.println("El corredor tomara agua durante cinco segundos");
			try {
				Thread.sleep(2000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		//}
	}		
	
}