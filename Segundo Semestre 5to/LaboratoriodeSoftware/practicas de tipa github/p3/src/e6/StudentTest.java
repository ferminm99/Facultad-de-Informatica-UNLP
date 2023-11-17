package e6;

import java.util.Arrays;
import java.util.Comparator;

public class StudentTest {
    public static void main(String[] args) {
        Student s1 = new Student("camila", "onofri", 20, 137356, 30);
        Student s5 = new Student("camila", "mura", 20, 137356, 30);
        Student s2 = new Student("celeste", "onofri", 18, 188356, 10);
        Student s4 = new Student("bianca", "adorbado", 20, 137345, 0);

        Student[] sds = {s1, s2, s4, s5};

        Arrays.sort(sds, new Comparator<Student>() {
            @Override
            // compare returns a negative integer, zero, or a positive integer
            // as the first argument is less than, equal to, or greater than the second.
            public int compare(Student o1, Student o2) {
                return o1.getPassedSubjects() - (o2.getPassedSubjects());
            }
        });

        System.out.println("-------------- asc sort subjects ---------------");

        for (int i = 0; i < sds.length; i++) {
            System.out.println(sds[i]);
        }



        Arrays.sort(sds, new Comparator<Student>() {
            @Override
            // compare returns a negative integer, zero, or a positive integer
            // as the first argument is less than, equal to, or greater than the second.
            public int compare(Student o1, Student o2) {
                return o2.getAge() - (o1.getAge());
            }
        });

        System.out.println("----------------- des sort age ----------------");

        for (int i = 0; i < sds.length; i++) {
            System.out.println(sds[i]);
        }





        Arrays.sort(sds, new Comparator<Student>() {
            @Override
            // compare returns a negative integer, zero, or a positive integer
            // as the first argument is less than, equal to, or greater than the second.
            public int compare(Student o1, Student o2) {
                return o2.getCode() - (o1.getCode());
            }
        });

        System.out.println("----------------- des sort code ----------------");

        for (int i = 0; i < sds.length; i++) {
            System.out.println(sds[i]);
        }





        Arrays.sort(sds, new Comparator<Student>() {
            @Override
            public int compare(Student s1, Student s2) {
                    int nameCmp = s2.getName().compareTo(s1.getName());
                    if (nameCmp != 0) {
                        return nameCmp;
                    }
                    return s2.getSurname().compareTo(s1.getSurname());
            }
        });

        System.out.println("------------------- desc sort name and surname -------------------");

        for (int i = 0; i < sds.length; i++) {
            System.out.println(sds[i]);
        }

    }
}
