package unlp.laboratorio.gui;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JFrame;
import javax.swing.JPanel;

public class Frame extends JFrame implements ActionListener{


	private static final long serialVersionUID = 1L;
	PanelConfiguracion m;
    public Frame() {
        super("Laboratorio de Software - Simulador de Carreras");
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setVisible(true);
        setSize(400, 300);

        m = new PanelConfiguracion();
        getContentPane().add(m.getPanel());
        m.getButton().addActionListener(this);
        m.getPanel().revalidate();

    }

    @Override
    public void actionPerformed(ActionEvent e) {

     
        this.remove(m.getPanel());
        repaint();
        JPanel sim = new PanelCircuito(8);
        getContentPane().add(sim);
        this.setSize(900, 600);
        ((PanelCircuito) sim).startSimulation();
    }
}
