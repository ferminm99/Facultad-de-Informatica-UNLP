program ej9;
const
	valor_alto := "zzzzzzzzzzzzzzzzz";
type
	regmae = record
		nombre : String;
		cant : integer;
		total : integer;
	end;

	regdet = record
		nombre : String;
		cod : integer;
		cant : integer;
		total : integer;
	end;

	arch_mae = file of regmae;
	arch_det = file of regdet;

procedure leer_mae(var arch : arch_mae; var reg : regmae);
	begin
		if(eof(arch)) then
			reg.nombre := valor_alto
		else
			read(arch, reg);
	end;

procedure leer_det(var arch : arch_det; var reg : regdet);
	begin
		if(eof(arch)) then
			reg.nombre := valor_alto
		else
			read(arch, reg);
	end;

procedure minimo(var det1 : arch_det; var det2 : arch_det; var reg1 : regdet; var reg2 : regdet; var min : regdet);
	begin
		if(reg1.nombre < reg2.nombre)then begin
			read(det1, reg1);
			min := reg1;
		end else begin
			read(det2, reg2);
			min := reg2;
		end;
	end;


var
	
	Amae : arch_mae;
	regmae : regmae;
	det1 : arch_det; reg1 : regdet;
	det2 : arch_det; reg2 : regdet;
	min : regdet;
	total_encuestados : integer;
	total_alfabetizados : integer;
	provincia_actual : String;
begin

	reset(mae);
	reset(det1); reset(det2);
	leer_mae(mae,regmae);
	leer_det(det1, reg1);
	leer_det(det2, reg2);
	minimo(det1,det2,reg1,reg2,min);
	while(min.nombre <> valor_alto) do begin
		while(min.nombre <> regmae.nombre) do begin
			leer_mae(mae, regmae);
		end;
		provincia_actual := min.nombre; 
		total_alfabetizados := 0; total_encuestados := 0;
		while(provincia_actual = min.nombre) do begin
			total_alfabetizados := total_alfabetizados + min.cant;
			total_encuestados := total_encuestados + min.total;
			minimo(det1,det2,reg1,reg2,min);
		end;
		regmae.cant := total_alfabetizados;
		regmae.total := total_encuestados;
		seek(mae, filepos(mae)-1);
		write(mae, regmae);
	end;
end.