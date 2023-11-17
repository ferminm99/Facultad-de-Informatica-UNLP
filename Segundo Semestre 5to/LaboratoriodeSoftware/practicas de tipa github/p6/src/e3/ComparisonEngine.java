package e3;

import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeSet;

public class ComparisonEngine {

    public static Set<String> compare (Map<String, List<String>> map, String string){
        Set<String> matchingStrings = new TreeSet<>();
        List<String> qgrammas = QGrammasMaker.getGrammasFor(string,2);
        System.out.println("* QGrammas de "+string+": "+qgrammas);

        for(Map.Entry<String,  List<String>> entry : map.entrySet()) {
            String key = entry.getKey();
            List<String> list = entry.getValue();

            long matchingQGrammas = list.stream().filter( x -> qgrammas.contains(x) ).count();
            if (matchingQGrammas != 0) {
                matchingStrings.add(key);
            }
        }
        return  matchingStrings;
    }
}
