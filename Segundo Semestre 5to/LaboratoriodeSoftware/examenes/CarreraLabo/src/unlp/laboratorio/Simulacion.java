package unlp.laboratorio;

import java.lang.reflect.Method;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import unlp.laboratorio.anotaciones.ConfiguradorSimulacion;
import unlp.laboratorio.anotaciones.ConfiguradorVelocidad;

public class Simulacion {
	public static void iniciarSimulacion(Circuito unCircuito) {
		
		Class<Circuito> cl = Circuito.class;
		ConfiguradorSimulacion annot = cl.getAnnotation(ConfiguradorSimulacion.class);
		int cantidadPistasHabilitadas = annot.cantidadPistasHabilitadas();
		int cantidadCorredores = -1;
		try {
			Method m = cl.getDeclaredMethod("iniciarCircuito", int.class);
			ConfiguradorVelocidad annot2 = m.getAnnotation(ConfiguradorVelocidad.class);
			cantidadCorredores = annot2.cantidadCorredores();
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<Corredor> corredores = unCircuito.iniciarCircuito(cantidadCorredores);
		ExecutorService exec = Executors.newFixedThreadPool(cantidadPistasHabilitadas);
		for(Corredor corredor: corredores)
			exec.execute(corredor);
	}

}
