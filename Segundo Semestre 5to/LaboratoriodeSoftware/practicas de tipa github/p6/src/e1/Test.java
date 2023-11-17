package e1;

import java.util.ArrayList;
import java.util.List;

public class Test {
    public static void main(String[] args) {
       List<Student> col = new ArrayList<Student>();
        for (int i = 0; i < 10; i++) {
            col.add(new Student(i, i, "Student"+i, "STLastname"+i));
        }
        Subject sub = new Subject("english", col);

        System.out.println(sub.getStudents());
        sub.addStudent(new Student(-100, 100, "AddedStudent", "AddedSTLastname"));
        System.out.println(sub.getStudents());
    }
}
