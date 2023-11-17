package unlp.laboratorio;

public class RoturaDelCalzado implements Runnable {
/*
	@Override
    public String getMessage() {
    	//System.out.println("Se le rompio el calzado al corredor");
		try {
			Thread.sleep(5000);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    
    return "Se le rompio el calzado al corredor";
    }
    
   */
    public String toString() {
		return Thread.currentThread().getName();
	}
	
	@Override
	public void run() {
		
		//while (true) {
			System.out.println("El corredor pierde 5 segundos por la rotura de calzado");
			try {
				Thread.sleep(5000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		//}
	}		
	
}