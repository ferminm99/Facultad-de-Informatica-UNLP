program code;
const
	ruta = 'C:\Users\Thugg\Desktop\Tercer Cuatrimestre\FOD\no se recursa\pruebas\lista invertida\';
	valor_alto = 99999999;
type
	reg = record
		dni : integer;
		nombre : String;
	end;
	arch = file of reg;
procedure read_reg(var a : arch; var r : reg);
	begin
		if(eof(a)) then
			r.dni := valor_alto
		else
			read(a, r);
	end;
procedure leer_reg(var r : reg);
	begin
		write('Ingresar dni: '); readln(r.dni);
		if(r.dni <> 0) then write('Ingresar nombre: '); readln(r.nombre);
	end;

procedure crear(var a : arch);
	var
		r : reg;
	begin
		rewrite(a);
		r.dni := 0;
		r.nombre := '';
		write(a, r); // cabecera
		leer_reg(r);
		while(r.dni <> 0) do begin
			write(a, r);
			leer_reg(r);
		end;
		close(a);
	end;
procedure listar(var a : arch);
	var
		r : reg;
	begin
		reset(a);
		read_reg(a, r);
		while(r.dni <> valor_alto) do begin
			writeln('dni: ',r.dni,' || nombre: ', r.nombre);
			read_reg(a, r);
		end;
		close(a);
	end;
procedure eliminar(var a : arch; dni : integer);
	var
		r : reg;
		cabecera : integer;
		encontrado : boolean;

		pos_eli : integer;
	begin
		reset(a);
		read_reg(a, r);
		cabecera := r.dni;
		encontrado := false;		
		read_reg(a, r);
		while(r.dni <> valor_alto)and(not encontrado) do begin
			if(r.dni = dni) then
				encontrado := true
			else
				read_reg(a, r);
		end;
		if(encontrado) then begin
			seek(a, filepos(a)-1);
			pos_eli := filepos(a);
			r.dni := cabecera;
			write(a, r);
			seek(a, 0);
			r.dni := pos_eli * -1;
			r.nombre := '';
			write(a, r);
		end else writeln('no se encontro el dni a eliminar');
		close(a);
	end;
procedure agregar(var a : arch; dni : integer; nombre : String);
	var
		cabecera : integer;
		r : reg;
		pos_eli : integer;
	begin
		reset(a);
		read_reg(a, r);
		cabecera := r.dni;
		pos_eli := 0;
		if(cabecera = 0) then seek(a, filesize(a))
		else begin
			seek(a, cabecera * -1);
			read_reg(a, r);
			pos_eli := r.dni;
			seek(a, filepos(a)-1);
		end;
		r.dni := dni;
		r.nombre := nombre;
		write(a, r);
		seek(a, 0);
		r.dni := pos_eli;
		r.nombre := '';
		write(a, r);
		close(a);
	end;
var
	a : arch;
	opcion : integer;
	dni : integer;
	nombre : String;
begin
	assign(a, ruta+'archivo.dat');
	repeat
		writeln('1 - cargar');
		writeln('2 - listar');
		writeln('3 - agregar dni');
		writeln('4 - eliminar dni');
		writeln('9 - salir');
        readln(opcion);
		case(opcion) of
			1: crear(a);
			2: listar(a);
			3: begin write('ingresar dni a agregar: '); readln(dni); write('ingresar nombre a agregar: '); readln(nombre); agregar(a, dni, nombre) end;
			4: begin write('ingresar dni a eliminar: '); readln(dni); eliminar(a, dni) end;
		end;
	until(opcion = 9);
end.
