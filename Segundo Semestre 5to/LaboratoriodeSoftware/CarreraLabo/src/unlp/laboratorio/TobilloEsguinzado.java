package unlp.laboratorio;

public class TobilloEsguinzado extends Exception {
    @Override
    public String getMessage() {
        return "El corredor se esguinzo el tobillo";
    }
}