package unlp.laboratorio.gui;
import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;

import javax.swing.JButton;
import javax.swing.JLabel;
import javax.swing.JPanel;

public class PanelConfiguracion {
    private JButton buttonOK;
    private JPanel mainFrame;

    public PanelConfiguracion()
    {
        mainFrame = new JPanel(new GridBagLayout());
        mainFrame.setSize(400, 300);

        GridBagConstraints c = new GridBagConstraints();
        c.fill = GridBagConstraints.HORIZONTAL;
        createOkButton(mainFrame, c);
        createWelcomeText(mainFrame, c);
    }

    private void createWelcomeText(JPanel frame, GridBagConstraints c)
    {
        JLabel welcomeText = new JLabel();
        welcomeText.setText("Simulador de Carreras");
        welcomeText.setFont(new Font("Serif", Font.PLAIN, 30));
        c.gridx = 0;
        c.gridy = 0;
        frame.add(welcomeText, c);
    }

   
    private void createOkButton(JPanel frame, GridBagConstraints c)
    {
        buttonOK = new JButton();
        buttonOK.setText("Comenzar");
        c.weighty = 2;
        c.gridwidth = 2;
        c.gridx = 0;
        c.gridy = 3;
        frame.add(buttonOK, c);
    }

  

    public JPanel getPanel()
    {
        return mainFrame;
    }

    public JButton getButton()
    {
        return buttonOK;
    }

}
