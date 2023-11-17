package e1.b;

public class StringInstrument implements MusicalInstrument{
    public void hacerSonar(){
        System.out.println("Sonar Cuerdas");
    }

    public String queEs() {
        return "Instrumento de Cuerda";
    }

    @Override
    public void afinar() {
        System.out.println("afinando si");
    }
}
