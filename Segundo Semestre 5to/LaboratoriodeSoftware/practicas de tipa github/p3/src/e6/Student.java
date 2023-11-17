package e6;

public class Student {
    private String name, surname;
    private Integer age, code, passedSubjects;

    public Student(String name, String surname, Integer age, Integer code, Integer passedSubjects) {
        this.name = name;
        this.surname = surname;
        this.age = age;
        this.code = code;
        this.passedSubjects = passedSubjects;
    }

    public String getName() {
        return name;
    }

    public String getSurname() {
        return surname;
    }

    public Integer getAge() {
        return age;
    }

    public Integer getCode() {
        return code;
    }

    public Integer getPassedSubjects() {
        return passedSubjects;
    }

    @Override
    public String toString() {
        return "Student{" +
                "name='" + name + '\'' +
                ", surname='" + surname + '\'' +
                ", age=" + age +
                ", code=" + code +
                ", passedSubjects=" + passedSubjects +
                '}';
    }
}
