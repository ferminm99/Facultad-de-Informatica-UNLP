program x;
Type

  tCliente = record
    dni: string;
    apYNom: String[51];
    eMail: String[35];
    fechaAlta: LongWord;
    proxLibre: word; {0 indica que no hay posiciones libres}
    activo: boolean;
    end;

  tArchClientes = file of TCliente;

{----------------------------------------------------------}
procedure Crear (var cli: tArchClientes);
var
  r: tCliente;
begin
  r.dni:= '-1';
  r.proxLibre:= 0;
  write(cli, r);
  writeln('Archivo cargado!');
  writeln;
end;
{----------------------------------------------------------}
procedure Eliminar (var cli: tArchClientes; dni: string; var ok: boolean);
var
  pos: integer; r, cabecera: tCliente;
begin
  ok:= false;
  r.dni:= '-1';
  while( (r.dni <> dni) and (not EOF(cli)) ) do
    read(cli, r);
  if(r.dni = dni) then begin
    ok:= true;
    //guardo la pos del borrado y pongo el dni en -
    pos:= filePos(cli) - 1;
    r.dni:= r.dni + ' borrado';

    //prox del borrado es el que está en cabecera
    seek(cli, 0);
    read(cli, cabecera);
    r.proxLibre:= cabecera.proxLibre;
    seek(cli, pos);
    write(cli, r);


    //prox cabecera es el borrado
    cabecera.proxLibre:= pos;
    seek(cli, 0);
    write(cli, cabecera);
  end;
end;
{----------------------------------------------------------}
procedure Insertar (var cli: tArchClientes; r: TCliente);
var
  cabecera, anterior: tCliente;
begin
  reset(cli);
  read(cli, cabecera);

  if(cabecera.proxLibre = 0) then begin
    seek(cli, fileSize(cli));
    write(cli, r);
    end
  else begin
    seek(cli, cabecera.proxLibre);
    read(cli, anterior);
    seek(cli, filePos(cli) -1);
    write(cli, r);
    cabecera.proxLibre:= anterior.proxLibre;
    reset(cli);
    write(cli, cabecera);
  end;
end;
{----------------------------------------------------------}
procedure leerRegistro(var r: TCliente);
begin
  write('Ingrese el dni: ');
  readln(r.dni);
  r.proxLibre:= 0;
end;
{----------------------------------------------------------}
procedure imprimir (var cli: TArchClientes);
var
  r: TCliente;
begin
  while(not EOF(cli)) do begin
    read(cli, r);
    writeln('Registro:');
    writeln(r.dni);
    writeln(r.proxLibre);
    writeln;
  end;
end;
{----------------------------------------------------------}
{----------------------------------------------------------}
{----------------------------------------------------------}

var
  nomb: string; cli: tArchClientes; reg: TCliente; dniElim: string; ok: boolean; opc: char;
begin

  writeln('1. crear, 2. insertar, 3. eliminar, 4.imprimir');
  write('Ingrese la opcion a elegir: ');
  readln(opc);
  writeln;
  while(opc <> '0') do begin
    if(opc = '1') then begin
      write('Ingrese el nombre del archivo con el que desea trabajar: ');
      readln(nomb);
      assign(cli, nomb);
      rewrite(cli);
      crear(cli);
      close(cli);
      end;

    if(opc = '3') then begin
      write('Ingrese el nombre del archivo con el que desea trabajar: ');
      readln(nomb);
      assign(cli, nomb);
      reset(cli);
      write('Ingrese dni a eleminar: ');
      readln(dniElim);
      eliminar(cli, dniElim, ok);
      if (ok) then
        writeln('Se eliminó correctamente')
      else
        writeln('No se pudo eliminar');
      close(cli);
    end;

    if(opc = '2') then begin
      write('Ingrese el nombre del archivo con el que desea trabajar: ');
      readln(nomb);
      assign(cli, nomb);
      reset(cli);
      leerRegistro(reg);
      insertar(cli, reg);
      close(cli);
    end;

    if(opc = '4') then
      write('Ingrese el nombre del archivo con el que desea trabajar: ');
      readln(nomb);
      assign(cli, nomb);
      reset(cli);
      imprimir(cli);
      close(cli);

    writeln;
    write('Ingrese la opcion a elegir: ');
    readln(opc);
    writeln;
  end;
end.
