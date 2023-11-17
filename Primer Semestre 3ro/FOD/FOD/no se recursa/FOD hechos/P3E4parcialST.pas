program x;
Type
  novela = record
    cod: integer;
    nomb: string;
    end;

  rArch = record
    novela: novela;
    enlace: integer;
    end;

  arch_mae = file of rArch;
  arch_txt = text;

{------------------------------------------------}
procedure agregarNovela(var mae: arch_mae; r: rArch);
var
  cabecera, rAnterior: rArch;
begin
  read(mae, cabecera);
  if (cabecera.novela.cod = 0) then begin
    seek(mae, fileSize(mae));
    write(mae, r);
    end
  else begin
    seek(mae, cabecera.enlace);
    read(mae, rAnterior);

    cabecera.enlace:= rAnterior.enlace;
    cabecera.novela.cod:= cabecera.novela.cod - 1;

    seek(mae, filePos(mae) - 1);
    write(mae, r);

    seek(mae, 0);
    write(mae, cabecera);

  end;
end;
{------------------------------------------------}
procedure modificarNovela(var mae: arch_mae; codNovela: integer);
var
  r: rArch; nuevoNomb: string;
begin
  seek(mae, 1);

  r.novela.cod:= -1;
  while ((not EOF(mae)) and (r.novela.cod <> codNovela)) do
    read(mae, r);
  
  if(r.novela.cod <> codNovela)then
    writeln('No se encontro la novela que se desea modificar.')
  else begin
    writeln('Ingrese el nuevo nombre para la novela');
    readln(nuevoNomb);
    r.novela.nomb:= nuevoNomb;
    seek(mae, filePos(mae) - 1);
    write(mae, r);
  end;
end;
{------------------------------------------------}
procedure eliminarNovela(var mae: arch_mae; codNovela: integer);
var
  cabecera, r: rArch; pos: integer;
begin
  read(mae, cabecera);

  r.novela.cod:= -1;
  while ((not EOF(mae)) and (r.novela.cod <> codNovela)) do
    read(mae, r);

  if(r.novela.cod <> codNovela)then
    writeln('No se encontro la novela que se desea borrar.')
  else begin
    pos:= filePos(mae) -1;
    r.novela.cod:= r.novela.cod * -1;
    r.enlace:= cabecera.enlace;
    seek(mae, pos);
    write(mae, r);

    cabecera.enlace:= pos;
    cabecera.novela.cod:= cabecera.novela.cod + 1; 
    seek(mae, 0);
    write(mae, cabecera);
  end;
end;
{------------------------------------------------}
procedure leerRegistro(var r: rArch);
begin
  write('Ingrese codigo de la novela: ');
  readln(r.novela.cod);
  if (r.novela.cod <> -1) then begin
    write('Ingrese el nombre de la novela: ');
    readln(r.novela.nomb);
    r.enlace:= -1;
  end;
end;


{------------------------------------------------}
procedure cargarArchivo(var mae: arch_mae);
var
  r: rArch;
begin
  //escribo cabezera
  r.novela.cod := 0;
  r.novela.nomb:= 'Cabecera';
  r.enlace:= -1;
  write(mae, r);

  //escribo resto de archivos
  leerRegistro(r);
  while(r.novela.cod <> -1) do begin
    write(mae, r);
    leerRegistro(r);
  end;
end;
{------------------------------------------------}

var
  opc: char; nombre: string; mae: arch_mae; codNovela: integer; nov: rArch; txt: arch_txt;
begin
  writeln('Ingrese una opcion: ');
  writeln('A- Crear el archivo');
  writeln('B- Dar de alta una novela');
  writeln('C- Modificar los datos de una novela');
  writeln('D- Eliminar una novela');
  writeln('E- Listar en un archivo de texto todas las novelas, incluyendo las borradas');
  write('Opcion: ');
  readln(opc);
  writeln;
  case opc of
    'A', 'a': begin
      writeln('Ingrese el nombre del archivo a crear');
      readln(nombre);
      assign(mae, nombre);
      rewrite(mae);
      cargarArchivo(mae);
      close(mae);
      writeln;
    end;
    'B', 'b', 'C', 'c', 'D', 'd': begin
      writeln('Ingrese el nombre del archivo a modificar');
      readln(nombre);
      assign(mae, nombre);
      reset(mae);

      case opc of
        'B', 'b': begin
          leerRegistro(nov);
          agregarNovela(mae, nov);
        end;
        'C', 'c': begin
          write('Ingrese el codigo de la novela a modificar: ');
          readln(codNovela);
          modificarNovela(mae, codNovela);
        end;
        'D', 'd': begin
          write('Ingrese el codigo de la novela a eliminar: ');
          readln(codNovela);
          eliminarNovela(mae, codNovela);
        end;
      end;
      close(mae);
    end;
    'E', 'e': begin
      writeln('Ingrese el nombre del archivo a imprimir');
      readln(nombre);
      assign(mae, nombre);
      reset(mae);
      writeln('Ingrese el nombre del archivo a crear');
      readln(nombre);
      assign(txt, nombre + '.txt');
      rewrite(txt);

      while(not EOF(mae)) do begin
        read(mae, nov);
        write(txt, 'cod: ');
        writeln(txt, nov.novela.cod);
        write(txt, 'nomb: ');
        writeln(txt, nov.novela.nomb);
        write(txt, 'enlace: ');
        writeln(txt, nov.enlace);
        writeln(txt,'');
      end;

      close(mae);
      close(txt);
    end;

  end;
  writeln('Fin del programa.');
  readln;
end.
