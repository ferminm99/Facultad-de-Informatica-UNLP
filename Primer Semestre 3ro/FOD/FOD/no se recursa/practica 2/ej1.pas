program ej1;
const
	valor_alto = 9999999;
type
	ingreso = record
		cod : integer;
		nombre : String;
		monto : integer;
	end;

	arch = file of ingreso;
procedure leer(var arch : arch; var reg : ingreso);
	begin
		if(eof(arch))then 
			reg.cod := valor_alto;
		end else 
			read(arch,reg);
	end;
procedure compactar(var arch : arch);
	var
		new : arch;
		reg_actual : ingreso;
		reg : ingreso;
	begin
		rewrite(new);
		reset(arch);
		leer(arch,reg);
		while(reg.cod <> valor_alto) do begin
			reg_actual := reg;
			while(reg_actual.cod = reg.cod)do begin
				leer(arch,reg);
				reg_actual.monto := reg_actual.monto + reg.monto;
			end;
			write(new,reg_actual);
		end;
		close(new);
		close(arch);
	end;