package test;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

public class Test {
    public static void main(String[] args) {
        List list1 = new ArrayList();
        list1.add("one");
        list1.add("three");
        list1.add("four");

        System.out.println( list1.contains("lala"));

        List list2 = new ArrayList();
        list2.add("one");
        list2.add("two");
        list2.add("three");
        list2.add("four");
        list2.add("five");

        System.out.println(list2.stream().filter( x -> list1.contains(x) ).collect(Collectors.toList()));
    }

}
