package e3;

import java.util.Collection;

public class Test {
    public static void main(String[] args) {
        QGrammasDcitionaryManager qgd = new QGrammasDcitionaryManager(2);
        qgd.addWord("casa");
        qgd.addWord("calle");
        System.out.println("* DICCIONARIO: "+qgd.getHmap());
        String wordToUse = "LLUEVE";
        Collection<String> comparisonResult = ComparisonEngine.compare(qgd.getHmap(), wordToUse);
        System.out.println("-> Las palabras del diccionario que matchean algun qgrama con "+ wordToUse+" son: " + comparisonResult);
    }
}
