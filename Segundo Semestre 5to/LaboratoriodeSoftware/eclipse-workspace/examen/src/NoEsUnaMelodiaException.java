public class NoEsUnaMelodiaException extends Exception {
    @Override
    public String getMessage() {
        return "No se puede armar una melodia con la clase :(";
    }
}
