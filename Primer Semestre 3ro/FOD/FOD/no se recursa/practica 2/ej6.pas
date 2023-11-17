program ej6;
const
	valor_alto = 9999999999;
type
	registro = record
		cod_cliente : integer;
		nombre : String;
		apellido : String;
		año : integer;
		mes : integer;
		dia : integer;
		monto : integer;
	end;

	archivo = file of registro;

procedure leer(var arch : archivo; var reg : registro);
	begin
		if(eof(arch)) then
			reg.cod_cliente := valor_alto
		else
			read(arch,reg);
	end;

procedure informar(var arch : archivo);
	var
		reg : registro;

		cod_acutal, año_actual, mes_actual : integer;
		total_año, total_mes : integer;
		monto_total : integer;
	begin
		reset(arch);
		leer(arch, reg); monto_total := 0;
		while(reg.cod_cliente <> valor_alto) do begin
			cod_acutal := reg.cod_cliente;
			while(cod_acutal = reg.cod_cliente) do begin
				año_actual:= reg.año; total_año := 0;
				while(año_actual = reg.año) do begin
					mes_actual := reg.mes; total_mes := 0;
					while (año_actual = reg.año) and (mes_actual = reg.mes) do begin
						total_mes := total_mes + reg.monto;
						leer(arch, reg);
					end;
					total_año := total_año + total_mes;
				end;
				monto_total := monto_total + total_año;
			end;
			// informar el completo del cliente
		end;
	end;