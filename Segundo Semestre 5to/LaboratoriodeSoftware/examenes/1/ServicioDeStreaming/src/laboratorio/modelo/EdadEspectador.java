package laboratorio.modelo;

public enum EdadEspectador {
    ATP("Apta para todo público"),
    MAS13("Apta para mayores de 13"),
    MAS16("Apta para mayores de 16"),
    MAS18("Apta para mayores de 18");

    private String texto;

    EdadEspectador(String texto) {
        this.texto = texto;
    }

    public String getTexto() {
        return texto;
    }
}
