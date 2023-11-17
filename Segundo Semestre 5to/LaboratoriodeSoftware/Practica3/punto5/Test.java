package punto5;

//import java.util.Iterator;

public class Test {

	public static void main(String[] args) {
		Stack<String> pila = new Stack<String>();
		pila.push("cadena1");
		pila.push("cadena2");
		pila.push("cadena3");
		pila.push("cadena4");
		pila.push("cadena5");
		
		System.out.println("Pila Real = "+ pila.toString());
		System.out.println("Tamaño Pila = "+ pila.size());
		
		int iter_total = 5;
		System.out.println("Cantidad de recorridos = "+ iter_total);
		int iter_act = 0;
		while (iter_act != iter_total) {
			iter_act++;
			System.out.print("Recorriendo pila (iter "+ iter_act +") = [");
			for (String elem: pila) {
				System.out.print(" "+ elem +" ");
			}
			System.out.println("]");
		}
	}

}
