@Melodia
public class MelodiaDePrueba {
    @Escala({"C", "D", "E", "F", "G", "A", "B"})
    private String nota;

    @Duracion({"w", "h", "q", "i", "s", "t", "x", "n"})
    private String duracion;

    public MelodiaDePrueba(String nota, String duracion) {
        this.nota = nota;
        this.duracion = duracion;
    }

    @Override
    public String toString() {
        return nota+duracion;
    }
}
