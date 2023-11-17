package e3;

import e1.Estudiante;

import java.util.Date;

public class EstudianteUniversitario extends Estudiante {
    private Date admissionDate ;

    public EstudianteUniversitario(String nombre, String apellido, Integer legajo, Date admissionDate) {
        super(nombre, apellido, legajo);
        this.admissionDate = admissionDate;
    }

    public Date getAdmissionDate() {
        return admissionDate;
    }

    public void setAdmissionDate(Date admissionDate) {
        this.admissionDate = admissionDate;
    }
}
