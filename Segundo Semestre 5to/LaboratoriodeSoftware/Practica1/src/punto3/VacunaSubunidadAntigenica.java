package punto3;

import punto1.Vacuna;

public class VacunaSubunidadAntigenica extends Vacuna {
	
	private int cant_antigenos;
	private String tipo_proceso;

	
	public VacunaSubunidadAntigenica(String marca, String pais_origen, String enfermedad, int cant_dosis,
			int cant_antigenos, String tipo_proceso) {
		super(marca, pais_origen, enfermedad, cant_dosis);
		this.cant_antigenos = cant_antigenos;
		this.tipo_proceso = tipo_proceso;
	}

	public int getCant_antigenos() {
		return cant_antigenos;
	}

	public void setCant_antigenos(int cant_antigenos) {
		this.cant_antigenos = cant_antigenos;
	}

	public String getTipo_proceso() {
		return tipo_proceso;
	}

	public void setTipo_proceso(String tipo_proceso) {
		this.tipo_proceso = tipo_proceso;
	}
}
