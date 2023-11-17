package punto7;

public enum Notas {
	Do("C"),
	Re("D"),
	Mi("E"),
	Fa("F"),
	Sol("G"),
	La("A"),
	Si("B");
	
	private String cifrado_americano;
	
	Notas(String cifrado_americano) {
		this.cifrado_americano = cifrado_americano;
	}
	
	public String cifrado_americano() {
		return this.cifrado_americano;
	}
	
}
