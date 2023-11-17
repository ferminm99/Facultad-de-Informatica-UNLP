package unlp.laboratorio;
import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.util.Random;   

public class Corredor implements Runnable{
    double x, y;
    Color color;
    int numeroCorredor;
    int velocidad;

    public Corredor( Color color, int numeroCorredor,int velocidad) {
         	
        this.x = 420;
        this.y = 25 * numeroCorredor;
        this.color = color;
        this.numeroCorredor = numeroCorredor;
        this.velocidad = velocidad;
 
    }
    
   
    public void run()
    {
    	correrSobrePista();

    }


    public void correrSobrePista()
    {
        int width = (850 - numeroCorredor * 50) / 2;
        int height = (550 - numeroCorredor * 50) / 2;
        int middleOfX = numeroCorredor * 25 + width;
        int middleOfY = numeroCorredor * 25 + height;
        double PI = 3.14;

        //Da una vuelta a la pista
        for (double t = 1.5 * PI; t < 3.5 * PI; t += 0.02)
        {
            x = middleOfX + width * Math.cos(t);
            y = middleOfY + height * Math.sin(t);

           try {
        	   hacerPaso();
           } catch (TobilloEsguinzado e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
           }
	           
    		
        }
    }

    private void hacerPaso() throws TobilloEsguinzado {
		// TODO completar
    	Random random = new Random();
    	int x = random.nextInt(50);   
    	
    	if(x>=30){
    		
    	}else if(x>=10 && x<30) {
    		new NecesitaTomarAgua();
    	}else if(x>5 && x<10){
    		new RoturaDelCalzado();
    	}else {
    		throw new TobilloEsguinzado();
    	}
    	
    	
	}


	public void paint(Graphics g)
    {
        g.setColor(color);
        g.fillOval((int) x, (int) y , 20, 20);

        g.setColor(Color.white);
        g.setFont(new Font("TimesRoman", Font.BOLD, 15));
        g.drawString("" + this.numeroCorredor, (int) x + 6, (int) y + 14);
    }
   
}
