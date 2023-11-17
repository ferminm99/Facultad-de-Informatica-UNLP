package e1;

public class TestEstudiantes {
        public static void main(String[] args) {
            Estudiante[] a = {
                   new Estudiante("cam", "ono", 137356),
                   new Estudiante("mel", "ono", 177356),
                   new Estudiante("seb", "rai", 138356),
                   new Estudiante("fran", "lip", 137456),
            };
            for (int i = 0; i < a.length; i++) {
                System.out.println(a[i]);
            }

            Estudiante e1 = new Estudiante("mel", "ono", 177356);
            Estudiante e2 = new Estudiante("mel", "ono", 177356);

            System.out.println("-----------------------------------------------------");
            System.out.println("estudiante1 y estudiante2 son (eq): " + e1.equals(e2));
            System.out.println("estudiante1 y estudiante2 son (==): " + (e1 == e2));
            System.out.println("estudiante1 hashcode " + e1.hashCode());
            System.out.println("estudiante2 hashcode " + e2.hashCode());
        }
}
