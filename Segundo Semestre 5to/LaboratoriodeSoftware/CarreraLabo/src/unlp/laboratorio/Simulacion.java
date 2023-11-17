package unlp.laboratorio;
import java.awt.Color;
import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import unlp.laboratorio.gui.PanelCircuito;


public class Simulacion {
	public static void iniciarSimulacion(Circuito unCircuito) {
		//TODO
		int cantidadPistasHabilitadas = 0;
		int cantidadCorredores = 0;
		ExecutorService exec =Executors.newFixedThreadPool(cantidadPistasHabilitadas);
		
		
		
		System.out.println("PREPARADOS...");
		System.out.println("LISTOS...");
		System.out.println("¡YA!");
		for ( int i = 0; i < cantidadCorredores-1; i++)
			try {
	        	
	            Class myClass = unCircuito.getClass();
	            for(Annotation a : myClass.getAnnotations()){
	            	
	                if(a.annotationType() == ConfiguradorSimulacion.class){
	                	ConfiguradorSimulacion configuradorSimulacion = (ConfiguradorSimulacion) a;
	                	if(configuradorSimulacion.cantidadPistasHabilitadas() >= 1 && configuradorSimulacion.cantidadPistasHabilitadas() <= 8) {
	                		
	                		
	                		for(Field field : myClass.getDeclaredFields()){
		                        for(Annotation an : field.getDeclaredAnnotations()){
		                            if(an.annotationType() == ConfiguradorVelocidad.class){
		                                field.setAccessible(true);
		                                
		                                ConfiguradorVelocidad configuradorVelocidad = (ConfiguradorVelocidad) an;
		        	                	if(configuradorVelocidad.cantidadCorredores() <= cantidadCorredores && 
		        	                			configuradorVelocidad.velocidadMin()>=5 &&
		        	                			configuradorVelocidad.velocidadMax()<=20) {
		        	                		List<Corredor> corredores = unCircuito.getCorredores();
		        	                		for(Corredor corredor : corredores)
		        	                		{
		        	                			exec.execute(corredor);
		        	                		}
		        	                		
		        	                		
		        	                		
		        	                	}
		                            
		                            }
		                        }
		                    }
	                		
	                		
	                	}
	                	
	                    
	                }
	                
	            }
	        }catch(Exception e) {
	            System.out.println(e.getMessage());
	            e.printStackTrace();
	        }
			
			
		exec.shutdown();
	}
	
	
}
