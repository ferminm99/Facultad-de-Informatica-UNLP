package unlp.laboratorio;

import java.awt.Color;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ThreadLocalRandom;

import unlp.laboratorio.gui.PanelCircuito;

@ConfiguradorSimulacion(cantidadPistasHabilitadas=4)
public class Circuito {
	private List<Corredor> corredores= new ArrayList<Corredor>();
	Color[] colorArray;
	
	public Circuito( Color[] colorArray) {

		this.colorArray=colorArray;
	}
	@ConfiguradorVelocidad(cantidadCorredores=5,velocidadMin=5,velocidadMax=20)
	public List<Corredor> iniciarCircuito(int cantidadCorredores) {
		//PanelCircuito panelCircuito = new PanelCircuito(cantidadCorredores);
		this.corredores = new ArrayList<Corredor>();
		Method m;
		try {
			m = getClass().getMethod("iniciarCircuito",int.class);
			ConfiguradorVelocidad a = m.getAnnotation(ConfiguradorVelocidad.class);
			int min = a.velocidadMin();
			int max = a.velocidadMax();
			//TODO: completar
			for (int i = 0; i <= cantidadCorredores-1; i++) {
		
				this.corredores.add(new Corredor(this.getColorCorredor(i),i,ThreadLocalRandom.current().nextInt(min, max + 1)));
			 
			}
		} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return corredores;
	        	
	}
	
	public List<Corredor> getCorredores() {
		return corredores;
	}
	
	
	
	//Determina el color de un corredor
	private Color getColorCorredor(int numeroCorredor) {
		return colorArray[numeroCorredor % colorArray.length];
	}
	

}
