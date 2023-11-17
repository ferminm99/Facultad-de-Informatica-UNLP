package parcial;

public class Verdura {

	private String nombre; 
	private int cant;
	
	public Verdura(String nombre, int cant) {
		super();
		this.nombre = nombre;
		this.cant = cant;
	}
	
	public String getNombre() {
		return nombre;
	}
	
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	
	public int getCant() {
		return cant;
	}
	
	public void setCant(int cant) {
		this.cant = cant;
	}

}
