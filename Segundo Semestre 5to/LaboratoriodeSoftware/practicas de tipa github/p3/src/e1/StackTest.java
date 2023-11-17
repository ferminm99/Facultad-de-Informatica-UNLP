package e1;

import java.util.Iterator;

public class StackTest {
    public static void main(String[] args) {
       testStack();
       testAnnonymousStack();
    }

    private static void testStack(){
        Stack s = new Stack();
        System.out.println("Nueva Stack | Empty? " + s.isEmpty());

        s.push("Lala");
        s.push("Lala land");
        System.out.println("Stack con elementos | Empty? " + s.isEmpty());

        Iterator i = s.iterator();
        while (i.hasNext()) System.out.println("Item: " + i.next());
        System.out.println("Stack post iterator | Empty? " + s.isEmpty());


//        for (int i = 0; i <= s.size(); i++) {
//            System.out.println("------ Pop: " + s.pop());
//        }
//        System.out.println("Post pop | Empty? " + s.isEmpty());

    }

    private static void testAnnonymousStack(){
        StackAnnonymous s = new StackAnnonymous();
        System.out.println("Nueva StackAnnonymous | Empty? " + s.isEmpty());

        s.push("Lala");
        s.push("Lala land");
        System.out.println("StackAnnonymous con elementos | Empty? " + s.isEmpty());

        Iterator i = s.iterator();
        while (i.hasNext()) System.out.println("Item: " + i.next());
        System.out.println("StackAnnonymous post iterator | Empty? " + s.isEmpty());
    }
}
