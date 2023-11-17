program P2E3;
const
  valorImposible = 999999;
Type
  producto = record
    cod: integer;
    nombre: String;
    precio: real;
    SA: integer;
    SM: integer;
    end;

  venta = record
    cod: integer;
    cant: integer;
    end;

  arch_mae = file of producto;
  arch_det = file of venta;
  arch_tex = text;

{------------------------------------------------------------------------------------}
procedure leerMaestro (var mae: arch_mae; var r_maestro: producto);
begin
  if (not EOF(mae)) then
    read(mae, r_maestro)
  else
    r_maestro.cod:= valorImposible;
end;

procedure leerDetalle (var det: arch_det; var r_detalle: venta);
begin
  if (not EOF(det)) then
    read(det, r_detalle)
  else
    r_detalle.cod:= valorImposible;
end;
{------------------------------------------------------------------------------------}

{------------------------------------------------------------------------------------}
var
  opc: char; id: String; mae: arch_mae; det: arch_det; tex: arch_tex; rm: producto; rd: venta; codActual: integer; totalCant: integer;
begin
  writeln('Elige una opcion:');
  writeln('a. Crear el archivo maestro a partir de un archivo de texto llamado “productos.txt”.');
  writeln('b. Listar el contenido del archivo maestro en un archivo de texto llamado “reporte.txt”, listando de a un producto por línea.');
  writeln('c. Crear un archivo detalle de ventas a partir de en un archivo de texto llamado “ventas.txt”.');
  writeln('d. Listar en pantalla el contenido del archivo detalle de ventas.');
  writeln('e. Actualizar el archivo maestro con el archivo detalle.');
  writeln('f. Listar en un archivo de texto llamado “stock_minimo.txt” aquellos productos cuyo stock actual esté por debajo del stock mínimo permitido.');
  readln(opc);
  case opc of
  'a': begin
    write('Ingrese el nombre del archivo maestro a crear: ');
    readln(id);
    assign(mae, id);
    rewrite(mae);
    assign(tex, 'productos.txt');
    reset(tex);
    while(not EOF(tex)) do begin
      readln(tex, rm.cod);
      readln(tex, rm.nombre);
      readln(tex, rm.precio);
      readln(tex, rm.SA);
      readln(tex, rm.SM);
      write(mae, rm);
      end;
    close(mae);
    close(tex);
  end;
  'b': begin
    write('Ingrese el nombre del archivo maestro a imprimir: ');
    readln(id);
    assign(mae, id);
    reset(mae);
    assign(tex, 'reporte.txt');
    rewrite(tex);
    while(not EOF(mae)) do begin
      read(mae, rm);
      write(tex, 'Codigo: ');
      write(tex, rm.cod);
      write(tex, ' Nombre: ');
      write(tex, rm.nombre);
      write(tex, ' precio: ');
      write(tex, rm.precio:0:2);
      write(tex, ' Stock Actual: ');
      write(tex, rm.SA);
      write(tex, ' Stock Minimo: ');
      writeln(tex, rm.SM);
      end;
    close(mae);
    close(tex);
  end;
  'c': begin
    write('Ingrese el nombre del archivo detalle a crear: ');
    readln(id);
    assign(det, id);
    rewrite(det);
    assign(tex, 'ventas.txt');
    reset(tex);
    while(not EOF(tex)) do begin
      readln(tex, rd.cod);
      readln(tex, rd.cant);
      write(det, rd);
      end;
    close(det);
    close(tex);
  end;
  'd': begin
    write('Ingrese el nombre del archivo detalle a imprimir: ');
    readln(id);
    assign(det, id);
    reset(det);
    while(not EOF(det)) do begin
      read(det, rd);
      write('Codigo del producto: ');
      writeln(rd.cod);
      write('Cantidad del producto: ');
      writeln(rd.cant);
      end;
    close(det);
  end;
  'e': begin
    write('Ingrese el nombre del archivo maestro a actualizar: ');
    readln(id);
    assign(mae, id);
    reset(mae);
    write('Ingrese el nombre del archivo detalle con el que se desea actualizar al maestro: ');
    readln(id);
    assign(det, id);
    reset(det);
    leerMaestro(mae, rm);
    leerDetalle(det, rd);
    while(rd.cod <> valorImposible) do begin
      codActual:= rd.cod;
      totalCant:= 0;
      while (rm.cod <> codActual) do
        leerMaestro(mae, rm);
      while(rd.cod = codActual) do begin
        totalCant:= totalCant + rd.cant;
        leerDetalle(det, rd);
        end;
      rm.SA:= rm.SA - totalCant;
      seek(mae, filePos(mae) - 1);
      write(mae, rm);
      end;
  end;
  'f': begin
    write('Ingrese el nombre del archivo maestro a imprimir en stock_minimo.txt: ');
    readln(id);
    assign(mae, id);
    reset(mae);
    assign(tex, 'stock_minimo.txt');
    rewrite(tex);
    writeln(tex, 'Productos con stock menor al minimo: ');
    while(not EOF(mae)) do begin
      read(mae, rm);
      if (rm.SA < rm.SM) then begin
        write(tex, 'Codigo: ');
        write(tex, rm.cod);
        write(tex, ' Nombre: ');
        write(tex, rm.nombre);
        write(tex, ' precio: ');
        write(tex, rm.precio:0:2);
        write(tex, ' Stock Actual: ');
        write(tex, rm.SA);
        write(tex, ' Stock Minimo: ');
        writeln(tex, rm.SM);
        end;
      end;
    close(mae);
    close(tex);
  end;
  end;
  readln;
end.

