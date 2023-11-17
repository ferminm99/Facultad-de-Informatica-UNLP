package punto7;

public enum FrecuenciasDeLA {
	ISO16(440),
	AfinacionDeCamara(444),
	Renacimiento(446),
	OrganosAlemanesQueTocabaBatch(480);
	
	private int hercios;
	
	FrecuenciasDeLA(int hercios) {
		this.hercios = hercios;
	}
	
	public int hercios() {
		return this.hercios;
	}

}
