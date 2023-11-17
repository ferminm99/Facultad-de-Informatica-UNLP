program ej3;
const
	n = 4;
	valor_alto = 9999999999;
type
	producto = record
		cod : integer;
		desc : String;
		precio : integer;
		stock_actual : integer;
		stock_minimo : integer;
	end;

	pedido = record
		cod : integer;
		cant : integer;
	end;

	mae = file of producto;
	det = file of pedido;

	vec_det = array[1..n] of det;
	vec_reg = array[1..n] of pedido;

procedure leer_det(var det : det; var reg : pedido);
	begin
		if(eof(det))then
			reg.cod = valor_alto;
		end else
			read(det, reg);
	end;

procedure leer_mae(var mae : mae; var reg : producto);
	begin
		if(eof(det))then
			reg.cod = valor_alto;
		end else
			read(mae, reg);
	end;

procedure minimo(var Vdet : vec_det; var Vreg : vec_reg; var min : pedido; var pos_min: integer);
	var
		i : integer;
	begin
		min.cod := valor_alto;
		pos_min := valor_alto;
		for	i:=1 to n do begin
			if(Vreg[i].cod < min.cod) then begin
				min := Vreg[i];
				pos_min := i;
			end;
		end;
		if(min.cod <> valor_alto) then begin
			read(Vdet[pos_min], Vreg[pos_min]);
		end;
	end;

procedure actualizar(var mae : mae; var Vdet : vec_det);
	var
		Vreg : vec_reg;
		reg_mae : producto;
		i : integer;
		min : pedido;
		cant_pedida : integer;
		pedido_actual : pedido;
		sucursal : integer;
	begin
		for i:=1 to n do begin
			reset(Vdet[i]); leer_det(Vdet[i],Vreg[i]);
		end;
		reset(mae);
		leer_mae(mae, reg_maeg);
		minimo(Vdet, Vreg, min, sucursal);
		while(min.cod <> valor_alto) do begin
			cant_pedida := 0;
			pedido_actual := min;
			while(pedido_actual.cod = min.cod)do begin
				cant_pedida := cant_pedida + min.cant;
				minimo(Vdet, Vreg, min, sucursal);
			end;
			if(reg_mae.stock_actual - cant_pedida <= 0)then
				writeln("faltan elementos");
				wirteln("sucursal: ", sucursal);
				writeln("producto: ", reg_mae.cod):
				writeln("elementos faltantes: ", (cant_pedida - reg_mae.stock_actual) );
			else begin
				if(reg_mae.stock_actual - cant_pedida < reg_mae.stock_minimo) then
					writeln("el producto quedo por debajo del stock minimo")
			end;
			reg_mae.stock_actual := reg_mae.stock_actual - cant_pedida;
			seek(mae, filepos(mae) - 1);
			write(mae, reg_mae);
		end;
		for i:=1 to n do begin
			close(Vdet[i]);
		end;
		close(mae);
	end;