package laboratorio.modelo;

public class Rango {
	private int limiteInferior;
	private int limiteSuperor;
	
	
	public Rango(int limiteInferior, int limiteSuperor) {
		super();
		this.limiteInferior = limiteInferior;
		this.limiteSuperor = limiteSuperor;
	}
	public int getLimiteInferior() {
		return limiteInferior;
	}
	public void setLimiteInferior(int limiteInferior) {
		this.limiteInferior = limiteInferior;
	}
	public int getLimiteSuperor() {
		return limiteSuperor;
	}
	public void setLimiteSuperor(int limiteSuperor) {
		this.limiteSuperor = limiteSuperor;
	}

	@Override
	public String toString() {
		return limiteInferior + " - " + limiteSuperor;
	}
}
