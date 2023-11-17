program ej4;
const
	valor_alto = "zzzzzzzzzzzzz";
type
	tTitulo = String[50];
	tArchLibros = file of tTitulo ;
procedure leer(var arch : tArchLibros; var r : tTitulo);
	begin
		if(eof(arch))then
			r := valor_alto;
		else
			read(arch,r);
	end;
procedure agregar(var a: tArchLibros ; titulo: string);
	var
		reg : tTitulo;
		cabecera : integer;
		eli : tTitulo;
	begin
		reset(a);
		leer(a, reg);
		cabecera := StrToInt(reg);
		if(cabecera = 0)then
			seek(a, filesize(a))
		else begin
			seek(a, cabecera);
			leer(arch, eli);
			seek(a, 0);
			write(a, eli);
			seek(a, cabecera);			
		end;
		write(a, titulo);
		close(a);
	end;

procedure eliminar (var a: tArchLibros ; titulo: string);
	var
		cabecera : integer;
		reg : tTitulo;
		encontrado : boolean;
		pos : integer;
	begin
		reset(a);
		encontrado := false;
		leer(a, reg);
		cabecera := StrToInt(reg);
		while(reg <> valor_alto)and(not encontrado) do begin
			if(reg = titulo)then
				encontrado := true;
			else
				leer(a, reg);
		end;
		if(not encontrado) then write("no se encontro el titulo: ",titulo)
		else begin
			pos := filepos(a);
			write(a, cabecera);
			seek(a, 0);
			write(a, pos);
		end;
		close(a);
	end;