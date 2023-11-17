program x;
const
  separador_de_campo: char = '|';
  separador_de_registro: char = '*';
Type

  producto = record
    nombre: string;
    desc: string;
    precio: real;
    SM: integer;
    SA: integer;
    end;

  arch_mae = file;

{-----------------------------------------------------------------------------}
procedure leerRegistro(var r: producto);
begin
  writeln('Nuevo producto: ');
  writeln('Ingrese el nombre del producto: ');
  readln(r.nombre);
  if (r.nombre <> 'fin') then begin
    writeln('Ingrese la descripcion del producto: ');
    readln(r.desc);
    writeln('Ingrese el precio del producto: ');
    readln(r.precio);
    writeln('Ingrese el stock minimo del producto: ');
    readln(r.SM);
    writeln('Ingrese el stock actual del producto: ');
    readln(r.SA);
  end;
end;
{-----------------------------------------------------------------------------}
procedure cargarArchivo (var arch: arch_mae);
var
  r: producto; newString: string;
begin
  rewrite(arch, 1);
  leerRegistro(r);
  while(r.nombre <> 'fin') do begin
    r.nombre:= r.nombre + separador_de_campo;
    blockwrite(arch, r.nombre[1], length(r.nombre));
    r.desc:= r.desc + separador_de_campo;
    blockwrite(arch, r.desc[1], length(r.desc));
    str(r.precio, newString);
    newString:= newString + separador_de_campo;
    blockwrite(arch, newString[1], length(newString));
    str(r.SM, newString);
    newString:= newString + separador_de_campo;
    blockwrite(arch, newString[1], length(newString));
    str(r.SA, newString);
    newString:= newString + separador_de_campo;
    blockwrite(arch, newString[1], length(newString));
    blockwrite(arch, separador_de_registro, 1);
    writeln;
    leerRegistro(r);
  end;
  writeln('Archivo cargado');
  close(arch);
end;
{-----------------------------------------------------------------------------}
procedure leerArchivo(var arch: arch_mae);
var
  car: char; campo: integer; palabra: string;
begin
  reset(arch, 1);
  palabra:= '';
  campo:= 1;
  writeln('-------------------------------------------');
  writeln('INFORMACION DEL REGISTRO');
  while(not EOF(arch)) do begin
    blockread(arch, car, 1);
    case car of
      '|': begin
        case campo of
          1: writeln('NOMBRE PRODUCTO: ');
          2: writeln('DESCRIPCION PRODUCTO: ');
          4: writeln('STOCK MINIMO: ');
          5: writeln('STOCK ACTUAL: ');
        end;
        if (campo <> 3) then
          writeln(palabra);
        campo:= campo + 1;
        palabra:= '';
      end;

      '*': begin
        writeln('-------------------------------------------');
        if(not EOF(arch)) then
          writeln('INFORMACION DEL REGISTRO');
        campo:= 1;
      end;
    else
      palabra:= palabra + car;
    end;
  end;
end;
{-----------------------------------------------------------------------------}
{-----------------------------------------------------------------------------}
{-----------------------------------------------------------------------------}
{-----------------------------------------------------------------------------}

var
  opc: char; nomb: string; arch: arch_mae;
begin
  writeln('Ingrese una de las opciones');
  writeln('A. Crear archivo');
  writeln('B. Leer archivo');
  write('Opcion: ');
  readln(opc);
  case opc of
    'A', 'a': begin
    writeln('Ingrese el nombre del archivo a crear');
    readln(nomb);
    assign(arch, nomb);
    cargarArchivo(arch);
    end;

    'B', 'b': begin
    writeln('Ingrese el nombre del archivo a leer');
    readln(nomb);
    assign(arch, nomb);
    leerArchivo(arch);
    end;

  end;
  readln;
end.
