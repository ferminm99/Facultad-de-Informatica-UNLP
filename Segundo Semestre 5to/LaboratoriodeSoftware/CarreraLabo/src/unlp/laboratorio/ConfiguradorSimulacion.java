package unlp.laboratorio;

import static java.lang.annotation.RetentionPolicy.RUNTIME;

import java.lang.annotation.Retention;

@Retention(RUNTIME)
public @interface ConfiguradorSimulacion {
	int cantidadPistasHabilitadas();
}
