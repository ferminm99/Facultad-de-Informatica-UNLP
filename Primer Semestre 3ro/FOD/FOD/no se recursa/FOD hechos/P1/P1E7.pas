program P1E5;
{------------------------------------------------------------------------}
Type
  novela = record
    codigo: integer;
    nombre: string;
    genero: string;
    precio: real;
    end;

  archivo_texto = text;
  archivo_binario = file of novela;
{------------------------------------------------------------------------}
procedure leerNovela(var r: novela);
begin
  with r do begin
    write('Ingresar codigo del producto: ');
    readln(codigo);
    write('Ingresar nombre del producto: ');
    readln(nombre);
    write('Ingresar genero del producto: ');
    readln(genero);
    write('Ingresar precio del producto: ');
    readln(precio);
    end;
end;
{------------------------------------------------------------------------}
var
  opc: char; texto: archivo_texto; novelas: archivo_binario; nombre_archivo: String; r: novela; pos, cod_novela: integer; ok: boolean;
{------------------------------------------------------------------------}
begin
  writeln('Ingrese la opcion deseada:');
  writeln('A- Crear archivo desde "novelas.txt"');
  writeln('B- Agregar novela');
  writeln('C- Modificar novela');
  writeln('D- Imprimir lista en pantalla');
  readln(opc);
  writeln;
  {------------------------------------------------------------------------}
  if ((opc ='a') or (opc ='A')) then begin
    assign(texto, 'novelas.txt');
    reset(texto);
    write('Ingrese nombre para el archivo a crear: ');
    readln (nombre_archivo);
    assign(novelas, nombre_archivo);
    rewrite(novelas);
    while (not EOF(texto)) do begin
      readln(texto, r.codigo, r.precio, r.genero);
      readln(texto, r.nombre);
      write(novelas, r);
      end;
    close(texto);
    end;
  {------------------------------------------------------------------------}
  if ((opc ='b') or (opc ='B')) then begin
    write('Ingrese el nombre del archivo al que le desea agregar la novela: ');
    readln (nombre_archivo);
    assign(novelas, nombre_archivo);
    reset(novelas);
    pos:= fileSize(novelas);
    seek(novelas, pos);
    leerNovela(r);
    write(novelas, r);
    end;
  {------------------------------------------------------------------------}
  if ((opc ='c') or (opc ='C')) then begin
    ok:= false;
    write('Ingrese el nombre del archivo que desea modificar: ');
    readln (nombre_archivo);
    assign(novelas, nombre_archivo);
    reset(novelas);
    write('Ingrese el codigo de la novela que desea modificar: ');
    readln(cod_novela);
    while ((ok = false) and (not EOF(novelas))) do begin
      read(novelas, r);
      if (r.codigo = cod_novela) then begin
        writeln('Ingrese los nuevos datos de la novela');
        write('Nuevo codigo: ');
        readln(r.codigo);
        write('Nuevo precio: ');
        readln(r.precio);
        write('Nuevo nombre: ');
        readln(r.nombre);
        write('Nuevo genero: ');
        readln(r.genero);
        pos:= filePos(novelas) - 1;
        seek(novelas, pos);
        write(novelas, r);
        ok:= true;
        end;
      end;
      if (ok = false) then
        write('No se encontro el articulo');
    end;
  {------------------------------------------------------------------------}
  if ((opc ='d') or (opc ='D')) then begin
    write('Ingrese el nombre del archivo a imprimir: ');
    readln (nombre_archivo);
    assign(novelas, nombre_archivo);
    reset(novelas);
    while (not EOF(novelas)) do begin
      read(novelas, r);
      writeln(r.nombre);
      writeln(r.genero);
      writeln(r.precio:0:2);
      writeln(r.codigo);
      writeln;
      end;
    end;
  {------------------------------------------------------------------------}
  close(novelas);
  readln;
end.

