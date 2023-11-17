package e3;

import e1.Estudiante;

public class EstudianteSecundario extends Estudiante {
    private Float gralAvg;
    private Integer pendingSubjects;

    public EstudianteSecundario(String nombre, String apellido, Integer legajo, Float gralAvg, Integer pendingSubjects) {
        super(nombre, apellido, legajo);
        this.gralAvg = gralAvg;
        this.pendingSubjects = pendingSubjects;
    }

    public Integer getPendingSubjects() {
        return pendingSubjects;
    }

    public void setPendingSubjects(Integer pendingSubjects) {
        this.pendingSubjects = pendingSubjects;
    }

    public Float getGralAvg() {
        return gralAvg;
    }

    public void setGralAvg(Float gralAvg) {
        this.gralAvg = gralAvg;
    }
}
