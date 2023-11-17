program x;
uses Sysutils;
const
  cantArchivos = 3;
Type

  producto = record
    cod: integer;
    desc: string;
    SA: integer;
    SM: integer;
    precio: real;
    end;

  venta = record
    num: integer;
    cod: integer;
    cant: integer;
    end;

  arch_mae = file of producto;
  arch_det = file of venta;

  Vec_detalles = array [1..cantArchivos] of arch_det;
  Vec_ventas = array [1..cantArchivos] of venta;

{--------------------------------------------------------}
procedure leerDetalle(var r: venta; var det: arch_det);
begin
  if(not EOF(det)) then
    read(det, r)
  else
    r.cod:= -1;
end;
{--------------------------------------------------------}
procedure leerMaestro(var r: producto; var mae: arch_mae);
begin
  if(not EOF(mae)) then
    read(mae, r)
  else
    r.cod:= -1;
end;
{--------------------------------------------------------}
procedure minimo (var V_ven: Vec_ventas; var V_det: Vec_detalles; var r: venta);
var
  i, pos: integer;
begin
  r.cod:= 999999;
  for i:= 1 to cantArchivos do
    if ((V_ven[i].cod <> -1) and (V_ven[i].cod < r.cod)) then begin
      r:= V_ven[i];
      pos:= i;
    end;

  if (r.cod = 999999) then
    r.cod:= -1
  else
    leerDetalle(V_ven[pos], V_det[pos]);
end;
{--------------------------------------------------------}
{--------------------------------------------------------}
{--------------------------------------------------------}
{--------------------------------------------------------}
{--------------------------------------------------------}

var
  V_det: Vec_detalles; V_ven: Vec_ventas; i: integer; mae: arch_mae; r_mae: producto; r_det: venta; totalVendido: real; cantVendidos: integer; nomb: string;
begin
  writeln('Ingrese el nombre del archivo a leer: ');
  readln(nomb);
  assign(mae, nomb);
  reset(mae);

  for i:= 1 to cantArchivos do begin
    assign (V_det[i], 'det' + IntToStr(i));
    reset (V_det[i]);
    end;

  for i:= 1 to cantArchivos do
    leerDetalle(V_ven[i], V_det[i]);

  leerMaestro(r_mae, mae);
  totalVendido:= 0;
  minimo(V_ven, V_det, r_det);
  //borrar
  writeln;
  writeln('Minimo.cod = ', r_det.cod);
  writeln('Minimo.cant = ', r_det.cant);
  //fin borrar

  while(r_mae.cod <> -1) do begin

    write('Producto: ');
    writeln(r_mae.cod);
    writeln(r_mae.desc);
    writeln;

    cantVendidos:= 0;
    while(r_det.cod = r_mae.cod) do begin
      cantVendidos:= cantVendidos + r_det.cant;
      r_mae.SA:= r_mae.SA - r_det.cant;
      minimo(V_ven, V_det, r_det);
      //borrar
      writeln;
      writeln('Minimo.cod = ', r_det.cod);
      writeln('Minimo.cant = ', r_det.cant);
      //fin borrar
    end;

    totalVendido:= totalVendido + cantVendidos*r_mae.precio;

    if (r_mae.SA > 0) then begin
      writeln('El producto todavía tiene stock para vender.');
      writeln;
    end;

    if (r_mae.SA < r_mae.SM) then begin
      writeln('El producto tiene menos productos del stock mínimo.');
      writeln;
    end;

    leerMaestro(r_mae, mae);

  end;
  writeln('El monto total facturado es: ', totalVendido:0:2);

  close(mae);
  for i:= 1 to cantArchivos do
    close(V_det[i]);

  readln;
end.
