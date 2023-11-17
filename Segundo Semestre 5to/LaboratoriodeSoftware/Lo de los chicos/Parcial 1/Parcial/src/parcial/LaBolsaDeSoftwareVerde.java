package parcial;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class LaBolsaDeSoftwareVerde {

	private List<Establecimiento> establecimientos;
	private List<Propuesta> propuestas;
	
	public LaBolsaDeSoftwareVerde(List<Establecimiento> establecimientos, List<Propuesta> propuestas) {
		super();
		this.establecimientos = establecimientos;
		this.propuestas = propuestas;
	}

	public boolean sePuedeArmarBolson(int anio, int mes, Propuesta propuestaBolson) {
		
		int cantBolsones = this.cantidadDeBolsones(anio, mes, propuestaBolson);
		if (cantBolsones > 0) {
			return true;
		}
		return false;
	}
	
	public int cantidadDeBolsones(int anio, int mes, Propuesta propuestaBolson) {
		
		Map<String, Integer> verdurasDisponibles = new HashMap<String, Integer>();
		
		for (Establecimiento establecimiento : establecimientos) {
			Iterator iterador = establecimiento.iteradorDeVerdurasCosechadas(anio, mes);
			while(iterador.hasNext()) {
				Verdura v = (Verdura) iterador.next();
				verdurasDisponibles.put(v.getNombre(), v.getCant());
			}
		}
		
		int cantBolsones = 0;
		boolean quedanVerduras = true;
		while(quedanVerduras) {
			for (Verdura v : propuestaBolson.getVerduras()) {
				Integer cantDeVerduraV = verdurasDisponibles.get(v.getNombre());
				cantDeVerduraV = cantDeVerduraV - v.getCant();
				verdurasDisponibles.put(v.getNombre(), cantDeVerduraV);
				if(cantDeVerduraV < 0) {
					quedanVerduras = false;
				}
			}
			if (quedanVerduras) {
				cantBolsones++;
			}	
		}
		
		return cantBolsones;
	}
	
	public Map<Propuesta, Integer> bolsonesPorPropuesta(int anio, int mes){
		
		Map<Propuesta, Integer> propCant = new HashMap<Propuesta, Integer>();
		
		for (Propuesta propuesta: this.propuestas) {
			propCant.put(propuesta, this.cantidadDeBolsones(anio, mes, propuesta));
		}
		return propCant;
	}
	
	
	public Map<Establecimiento, List<Verdura>> participacionPorEstablecimiento(int anio, int mes, Propuesta propuestaBolson) {
		
		Map<Establecimiento, List<Verdura>> participaciones = new HashMap<Establecimiento, List<Verdura>>();
		
		for (Establecimiento establecimiento : establecimientos) {
			List<Verdura> listaVerduras = new ArrayList<Verdura>();
			Iterator iterador = establecimiento.iteradorDeVerdurasCosechadas(anio, mes);
			while(iterador.hasNext()) {
				Verdura v = (Verdura) iterador.next();
				if (propuestaBolson.tiene(v)) {
					listaVerduras.add(v);
				}
				
			}
			participaciones.put(establecimiento, listaVerduras);
		}
		
		return participaciones;
	}
	
	
}
