program ej2;
const
	valor_alto = 9999999999999999;
type
	empleado = record
		cod : integer;
		nombre : String;
		apellido : String;
		direccion : String;
		telefono : integer;
		dni : integer;
		fecha : String;
	end;
	arch = file of empleado;

procedure leer(var arch : arch; var reg : empleado);
	begin
		if(eof(arch))then
			reg.cod := valor_alto
		else
			read(arch,reg);
	end;

procedure borrar_menores(var arch : arch);
	var
		reg : empleado;
	begin
		reset(arch);
		leer(arch,reg);
		while(reg.cod <> valor_alto) do begin
			if(reg.dni < 5000000) then begin
				reg.nombre := '*' + reg.nombre;
				seek(arch, filepos(arch)-1);
				write(arch, reg);
			end;
			leer(arch,reg);
		end;
		close(arch);
	end;