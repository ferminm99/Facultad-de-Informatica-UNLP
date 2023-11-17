package parcial;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LaBolsaDeSoftwareVerdeTest {

	public static void main(String[] args) {

		//Establecimiento 1
		Verdura v1 = new Verdura("Zanahoria", 3);
		RegistroVerdura r1 = new RegistroVerdura(2020, 1, v1, true);
		Verdura v2 = new Verdura("Rabano", 4);
		RegistroVerdura r2 = new RegistroVerdura(2020, 1, v2, true);
		List<RegistroVerdura> cosecha1 = new ArrayList<RegistroVerdura>();
		cosecha1.add(r1);
		cosecha1.add(r2);
		Establecimiento establecimiento1 = new Establecimiento("Nombre Establecimiento 1", cosecha1);
		
		//Establecimiento 2
		Verdura v3 = new Verdura("Zanahoria", 6);
		RegistroVerdura r3 = new RegistroVerdura(2020, 1, v3, true);
		Verdura v4 = new Verdura("Cebolla", 15);
		RegistroVerdura r4 = new RegistroVerdura(2020, 2, v4, true);
		Verdura v5 = new Verdura("Rabano", 0);
		RegistroVerdura r5 = new RegistroVerdura(2020, 2, v5, false);
		List<RegistroVerdura> cosecha2 = new ArrayList<RegistroVerdura>();
		cosecha1.add(r3);
		cosecha1.add(r4);
		cosecha1.add(r5);
		Establecimiento establecimiento2 = new Establecimiento("Nombre Establecimiento 2", cosecha2);
		
		//Establecimiento 3
		Verdura v6 = new Verdura("Remolacha", 20);
		RegistroVerdura r6 = new RegistroVerdura(2020, 2, v6, true);
		List<RegistroVerdura> cosecha3 = new ArrayList<RegistroVerdura>();
		cosecha3.add(r6);
		Establecimiento establecimiento3 = new Establecimiento("Nombre Establecimiento 3", cosecha3);
		
		//Establecimiento 4
		Verdura v7 = new Verdura("Lechuga", 1);
		RegistroVerdura r7 = new RegistroVerdura(2020, 1, v7, true);
		Verdura v8 = new Verdura("Lechuga", 2);
		RegistroVerdura r8 = new RegistroVerdura(2020, 3, v8, true);
		Verdura v9 = new Verdura("Cebolla", 0);
		RegistroVerdura r9 = new RegistroVerdura(2020, 2, v9, false);
		List<RegistroVerdura> cosecha4 = new ArrayList<RegistroVerdura>();
		cosecha4.add(r7);
		cosecha4.add(r8);
		cosecha4.add(r9);
		Establecimiento establecimiento4 = new Establecimiento("Nombre Establecimiento 4", cosecha4);
		
		//Establecimiento 5
		Verdura v10 = new Verdura("Batata", 10);
		RegistroVerdura r10 = new RegistroVerdura(2020, 3, v10, true);
		Verdura v11 = new Verdura("Kale", 15);
		RegistroVerdura r11 = new RegistroVerdura(2021, 6, v11, true);
		List<RegistroVerdura> cosecha5 = new ArrayList<RegistroVerdura>();
		cosecha5.add(r10);
		cosecha5.add(r11);
		Establecimiento establecimiento5 = new Establecimiento("Nombre Establecimiento 5", cosecha5);
		
		//Propuesta de bolson 1
		Verdura v12 = new Verdura("Kale", 2);
		Verdura v13 = new Verdura("Lechuga", 5);
		Verdura v14 = new Verdura("Zanahoria", 3);
		List<Verdura> listaVerduras1 = new ArrayList<Verdura>();
		listaVerduras1.add(v12);
		listaVerduras1.add(v13);
		listaVerduras1.add(v14);
		Propuesta propuesta1 = new Propuesta(listaVerduras1);
		
		//Propuesta de bolson 2
		Verdura v15 = new Verdura("Zanahoria", 10);
		Verdura v16 = new Verdura("Rabano", 2);
		List<Verdura> listaVerduras2 = new ArrayList<Verdura>();
		listaVerduras2.add(v15);
		listaVerduras2.add(v16);
		Propuesta propuesta2 = new Propuesta(listaVerduras2);
		
		//Propuesta de bolson 3
		Verdura v17 = new Verdura("Remolacha", 5);
		Verdura v18 = new Verdura("Cebolla", 3);
		List<Verdura> listaVerduras3 = new ArrayList<Verdura>();
		listaVerduras3.add(v17);
		listaVerduras3.add(v18);
		Propuesta propuesta3 = new Propuesta(listaVerduras3);
		
		List<Establecimiento> listaDeEstablecimientos = new ArrayList<Establecimiento>();
		listaDeEstablecimientos.add(establecimiento1);
		listaDeEstablecimientos.add(establecimiento2);
		listaDeEstablecimientos.add(establecimiento3);
		listaDeEstablecimientos.add(establecimiento4);
		listaDeEstablecimientos.add(establecimiento5);
		
		List<Propuesta> listaDePropuestas = new ArrayList<Propuesta>();
		listaDePropuestas.add(propuesta1);
		listaDePropuestas.add(propuesta2);
		listaDePropuestas.add(propuesta3);
		
		LaBolsaDeSoftwareVerde bolsa = new LaBolsaDeSoftwareVerde(listaDeEstablecimientos, listaDePropuestas);
		
		if(bolsa.sePuedeArmarBolson(2020, 1, propuesta3)) {
			System.out.println("La propuesta de bolson 3 se puede realizar el anio 2020 mes 1");
		} else {
			System.out.println("La propuesta de bolson 3 No se puede realizar el anio 2020 mes 1");
		}
		
		System.out.println("En el mes 2 anio 2020 se pueden armar " + bolsa.cantidadDeBolsones(2020, 2, propuesta2) + " bolsones de la propuesta 2");
		
		Map<Propuesta, Integer> participaciones = bolsa.bolsonesPorPropuesta(2020, 2);
		int aux = 0;
		for (Propuesta propuesta : participaciones.keySet()) {
			aux++;
			System.out.println("De la propuesta " + aux + " se pueden hacer " + participaciones.get(propuesta) + " bolsones");
		}
		
		
		Map<Establecimiento, List<Verdura>> participacionPorEstablecimiento = bolsa.participacionPorEstablecimiento(2020, 3, propuesta1);
		System.out.println("Participacion por establecimiento para la propuesta 1, anio 2020 mes 3:");
		for (Establecimiento e : participacionPorEstablecimiento.keySet()) {
			System.out.println("Participacion del establecimiento " + e.getNombre() + ":" + participacionPorEstablecimiento.get(e));
		}
		
	}

}
