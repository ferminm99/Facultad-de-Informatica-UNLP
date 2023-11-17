package punto3;

public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		VacunaGenetica vc = new VacunaGenetica(null, null, null, 0, 0, 0);
		VacunaPatogenoIntegro vpi = new VacunaPatogenoIntegro(null, null, null, 0, null);
		VacunaSubunidadAntigenica vsa = new VacunaSubunidadAntigenica(null, null, null, 0, 0, null);
		System.out.println(vc);
		System.out.println(vpi);
		System.out.println(vsa);
	}

}
