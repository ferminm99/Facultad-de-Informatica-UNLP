package e1.b;

public class TestMusicalInstruments {
    public static void main(String[] args) {
        WindInstrument w = new WindInstrument();
        StringInstrument s = new StringInstrument();
        w.hacerSonar();
        w.queEs();
        s.hacerSonar();
        s.queEs();
    }
}
