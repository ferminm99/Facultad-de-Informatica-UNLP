program ejercicio5;
const
     valorImposible = 999999;
type
    producto = record
             codigo: integer;
             nombre: string;
             precio: real;
             stockA: integer;
             stockM: integer;
    end;
    venta = record
          codigo: integer;
          unidades: integer;
    end;
    archivo_maestro = file of producto;
    archivo_detalles = file of venta;
    texto = text;
procedure leerMaestro (var arch: archivo_maestro; var reg: producto);
begin
     if (not eof(arch)) then
        read(arch,reg);
     else
         reg.codigo:= valorImposible;
end;
procedure leerDetalles (var arc: archivo_detalles; var reg: venta);
begin
     if (not eof(arc)) then
        read (arc,reg);
     else
         reg.codigo:= valorImposible;
end;
procedure crearMaestro (var mae: archivo_maestro);
var
   tex: texto;
   nombre: string;
   reg: producto;
begin
     writeln('Ingrese el nombre del archivo maestro a crear: ');
     readln(nombre);
     assign(mae,nombre);
     rewrite(mae);
     assign(tex,'productos.txt');
     reset(tex);
     while (not eof(tex)) do begin
           readln(tex,reg.codigo,reg.nombre,reg.precio,reg.stockA,reg.stockM);
           write(mae,reg);
     end;
     close(tex);
     close(mae);
end;
procedure listarMaestro (mae: archivo_maestro);
var
   tex: texto;
   nombre: string;
   reg: producto;
begin
     writeln('Ingrese el nombre del archivo maestro a imprimir: ');
     readln(nombre);
     assign(mae,nombre);
     reset(mae);
     assign(tex,'reporte.txt');
     rewrite(tex);
     while (not eof(mae)) do begin
           read(mae,reg);
           writeln(tex,reg.codigo,' ',reg.precio,' ',reg.stockA,' ',reg.stockM,' ',reg.nombre););
     end;
     close(tex);
     close(mae);
end;
procedure crearDetalles (var d: archivo_detalles);
var
   tex: texto;
   nombre: string;
   reg: producto;
begin
     writeln('Ingrese el nombre del archivo detalles a crear: ');
     readln(nombre);
     assign(d,nombre);
     rewrite(d);
     assign(tex,'ventas.txt');
     reset(tex);
     while (not eof(tex)) do begin
           readln(tex,reg.codigo, reg.unidades);
           write(d,reg);
     end;
     close(tex);
     close(d);
end;
procedure listarDetalles (d: archivo_detalles);
var
   nombre: string;
begin
     writeln('Ingrese el nombre del archivo detalle a imprimir: ');
     readln(nombre);
     assign(mae,nombre);
     reset(d);
     while (not eof(d)) do begin
           read(d,reg);
           writeln('Codigo: ',reg.codigo,' Unidades: ', reg.unidades);
     end;
     close(d);
end;
procedure actualizar (var mae: archivo_maestro;d: archivo_detalles);
var
   tex: texto;
   nombre: string;
   rg,rm: producto;
   codActual, total: integer;
begin
     writeln('Ingrese el nombre del archivo maestro a actualizar: ');
     readln(nombre);
     assign(mae,nombre);
     reset(mae);
     writeln('Ingrese el nombre del archivo detalle a usar para la actualizacion del maestro: ');
     readln(nombre);
     assign(det,nombre);
     reset(det);
     leerDetalles(det,rd);
     while (rd.codigo <> valorImposible) do begin
           codActual:= rd.codigo;
           totalCant:= 0;
           while (rd.cod = codActual) do begin
                 totalCant:= totalCant + rd.cant;
                 leerDetalle(det,rd);
           end;
           leerMaestro(mae,rm);
           while (rm.codigo <> codActual) do begin
                 leerMaestro(mae,rm);
           end;
           rm.stockA:= rm.stockA - totalCant;
           seek(mae, filePos(mae) - 1);
           write(mae,rm);
     end;
     close(mae);
     close(det);
end;
procedure listarStock (mae: archivo_maestro);
var
   tex: texto;
   nombre: string;
   rm: producto;
begin
     write('Ingrese el nombre del archivo maestro a imprimir en stock_minimo.txt: ');
     readln(nombre);
     assign(mae, nombre);
     reset(mae);
     assign(tex, 'stock_minimo.txt');
     rewrite(tex);
     writeln(tex, 'Productos con stock menor al minimo: ');
     while (not EOF(mae)) do begin
           read(mae, rm);
           if (rm.SA < rm.SM) then begin
              write(tex, 'Codigo: ',rm.codigo);
              write(tex, ' Nombre: ',rm.nombre);
              write(tex, ' precio: ',rm.precio);
              write(tex, ' Stock Actual: ',rm.stockA);
              write(tex, ' Stock Minimo: ',rm.stockM);
           end;
     end;
     close(mae);
     close(tex);
end;
var
   opc: string;
   mae: archivo_maestro;
   det: archivo_detalles;
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
     'a': crearMaestro(mae);
     'b': listarMaestro(mae);
     'c': crearDetalles(det);
     'd': listarDetalles(det);
     'e': actualizar(mae,det);
     'f': listarStock(mae);
     end;
     readln;
end;





