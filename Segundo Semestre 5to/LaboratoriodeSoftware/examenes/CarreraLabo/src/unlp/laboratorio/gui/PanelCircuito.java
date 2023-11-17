package unlp.laboratorio.gui;
import java.awt.Color;
import java.awt.Graphics;
import java.util.List;
import java.util.Timer;
import java.util.TimerTask;
import javax.swing.JPanel;
import unlp.laboratorio.Circuito;
import unlp.laboratorio.Simulacion;
import unlp.laboratorio.Corredor;


public class PanelCircuito extends JPanel{

	private static final long serialVersionUID = 1L;
	private int refresh = 20;
    private Timer timer;
    private List<Corredor> corredores;

    int cantidadCorredores;

    Color[] colorArray = {Color.BLUE, Color.RED, Color.GREEN, Color.YELLOW, Color.CYAN, Color.ORANGE, Color.PINK, Color.MAGENTA};

    public PanelCircuito(int cantidadCorredores)
    {
        this.cantidadCorredores = cantidadCorredores;
        setSize(600, 900);
        configurarCarrera();
    }
    
    
    public void configurarCarrera() {
    	Circuito circuito = new Circuito(colorArray);
    	Simulacion.iniciarSimulacion(circuito);
    	this.corredores = circuito.getCorredores();
    }
   

    public void startSimulation()
    {
        timer = new Timer();
        timer.schedule(new RemindTask(), 0, refresh);
    }


    class RemindTask extends TimerTask
    {
        public void run() {
            repaint();
        }
    }

    public void paint(Graphics g)
    {
        super.paint(g);

        for(int i = -1; i <= cantidadCorredores; i++)
        {
            int width = (850 - i * 50) / 2;
            int height = (550 - i * 50) / 2;
            int middleX = i * 25 + width;
            int middleY = i * 25 + height;

            double PI = 3.14;
            for (double t = 0; t < 2 * PI; t += 0.1)
            {
              
                g.drawLine((int) (middleX + width * Math.cos(t)),(int)  (middleY + height * Math.sin(t)),
                        (int) (middleX + width * Math.cos(t + 0.1)), (int) (middleY + height * Math.sin(t + 0.1)));
            }
        }
    
        g.fillRect(440, 0, 10, cantidadCorredores * 25);

        dibujarCorredor(g);
    }

	private void dibujarCorredor(Graphics g) {
		for (Corredor corredor: corredores)
			corredor.paint(g);
	}
    

}
