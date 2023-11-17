package parcial;

import java.util.Map;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

public class Establecimiento {

	private String nombre;
	private List<RegistroVerdura> cosecha = new ArrayList<RegistroVerdura>();
	
	public Establecimiento(String nombre, List<RegistroVerdura> cosecha) {
		super();
		this.nombre = nombre;
		this.cosecha = cosecha;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public List<RegistroVerdura> getCosecha() {
		return cosecha;
	}

	public void setCosecha(List<RegistroVerdura> cosecha) {
		this.cosecha = cosecha;
	}

	public Iterator iteradorDeVerdurasCosechadas(int anio, int mes) {
		return new IteradorEstablecimiento().getIterador(anio, mes);
	}
	
	private class IteradorEstablecimiento {
		
		public Iterator<Verdura> getIterador(int anio, int mes) {
			List<Verdura> verdurasDeLaFecha = new ArrayList<Verdura>();
			
			for (RegistroVerdura rv : cosecha) {
				if(rv.getAnio() == anio && rv.getMes() == mes && rv.isEnCosecha()) {
					verdurasDeLaFecha.add(rv.getVerdura());
				}
			}
			
			return verdurasDeLaFecha.iterator();
		}
		
	}
	
}
