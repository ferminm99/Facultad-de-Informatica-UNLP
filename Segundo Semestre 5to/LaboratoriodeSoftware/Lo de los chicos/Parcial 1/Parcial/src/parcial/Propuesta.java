package parcial;

import java.util.List;

public class Propuesta {

	private List<Verdura> verduras;
	
	public Propuesta(List<Verdura> verduras) {
		super();
		this.verduras = verduras;
	}

	public List<Verdura> getVerduras() {
		return verduras;
	}

	public void setVerduras(List<Verdura> verduras) {
		this.verduras = verduras;
	}
	
	public boolean tiene(Verdura v) {
		for (Verdura verdura : verduras) {
			if(verdura.getNombre() == v.getNombre()) {
				return true;
			}
		}
		return false;
	}
	
}
