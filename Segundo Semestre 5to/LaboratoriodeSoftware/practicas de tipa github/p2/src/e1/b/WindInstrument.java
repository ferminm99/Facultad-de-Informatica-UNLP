package e1.b;

public class WindInstrument implements MusicalInstrument {
    public void hacerSonar(){
        System.out.println("Sonar Vientos");
    }

    public String queEs() {
        return "Instrumento de Viento";
    }

    @Override
    public void afinar() {
        System.out.println("afinando wi");
    }
}
