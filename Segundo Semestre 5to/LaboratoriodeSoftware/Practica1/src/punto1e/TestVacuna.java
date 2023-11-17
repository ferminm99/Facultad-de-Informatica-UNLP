package punto1e;

import punto1.Vacuna;

public class TestVacuna {

	public static void main(String[] args) {
		/*int cant = 5;
		Vacuna vector[] = new Vacuna[5];
		for(int i = 0; i < cant ; i++) {
		
	      vector[i]= new Vacuna("Marca " + i, "Pais " + i, "Enfermedad " + i, i);
	    }
		for(int i = 0; i < cant; i++) {
			System.out.print("Vacuna "+ i +" ");
			System.out.println(vector[i].toString());
		}*/
		
		Vacuna vac1= new Vacuna("Javier ", "Filiphinas", "Sida", 1);
		Vacuna vac2= new Vacuna("Javier ", "Filiphinas", "Sida", 1);
		//Vacuna vac2= new Vacuna("Sputnick ", "Argentina", "Peste Negra", 8);
		
		boolean son_iguales = vac1.equals(vac2);
		//boolean son_iguales = vac1 == vac2;
		System.out.println(son_iguales);
		
	}

}
