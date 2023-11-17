package e3;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

public class TestAddAll {
    public static void main(String[] args) {
        HashSetAgregados<String> hsa = new HashSetAgregados<String>();
        hsa.add("Lala1");
        hsa.add("Lala2");
        hsa.add("Lala3");
        System.out.println("CantidadTotalAgregados: " + hsa.getCantidadAgregados());

        ArrayList<String> c = new ArrayList<String>();
        c.add("Lalalalala1");
        c.add("Lalalalala2");
        c.add("Lalalalala3");
        System.out.println("C.size() " + c.size());
        hsa.addAll(c);
        System.out.println("CantidadTotalAgregados: " + hsa.getCantidadAgregados());

        Iterator it = hsa.iterator();
        while (it.hasNext()){
            System.out.println("Value: " + it.next() + " ");
        }

    }
}
