package e1;

import java.util.Comparator;

public class Student {
    private Integer studentNumber, idNumber;
    private String name, lastname;

    public Student(Integer studentNumber, Integer idNumber, String name, String lastname) {
        this.studentNumber = studentNumber;
        this.idNumber = idNumber;
        this.name = name;
        this.lastname = lastname;
    }

    public Integer getStudentNumber() {
        return studentNumber;
    }

    public String getName() {
        return name;
    }

    public String getLastname() {
        return lastname;
    }

    @Override
    public String toString() {
        return "|Student " + name + '|' ;
    }

    public enum ComparadorPorLegajo implements Comparator<Student> {
        INSTANCE;

        @Override
        public int compare(Student s1, Student s2) {
            return s1.getStudentNumber() - s2.getStudentNumber();
        }
    }

    public enum ComparadorPorNyA implements Comparator<Student> {
        INSTANCE;

        @Override
        public int compare(Student s1, Student s2) {
            Integer partialRes = s1.getName().compareTo(s2.getName());
            if (partialRes == 0) {
                return s1.getLastname().compareTo(s2.getLastname());
            }
            return partialRes;
        }
    }
}
