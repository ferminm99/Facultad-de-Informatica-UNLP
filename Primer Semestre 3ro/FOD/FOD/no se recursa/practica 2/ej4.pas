program ej4;
const
	n = 5;
	valor_alto = 999999999;
type
	maestro = record
		cod_usuario : integer;
		fecha : integer;
		tiempo_total : integer;
	end;

	registro = record
		cod_usuario : integer;
		fecha : String;
		tiempo_sesion : integer;
	end;

	arch_det = file of registro;

	vec_det = array[1..n] of arch_det;

	vec_reg = array[1..n] of registro;

procedure leer(var arch : arch_det; var reg : registro);
	begin
		if(eof(arch)) then 
			reg.cod_usuario := valor_alto;
		else
			read(arch, reg);
	end;

procedure minimo(var Vdet : vec_det; var Vreg : vec_reg; min : registro);
	var
		i, pos_min : integer;
	begin
		min.cod := valor_alto;
		for	i:=1 to n do begin
			if(Vreg[i].cod <= min.cod) and (Vreg[i].fecha < min.fecha) then begin
				min := Vreg[i];
				pos_min := i;
			end;
		end;
		// for i:= 1 to n do begin
		// 	if(Vreg[i].cod < min.cod)then begin
		// 		min := Vreg[i];
		// 		pos_min := i;
		// 	end else begin
		// 		if(Vreg[i].cod = min.cod)then begin
		// 			if(Vreg[i].fecha < min.fecha) then begin
		// 				min := Vreg[i];
		// 				pos_min := i;

		// 			end;
		// 		end;
		// 	end;
		// end;
		if(min.cod <> valor_alto) then
			read(Vdet[pos_min], Vreg[pos_min]);
	end;

procedure merge(var Vdet : vec_det);
	var
		Vreg : vec_reg;
		min : registro;
		mae : file of maestro;
		reg_mae : maestro;
	begin
		rewrite(mae);
		for i:= 1 to n do begin
			reset(Vdet[i]); leer(Vdet[i], Vreg[i]);
		end;
		minimo(Vdet, Vreg, min);
		while(min.cod <> valor_alto) do begin
			reg_mae.cod := min.cod;
			reg_mae.fecha := min.fecha;
			reg_mae.tiempo_total := min.tiempo_sesion;
			while (reg_mae.cod = min.cod) and (reg_mae.fecha = min.fecha) do begin
				minimo(Vdet, Vreg, min);
				reg_mae.tiempo_total := reg_mae.tiempo_total + min.tiempo_sesion;
			end;
			write(mae,reg_mae);
		end;
		for i:= 1 to n do begin
			close(Vdet[i]);
		end;
		close(mae);
	end;