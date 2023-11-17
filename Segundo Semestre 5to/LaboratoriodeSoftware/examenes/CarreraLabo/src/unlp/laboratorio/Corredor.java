package unlp.laboratorio;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.lang.reflect.Method;
import java.util.concurrent.TimeUnit;

import unlp.laboratorio.anotaciones.ConfiguradorVelocidad;
import unlp.laboratorio.excepciones.NecesitaTomarAguaException;
import unlp.laboratorio.excepciones.RoturaDelCalzadoException;
import unlp.laboratorio.excepciones.TobilloEsguinzadoException;

public class Corredor implements Runnable {
    double x, y;
    Color color;
    int numeroCorredor;
    int velocidad;
    int espera;

    public Corredor( Color color, int numeroCorredor) {
         	
        this.x = 420;
        this.y = 25 * numeroCorredor;
        this.color = color;
        this.numeroCorredor = numeroCorredor;
        
        // Pienso que seria mas comodo obtener el min y el max como parametro
        // pero en pos de no tocar demaciado las firmas de los metodos provistos
        // decidi recuperar los valores via Reflection.
    	try {
    		Class<Circuito> cl = Circuito.class;
			Method m = cl.getDeclaredMethod("iniciarCircuito", int.class);
			ConfiguradorVelocidad annot = m.getAnnotation(ConfiguradorVelocidad.class);
			int max = annot.velocidadMax();
			int min = annot.velocidadMin();
			this.velocidad = (int) (Math.random() * ((max + 1) - min)) + min;
			this.espera = max+100 - this.velocidad;
    	} catch (NoSuchMethodException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SecurityException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
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
			} catch (NecesitaTomarAguaException e) {
				System.out.println("Corredor#"+this.numeroCorredor+": Necesito tomar agua");
				try {
					TimeUnit.SECONDS.sleep(2);
				} catch (InterruptedException e1) {
					e1.printStackTrace();
				}
			} catch (RoturaDelCalzadoException e) {
				System.out.println("Corredor#"+this.numeroCorredor+": Se me rompio el calzado");
				try {
					TimeUnit.SECONDS.sleep(5);
				} catch (InterruptedException e1) {
					e1.printStackTrace();
				}
			} catch (TobilloEsguinzadoException e) {
				// TODO Auto-generated catch block
				System.out.println("Corredor#"+this.numeroCorredor+": Me esguince el tobillo");
				break;
			}
    		
        }
    }

    private void hacerPaso() throws NecesitaTomarAguaException, RoturaDelCalzadoException, TobilloEsguinzadoException {
    	
    	try {
			TimeUnit.MILLISECONDS.sleep(this.espera);
			
			double accidentrometro = Math.random();
	        if (accidentrometro < 0.02)
	        	throw new NecesitaTomarAguaException();
	        else if (accidentrometro < 0.028)
	        	throw new RoturaDelCalzadoException();
	        else if (accidentrometro < 0.0281)
	        	throw new TobilloEsguinzadoException();
	        
		} catch (InterruptedException e) {
			e.printStackTrace();
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
