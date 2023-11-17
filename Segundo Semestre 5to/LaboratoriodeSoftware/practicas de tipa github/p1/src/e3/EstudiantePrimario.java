package e3;

import e1.Estudiante;

public class EstudiantePrimario extends Estudiante {
    private Boolean hasRetakenYear;
    private Integer absences;

    public EstudiantePrimario(String nombre, String apellido, Integer legajo, Boolean hasRetakenYear, Integer absences) {
        super(nombre, apellido, legajo);
        this.hasRetakenYear = hasRetakenYear;
        this.absences = absences;
    }

    public Integer getAbsences() {
        return absences;
    }

    public void setAbsences(Integer absences) {
        this.absences = absences;
    }

    public Boolean getHasRetakenYear() {
        return hasRetakenYear;
    }

    public void setHasRetakenYear(Boolean hasRetakenYear) {
        this.hasRetakenYear = hasRetakenYear;
    }
}
