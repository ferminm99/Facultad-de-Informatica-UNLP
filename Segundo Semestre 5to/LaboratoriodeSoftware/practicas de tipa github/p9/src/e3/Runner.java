package e3;

import javax.swing.*;

public class Runner implements Runnable {
    private String nickName;
    private int longitudCarrera;
    private String recorridoHastaElMomento = "";
    private JTextField jTextField;

    public Runner(String nickName, int longitudCarrera) {
        this.nickName = nickName;
        this.longitudCarrera = longitudCarrera;
    }

    public void setjTextField(JTextField jTextField) {
        this.jTextField = jTextField;
    }

    public String getNickName() {
        return nickName;
    }

    @Override
    public String toString() {
        return "| "+ nickName + " |";
    }

    @Override
    public void run() {
        Monitor m = Monitor.INSTANCE;
        for (int i = 0; i < longitudCarrera; i++) {
                recorridoHastaElMomento += "-";
                m.wannaRun(nickName + recorridoHastaElMomento, jTextField);
        }

    }
}

