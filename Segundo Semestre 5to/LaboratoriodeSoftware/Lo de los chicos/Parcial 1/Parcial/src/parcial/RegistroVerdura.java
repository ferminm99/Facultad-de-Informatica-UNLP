package parcial;

public class RegistroVerdura {
	
	private int anio;
	private int mes;
	private Verdura verdura;
	private boolean enCosecha;
	
	
	
	public RegistroVerdura(int anio, int mes, Verdura verdura, boolean enCosecha) {
		super();
		this.anio = anio;
		this.mes = mes;
		this.verdura = verdura;
		this.enCosecha = enCosecha;
	}
	
	public int getAnio() {
		return anio;
	}
	
	public void setAnio(int anio) {
		this.anio = anio;
	}
	
	public int getMes() {
		return mes;
	}
	
	public void setMes(int mes) {
		this.mes = mes;
	}
	
	public Verdura getVerdura() {
		return verdura;
	}
	
	public void setVerdura(Verdura verdura) {
		this.verdura = verdura;
	}
	
	public boolean isEnCosecha() {
		return enCosecha;
	}
	
	public void setEnCosecha(boolean enCosecha) {
		this.enCosecha = enCosecha;
	}
	
}
