program P1E5;
{------------------------------------------------------------------------}
Type
  articulo = record
    nombre: string;
    descripcion: string;
    precio: real;
    stock: integer;
    end;

  archivo_texto = text;
  archivo_binario = file of articulo;
{------------------------------------------------------------------------}
procedure leerArticulo(var r: articulo);
begin
  with r do begin
    write('Ingresar nombre del producto: ');
    readln(nombre);
    write('Ingresar descripcion del producto: ');
    readln(descripcion);
    write('Ingresar precio del producto: ');
    readln(precio);
    write('Ingresar stock del producto: ');
    readln(stock);
    end;
end;
{------------------------------------------------------------------------}
var
  opc: char; texto: archivo_texto; articulos: archivo_binario; nombre_archivo, art: String; r: articulo;  cant, pos, i: integer; ok: boolean;
{------------------------------------------------------------------------}
begin
  writeln('Ingrese la opcion deseada:');
  writeln('A- Crear archivo desde "zapatos.txt"');
  writeln('B- Listar articulos con stock menor a 100');
  writeln('C- Listar articulos con descripcion');
  writeln('D- Exportar archivo creado a "zapateria.txt');
  writeln('E- Agregar articulos');
  writeln('F- Modificar el stock de un articulo');
  writeln('G- Exportar los productos sin stock a "SinStock.txt"');
  readln(opc);
  writeln;
  {------------------------------------------------------------------------}
  if ((opc ='a') or (opc ='A')) then begin
    assign(texto, 'zapatos.txt');
    reset(texto);
    write('Ingrese nombre para el archivo a crear: ');
    readln (nombre_archivo);
    assign(articulos, nombre_archivo);
    rewrite(articulos);
    while (not EOF(texto)) do begin
      readln(texto, r.precio, r.nombre);
      readln(texto, r.stock, r.descripcion);
      write(articulos, r);
    end;
    close(texto);
    end;
  {------------------------------------------------------------------------}
  if ((opc ='b') or (opc ='B')) then begin
    write('Ingrese el nombre del archivo que va a utilizar: ');
    readln (nombre_archivo);
    assign(articulos, nombre_archivo);
    reset(articulos);
    while (not EOF(articulos)) do begin
      read(articulos, r);
      if (r.stock < 100) then
        writeln(r.nombre);
      end;
    end;
  {------------------------------------------------------------------------}
  if ((opc ='c') or (opc ='C')) then begin
    write('Ingrese el nombre del archivo que va a utilizar: ');
    readln (nombre_archivo);
    assign(articulos, nombre_archivo);
    reset(articulos);
    while (not EOF(articulos)) do begin
      read(articulos, r);
      if (r.descripcion <> '') then
        writeln(r.nombre);
      end;
    end;
  {------------------------------------------------------------------------}
  if ((opc ='d') or (opc ='D')) then begin
    write('Ingrese el nombre del archivo que desea exportar: ');
    readln (nombre_archivo);
    assign(articulos, nombre_archivo);
    reset(articulos);
    assign(texto, 'zapateria.txt');
    rewrite(texto);
    while (not EOF(articulos)) do begin
      read(articulos, r);
      writeln(texto, r.nombre);
      writeln(texto, r.precio:0:2);
      writeln(texto, r.descripcion);
      writeln(texto, r.stock);
      writeln;
      end;
    close(texto);
    end;
  {------------------------------------------------------------------------}
  if ((opc ='e') or (opc ='E')) then begin
    write('Ingrese el nombre del archivo al que le desea agregar articulos: ');
    readln (nombre_archivo);
    assign(articulos, nombre_archivo);
    reset(articulos);
    pos:= fileSize(articulos);
    seek(articulos, pos);
    write('Ingrese la cantidad de articulos que quiere agregar: ');
    readln(cant);
    for i:= 0 to (cant - 1) do begin
      leerArticulo(r);
      write(articulos, r);
      end;
    end;
  {------------------------------------------------------------------------}
  if ((opc ='f') or (opc ='F')) then begin
    ok:= false;
    write('Ingrese el nombre del archivo que desea modificar: ');
    readln (nombre_archivo);
    assign(articulos, nombre_archivo);
    reset(articulos);
    write('Ingrese el nombre del articulo que desea modificar: ');
    readln(art);
    while ((ok = false) and (not EOF(articulos))) do begin
      read(articulos, r);
      if (r.nombre = art) then begin
        write('Ingrese el nuevo stock: ');
        readln(cant);
        r.stock:= cant;
        pos:= filePos(articulos) - 1;
        seek(articulos, pos);
        write(articulos, r);
        ok:= true;
        end;
      end;
      if (ok = false) then
        write('No se encontro el articulo');
    end;
  {------------------------------------------------------------------------}
   if ((opc ='g') or (opc ='g')) then begin
     write('Ingrese el nombre del archivo que desea modificar: ');
     readln (nombre_archivo);
     assign(articulos, nombre_archivo);
     reset(articulos);
     assign(texto, 'SinStock.txt');
     rewrite(texto);
     while (not EOF(articulos)) do begin
       read(articulos, r);
       if (r.stock = 0) then begin
         writeln(texto, r.nombre);
         writeln(texto, r.precio:0:2);
         writeln(texto, r.descripcion);
         writeln(texto, r.stock);
         writeln;
         end;
       end;
     close(texto);
     end;
  {------------------------------------------------------------------------}
  close(articulos);
  readln;
end.

