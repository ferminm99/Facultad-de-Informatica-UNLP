program ej9;
const
	sc = '|';
	sr = '*';
type
	producto = record
		nombre : String;
		descripcion : String;
		precio : integer;
		st_minimo : integer;
		st_actual : integer;
	end;
procedure leer_registro(var r : producto);
	begin
		write('Ingresar nombre: '); readln(r.nombre);
		if  r.nombe <> 'fin' then begin
			write('Ingresar descripcion: '); readln(r.descripcion);
			write('Ingresar precio: '); readln(r.precio);
			write('Ingresar stock minimo: '); readln(r.st_minimo);
			write('Ingresar stock actual: '); readln(r.st_actual);
		end;
	end;
procedure crear();
	var
		nombre_archivo : String;
		r : producto;
		aux : String;
		arch : file;
	begin
		writeln('Ingresar nombre del archivo'); readln(nombre_archivo);
		assign(arch,nombre_archivo);
		rewrite(arch, 1);
		leer_registro(r);
		while(r.nombre <> 'fin') do begin
			blockwrite(arch, r.nombre[1], length(r.nombre));
			blockwrite(arch, sc, length(sc));
			blockwrite(arch, r.descripcion[1], length(r.descripcion));
			blockwrite(arch, sc, length(sc));
			str(r.precio, aux); // lo convierto a string
			blockwrite(arch, aux[1], length(aux));
			blockwrite(arch, sc, length(sc));
			str(r.st_minimo, aux); // lo convierto a string
			blockwrite(arch, aux[1], length(aux));
			blockwrite(arch, sc, length(sc));
			str(r.st_actual, aux); // lo convierto a string
			blockwrite(arch, aux[1], length(aux));
			blockwrite(arch, sc, length(sc));
			blockwrite(arch, sr, length(sr));
			leer_registro(r);
		end;
		close(arch);
	end;
procedure informar_producto(r : producto);
	begin
		writeln('INFORMACION DE REGISTRO');
		writeln('	NOMBRE DEL PRODUCTO: ', r.nombre);
		writeln('	DESCRIPCION DEL PRODUCTO: ', r.descripcion);
		writeln('		STOCK MINIMO: ', r.st_minimo);
		writeln('		STOCK ACTUAL: ', r.st_actual);
	end;

procedure read_reg(var a : arch; var r : producto);
	var
		buffer : byte;
		campo : String;
	begin
		blockread(arch, buffer, 1); 
		nro_campo := 0;
		while(campo <> sr) and (not eof(arch)) do begin
			campo = '';
			while(campo <> sr) and (campo <> sc) and (not eof(arch)) do begin
				campo = campo + buffer;
				blockread(arch, buffer, 1);
			end;
			case(nro_campo):
				0: r.nombre := campo;
				1: r.descripcion := campo;
				2: r.precio := StrToInt(campo);
				3: r.st_minimo := StrToInt(campo);
				4: r.st_actual := StrToInt(campo);
			end;
			if(campo = sc) and (not eof(arch)) do begin
				blockread(arch, buffer, 1);
				nro_campo := nro_campo + 1;
			end;
		end;
	end;

procedure leer(var a : arch; var r : producto);
	begin
		if(eof(a)) then
			r.nombre := valor_alto
		else
			read_reg(a, r);
	end;

procedure listar();
	var
		r : producto;
		a : file;
		nombre_archivo : String;
		nro_campo : integer;
	begin
		writeln('Ingresar nombre del archivo'); readln(nombre_archivo);
		assign(a,nombre_archivo);
		reset(a);
		leer(a, r);
		while(r.nombre <> valor_alto) do begin
			informar_producto(r);
			leer(a, r);
		end;
		close(a);
	end;