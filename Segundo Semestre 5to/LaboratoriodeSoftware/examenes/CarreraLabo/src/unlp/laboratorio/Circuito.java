package unlp.laboratorio;

import java.awt.Color;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import unlp.laboratorio.anotaciones.ConfiguradorSimulacion;
import unlp.laboratorio.anotaciones.ConfiguradorVelocidad;

@ConfiguradorSimulacion(cantidadPistasHabilitadas=4)
public class Circuito {
	private List<Corredor> corredores= new ArrayList<Corredor>();
	Color[] colorArray;
	public Circuito( Color[] colorArray) {

		this.colorArray=colorArray;
	}
	
	@ConfiguradorVelocidad(cantidadCorredores=8, velocidadMin=5, velocidadMax=20)
	public List<Corredor> iniciarCircuito(int cantidadCorredores) {
		this.corredores = new ArrayList<Corredor>();
		
		for(int i = 0; i < cantidadCorredores; i++) {
			//Color color = colorArray[i % colorArray.length];
			this.corredores.add(new Corredor(this.getColorCorredor(i), i));
		}
		
		return new ArrayList<Corredor>(this.corredores);
	        	
	}
	
	public List<Corredor> getCorredores() {
		return corredores;
	}
	
	//Determina el color de un corredor
	private Color getColorCorredor(int numeroCorredor) {
		return colorArray[numeroCorredor % colorArray.length];
	}
}
