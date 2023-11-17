package e3;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

// si ponemos solo 3 threads en el pool, correran 3 y a medida que vayan terminando los anteriores empezaran a correr
// los que faltan
// TODO reset race -->
// no se puede interrumpir los thrads porque sale un problema por el metodo sync ... es coomo
// que dice imposible interrumpir thread que está tratando de adquirir lock ... si no fuera por eso, mandando un dhutdownnow
// al excecutor, andaría
public class Race {
    private JPanel mainPanel;
    private JButton startButton;
    private JTextField textField0;
    private JTextField textField1;
    private JTextField textField2;
    private JTextField textField3;
    private JTextField textField4;
    int longitudCarrera = 100;
    private List<Runner> runners = new ArrayList<>();
    private List<JTextField> textFields = new ArrayList<>();
    private ExecutorService exec = Executors.newFixedThreadPool(3);

    public Race() {
        initializeRunners();

        prepareRace();

        startButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                startRace();
            }
        });

    }

    private void prepareRace() {
        textFields.add(textField0);
        textFields.add(textField1);
        textFields.add(textField2);
        textFields.add(textField3);
        textFields.add(textField4);

        Font font1 = new Font("SansSerif", Font.BOLD, 20);

        for (int i = 0; i < runners.size(); i++) {
            Runner r = runners.get(i);
            JTextField t = textFields.get(i);
            r.setjTextField(t);
            t.setText(r.getNickName());
            t.setFont(font1);
        }
    }

    private void initializeRunners() {
        for (int i = 0; i < 5; i++) {
            Runner r = new Runner("runner"+i, longitudCarrera);
            runners.add(r);
        }
    }

    private void startRace() {
        for (int i = 0; i < runners.size(); i++) {
            exec.execute(runners.get(i));
        }
        exec.shutdown();
    }

    public static void main(String[] args) {
        JFrame frame = new JFrame("Race");
        frame.setContentPane(new Race().mainPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);
    }


}
