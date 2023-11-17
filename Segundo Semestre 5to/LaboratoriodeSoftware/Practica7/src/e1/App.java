package e1;

import javax.imageio.ImageIO;
import javax.swing.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

public class App {

    private JPanel mainPanel;
    private JLabel imgLabel;

    public static void main(String[] args) throws InterruptedException {
        JFrame frame = new JFrame("App");
        App app =  new App();
        frame.setContentPane(app.mainPanel);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
        frame.setVisible(true);


        while (true) {
            TimeUnit.SECONDS.sleep(1);
            app.imgLabel.setVisible(!app.imgLabel.isVisible());
        }
    }

    private void createUIComponents() {
        BufferedImage bufferedImage = null;
        try {
            bufferedImage = ImageIO.read(new File("src/e1/burger.jpg"));
        } catch (IOException e) {
            e.printStackTrace();
        }

        imgLabel = new JLabel(new ImageIcon(bufferedImage));
    }
    
    /*
     * 
     * 
    private void paint(Graphics g) {
		 Calendar cal = Calendar.getInstance();
		 Date fecha = cal.getTime();
		 DateFormat fechaFormateada = DateFormat.getTimeInstance();
		 g.drawString(fechaFormateada.format(fecha), 5, 10);
	}

     */
}
