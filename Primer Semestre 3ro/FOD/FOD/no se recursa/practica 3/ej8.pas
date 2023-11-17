program ej8;
const
	valor_alto = 999999999999;
type
	empleado = record
		cod : integer;
		dni : integer;
		apellido : String;
		nombre : String;
		peso : integer;
		estatura : integer;
		fecha : LongInt;
	end;

procedure leer_registro(var e : empleado);
	begin
		readln(e.cod);
		if(e.cod <> valor_corte) then begin
			readln(e.dni);
			readln(e.apellido);
			readln(e.nombre);
			readln(e.peso);
			readln(e.estatura);
			readln(e.fecha);
		end;
	end;

procedure escribir_registro(var a : file; e : empleado);
	var
		tam : byte;
	begin
		// tamaño del registro
		tam := sizeof(e.cod) + sizeof(e.dni) + (length(e.apellido) + 1) + (length(e.nombre) + 1)  // + 1 byte por cada string
			+ sizeof(e.peso) + sizeof(e.estatura) + sizeof(e.fecha)
		blockwrite(a, tam, sizeof(tam));
		// resto de datos
		blockwrite(a, e.cod, sizeof(e.cod));
		blockwrite(a, e.dni, sizeof(e.dni));
		blockwrite(a, e.apellido, length(e.apellido)+1);
		blockwrite(a, e.nombre, length(e.nombre)+1);
		blockwrite(a, e.peso, sizeof(e.peso));
		blockwrite(a, e.estatura, sizeof(e.estatura));
		blockwrite(a, e.fecha, sizeof(e.fecha));
	end;

procedure cargar(var a : file);
	var
		e : empleado;
	begin
		reset(a, 1);
		leer_registro(e);
		while(e.cod <> valor_corte) do begin
			escribir_registro(a, e);
			leer_registro(e);
		end;
		close(a);
	end;

procedure read_reg(var a : file; var e : empleado);
	var
		tamCampo, tamReg, i : byte;
		datos : array[1..256] of byte;
	begin
		blockread(a, tamReg, sizeof(tamReg));
		blockread(a, datos, tamReg);
		i := 1;

		move(dato[i], e.cod, sizeof(e.cod)); // primer campo (cod)
		i := i + sizeof(e.cod);

		move(dato[i], e.cod, sizeof(e.dni)); // segundo campo(dni)
		i := i + sizeof(e.dni);

		tamCampo := dato[i];	// terce rcampo (apellido)
		setLength(e.apellido, tamCampo);
		mov(dato[i], e.apellido, tamCampo + 1)
		i := i + tamCampo + 1;

		tamCampo := dato[i];	// cuarto campo (nombre)
		setLength(e.nombre, tamCampo);
		mov(dato[i], e.apellido, tamCampo + 1)
		i := i + tamCampo + 1;

		move(dato[i], e.peso, sizeof(e.peso)); // quinto campo (peso)
		i := i + sizeof(e.peso);

		move(dato[i], e.estatura, sizeof(e.estatura)); // sexto campo (estatura)
		i := i + sizeof(e.estatura);

		move(dato[i], e.fecha, sizeof(e.fecha)); // septimo campo (fecha)
		i := i + sizeof(e.fecha);

	end;
procedure leer(var a : file; var e : empledao);
	begin
		if(eof(a)) then 
			e.cod := valor_alto;
		else
			read_reg(a, e);
	end;
procedure informar_registro(e : empleado);
	begin
		writeln('codigo: ', e.cod);
		writeln('dni: ', e.dni);
		writeln('apellido: ', e.apellido);
		writeln('nombre: ', e.nombre);
		writeln('peso: ', e.peso);
		writeln('estatura: ', e.estatura);
		writeln('fecha: ', e.fecha);
	end;

procedure listar_archivo(var a : file);
	var
		e : empleado;
	begin
		reset(a, 1);
		leer(a, e);
		while(e.cod <> valor_alto) do begin
			informar_registro(e);
			leer(a, e);
		end;
	end;