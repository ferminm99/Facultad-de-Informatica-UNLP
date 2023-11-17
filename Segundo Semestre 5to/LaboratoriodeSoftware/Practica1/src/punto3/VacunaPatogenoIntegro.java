package punto3;

import punto1.Vacuna;

public class VacunaPatogenoIntegro extends Vacuna {
	
	private String nombre_patogeno; 
	
	

	public VacunaPatogenoIntegro(String marca, String pais_origen, String enfermedad, int cant_dosis,
			String nombre_patogeno) {
		super(marca, pais_origen, enfermedad, cant_dosis);
		this.nombre_patogeno = nombre_patogeno;
	}

	public String getNombre_patogeno() {
		return nombre_patogeno;
	}

	public void setNombre_patogeno(String nombre_patogeno) {
		this.nombre_patogeno = nombre_patogeno;
	}

	
}
