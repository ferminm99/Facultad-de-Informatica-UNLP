package e3;

import java.util.ArrayList;
import java.util.List;

public class QGrammasMaker{
    public static List<String> getGrammasFor(String word, Integer q){
        List<String> qgrammas = new ArrayList<>();
        String formattedWord = formatWord(word.toLowerCase());
        for (int i = 0; i < formattedWord.length()-1 ; i++) {
            qgrammas.add(formattedWord.substring(i, i+q));
        }
        return qgrammas;
    }

    private static String formatWord(String word) {
        return "#"+word+"$";
    }
}