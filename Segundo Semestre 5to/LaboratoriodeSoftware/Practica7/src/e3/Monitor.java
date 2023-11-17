package e3;

import javax.swing.*;
import java.util.concurrent.TimeUnit;

public enum Monitor{
    INSTANCE;

    public synchronized void wannaRun(String s, JTextField t) {
        t.setText(s);
        try {
            TimeUnit.MILLISECONDS.sleep(25);
        } catch (InterruptedException e) {
           e.printStackTrace();
        }
    }

}
