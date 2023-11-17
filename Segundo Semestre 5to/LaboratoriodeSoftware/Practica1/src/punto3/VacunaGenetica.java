package punto3;

import punto1.Vacuna;

public class VacunaGenetica extends Vacuna {
	
	private float temp_min;
	private float temp_max;

	public VacunaGenetica(String marca, String pais_origen, String enfermedad, int cant_dosis, float temp_min,
			float temp_max) {
		super(marca, pais_origen, enfermedad, cant_dosis);
		this.temp_min = temp_min;
		this.temp_max = temp_max;
	}

	public float getTemp_min() {
		return temp_min;
	}

	public void setTemp_min(float temp_min) {
		this.temp_min = temp_min;
	}

	public float getTemp_max() {
		return temp_max;
	}

	public void setTemp_max(float temp_max) {
		this.temp_max = temp_max;
	}
	
	

}
