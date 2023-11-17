package punto1;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class solucion_a {

	public static void main(String[] args) {
		DateTimeFormatter formater = DateTimeFormatter.ofPattern("hh:mm:ss");
		while (true) {
			System.out.println(formater.format(LocalDateTime.now()));
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

}
