program ej7_3;
const
  ruta = 'C:\Users\Thugg\Desktop\Tercer Cuatrimestre\FOD\practica3\ej7\';
  sc = '@'; // separador de campo
procedure crear_archivo(var archivo : file);
var
  nombre_cargado : String;
begin
  rewrite(archivo,1);
  write('Ingresar nombre: '); readln(nombre_cargado);
  while(nombre_cargado <> '')do begin
     BlockWrite(archivo,nombre_cargado[1],length(nombre_cargado));
     BlockWrite(archivo,sc,length(sc));
     write('Ingresar nombre: '); readln(nombre_cargado);
  end;
  close(archivo);
end;
procedure listar_archivo(var archivo : file);
var
  campo, buffer : String;
begin
  writeln('Listando archivo...');
  reset(archivo,1);

  while(not eof(archivo))do begin

     BlockRead(archivo,buffer,1);
     writeln('primer caracter: '+buffer);
     campo := '';
     while(buffer <> sc) and not eof(archivo) do begin
        writeln('entro al while');
        campo := campo + buffer;
        BlockRead(archivo,buffer,1);
     end;
     writeln('se encontro sc');
     writeln(buffer);
     if (buffer = 'sc') and not eof(archivo) then begin
        BlockRead(archivo,buffer,1);
     end;
  end;
  close(archivo);
end;
var
  eleccion : integer;
  archivo : file;
begin
  repeat
    writeln('###############      MENU    ###############');
    writeln('1 - Crear archivo');
    writeln('2 - Listar contenido');
    write('eleccion : ');readln(eleccion);
    writeln('################################');
    writeln;
    assign(archivo,ruta+'personas.dat');
    case (eleccion) of
      1: crear_archivo(archivo);
      2: listar_archivo(archivo);
    end;
    writeln;

  until( eleccion = 99);

end.
