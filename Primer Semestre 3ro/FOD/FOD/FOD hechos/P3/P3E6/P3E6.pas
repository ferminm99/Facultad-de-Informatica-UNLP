program a;
const
  valorImposible = 999999;
Type

  prenda = record
    cod: integer;
    desc: String;
    colores: String;
    tipo: String;
    stock: integer;
    precio: real;
    enlace: integer;
    end;

  arch_mae = file of prenda;
  arch_det = file of integer;
  arch_tex = text;

{--------------------------------------------------------------------------}
procedure leerRegistro(var r: prenda);
begin
  writeln('Ingrese el codigo de la prenda');
  readln(r.cod);
  if (r.cod <> valorImposible) then begin
    writeln('Ingrese la descripcion');
    readln(r.desc);
    writeln('Ingrese el color');
    readln(r.colores);
    writeln('Ingrese el tipo');
    readln(r.tipo);
    writeln('Ingrese el stock');
    readln(r.stock);
    writeln('Ingrese precio');
    readln(r.precio);
    end;
end;
{--------------------------------------------------------------------------}
procedure leerMaestro(var mae: arch_mae; var r: prenda);
begin
  if(not EOF(mae))then
    read(mae, r)
  else
    r.cod:= valorImposible;
end;

procedure leerDetalle(var det: arch_det; var r: integer);
begin
  if(not EOF(det))then
    read(det, r)
  else
    r:= valorImposible;
end;
{--------------------------------------------------------------------------}
procedure bajaConDetalle(var mae: arch_mae; var det: arch_det);
var
  r_mae, cabecera: prenda; r_det: integer;
begin
  leerMaestro(mae, cabecera);
  leerMaestro(mae, r_mae);
  leerDetalle(det, r_det);
  while(r_det <> valorImposible) do begin
    while(r_mae.cod <> r_det) do
      leerMaestro(mae, r_mae);
    if (r_mae.stock > 0) then
      r_mae.stock:= r_mae.stock * -1;
    r_mae.enlace := cabecera.cod;
    cabecera.cod:= filePos(mae) - 1;
    seek(mae, 0);
    write(mae, cabecera);
    seek(mae, cabecera.cod);
    write(mae, r_mae);
    leerDetalle(det, r_det);
    end;
  reset(mae);
  leerMaestro(mae, r_mae);
end;

{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}

var
  opc: char; nomb: String; mae: arch_mae; r, r_mae, cabecera: prenda; det: arch_det; tex: arch_tex; prendaCod: integer;
begin
  writeln('Ingrese una opción');
  writeln('A- Crear archivo de prendas');
  writeln('B- Modificar el archivo y con una lista de prendas a borrar');
  writeln('C- Imprimir el archivo de prendas en "prendas.txt"');
  readln(opc);
  case opc of
    'A', 'a': begin
      write('Ingrese el nombre del archivo a crear: ');
      readln(nomb);
      assign(mae, nomb);
      rewrite(mae);
      r.cod:= 0;
      write(mae, r);
      leerRegistro(r);
      while(r.cod <> valorImposible) do begin
        write(mae, r);
        writeln('Prenda cargada!');
        writeln();
        leerRegistro(r);
        end;
      writeln('Carga de prendas finalizada!');
      close(mae);
      end;
    'B', 'b': begin
      write('Ingrese el nombre del archivo maestro a borrar: ');
      readln(nomb);
      assign(mae, nomb);
      reset(mae);
      write('Ingrese el nombre del archivo detalle con las prendas a borrar: ');
      readln(nomb);
      assign(det, nomb);
      reset(det);
      bajaConDetalle(mae, det);
      close(mae);
      close(det);
      end;
    'C', 'c': begin
      write('Ingrese el nombre del archivo a imprimir: ');
      readln(nomb);
      assign(mae, nomb);
      reset(mae);
      assign(tex, 'prendas.txt');
      rewrite(tex);
      leerMaestro(mae, cabecera);
      leerMaestro(mae, r_mae);
      while(r_mae.cod <> valorImposible) do begin
        writeln(tex, r_mae.cod, ' --> codigo');
        writeln(tex, r_mae.stock, ' --> stock');
        writeln(tex, r_mae.enlace, ' --> enlace');
        leerMaestro(mae, r_mae);
        end;
      writeln('Ingrese archivo imprimido correctamente!');
      close(tex);
      close(mae);
      end;
    'D', 'd': begin
      write('Ingrese el nombre del detalle a crear: ');
      readln(nomb);
      assign(det, nomb);
      rewrite(det);
      write('Ingrese codigo de la prenda a borrar: ');
      readln(prendaCod);
      while(prendaCod <> valorImposible) do begin
        write(det, prendaCod);
        write('Ingrese codigo de la prenda a borrar: ');
        readln(prendaCod);
        end;
      close(det);
      end;
    end;
  readln;
end.
