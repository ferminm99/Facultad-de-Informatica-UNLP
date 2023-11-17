

//EL PROGRAMA ESTÁ MAL, HAY QUE RECORRER EL MAESTRO Y PREGUNTAR SI COINCIDE CON EL MINIMO PARA ACTUALIZARLO, Y PARA CADA MAESTRO (ACTUALIZADO O NO) CALCULAR EL
// MAX Y MIN

program x;
uses Sysutils;
const
  cantDetalles = 100;
  valorImposible= 99999999;
  anioActual = 2019;

Type

  fechaF = record
    anio: integer;
    mes: integer;
    dia: integer;
    end;

  semanario = record
    fecha: fechaF;
    cod: integer;
    nombre: String;
    desc: String;
    precio: real;
    stock: integer;
    vendidos: integer;
    end;

  venta = record
    fecha: fechaF;
    cod: integer;
    vendidos: integer;
    end;

  arch_mae = file of semanario;
  arch_det = file of venta;

  detalles = array [1..cantDetalles] of arch_det;
  ventas = array [1..cantDetalles] of venta;

{---------------------------------------------------------------------------------}
procedure leerMaestro(var mae: arch_mae; var rm: semanario);
begin
  if(not EOF(mae)) then
    read(mae, rm)
  else begin
    rm.cod:= valorImposible;
    rm.fecha.anio:= anioActual + 1;
    end;
end;
{---------------------------------------------------------------------------------}
procedure leerDetalle(var det: arch_det; var rd: venta);
begin
  if(not EOF(det)) then
    read(det, rd)
  else begin
    rd.cod:= valorImposible;
    rd.fecha.anio:= anioActual + 1;
    end;
end;
{---------------------------------------------------------------------------------}
procedure leerYabrirDetalles(var v : detalles);
var
  i: integer;
begin
  for i:= 1 to cantDetalles do begin
    assign(v[i],'det'+IntToStr(i)+'.dat');
    reset(v[i]);
    end;
end;
{---------------------------------------------------------------------------------}
procedure cargarElementos(var v: ventas; var vec_detalles: detalles);
var
  i: integer; rd: venta;
begin
  for i:= 1 to cantDetalles do begin
    leerDetalle(vec_detalles[i], rd);
    v[i]:= rd;
    end;
end;
{---------------------------------------------------------------------------------}
function fechaMenor (fecha1: fechaF; fecha2: fechaF): boolean;
var
  ok: boolean;
begin
  ok:= false;
  if (fecha1.anio < fecha2.anio) then
    ok:= true
  else
    if((fecha1.anio = fecha2.anio) and (fecha1.mes < fecha2.mes)) then
      ok:= true
    else
      if ((fecha1.anio = fecha2.anio) and (fecha1.mes = fecha2.mes) and (fecha1.dia < fecha2.dia)) then
        ok:= true;
  fechaMenor:=  ok;
end;
{---------------------------------------------------------------------------------}
function fechaIgual (fecha1: fechaF; fecha2: fechaF): boolean;
begin
  if ((fecha1.anio = fecha2.anio) and (fecha1.mes = fecha2.mes) and (fecha1.dia = fecha2.dia)) then
    fechaIgual:= true
  else
    fechaIgual:= false;
end;
{---------------------------------------------------------------------------------}
procedure leerMinimo(var vec_detalles: detalles; var v: ventas; var rd: venta);
var
  Ndetalle, i, codMin: integer; fechaMin: fechaF;
begin
  fechaMin.anio:= anioActual + 1;
  fechaMin.mes:= 13;
  fechaMin.dia:= 32;
  codMin:= valorImposible;
  for i:= 1 to cantDetalles do begin
    if (fechaMenor(v[i].fecha, fechaMin)) then begin
      fechaMin:= v[i].fecha;
      codMin:= v[i].cod;
      Ndetalle:= i;
      end
    else if(fechaIgual(v[i].fecha, fechaMin)) then
        if(v[i].cod < codMin) then begin
          codMin:= v[i].cod;
          Ndetalle:= i;
          end;
    end;
  if (fechaMin.anio < anioActual + 1) then begin
    leerDetalle(vec_detalles[Ndetalle], rd);
    v[Ndetalle]:= rd;
    end;
end;
{---------------------------------------------------------------------------------}
procedure actualizarMaestro(var mae: arch_mae; var vec_detalles: detalles; var v:ventas; var mayorFecha, menorFecha: fechaF; var mayorNombre, menorNombre: String);
var
  menorVentas, mayorVentas, codActual, cantVendidos: integer; rm: semanario; rd: venta; fechaActual: fechaF;
begin
  mayorVentas:= -1;
  menorVentas:= 9999999;
  leerMaestro(mae, rm);
  leerMinimo(vec_detalles, v, rd);
  while (rd.cod <> valorImposible) do begin
    codActual:= rd.cod;
    while(rm.cod <> rd.cod)do
      leerMaestro(mae, rm);
    while ((rd.cod = codActual) and (rd.cod <> valorImposible)) do begin
      fechaActual:= rd.fecha;
      cantVendidos:= 0;
      while ((fechaIgual(fechaActual, rd.fecha)) and (rd.cod = codActual) and (rd.cod <> valorImposible)) do begin
        cantVendidos:= cantVendidos + rd.vendidos;
        leerMinimo(vec_detalles, v, rd);
        end;
      rm.stock:= rm.stock - cantVendidos;
      rm.vendidos:= rm.vendidos + cantVendidos;
      seek(mae, filePos(mae) - 1);
      write(mae, rm);
      if (rm.vendidos > mayorVentas) then begin
        mayorVentas:= rm.vendidos;
        mayorNombre:= rm.nombre;
        mayorFecha:= rm.fecha;
        end;
      if(rm.vendidos < menorVentas) then begin
        menorVentas:= rm.vendidos;
        menorNombre:= rm.nombre;
        menorFecha:= rm.fecha;
        end;
      end;
    end;
end;
{---------------------------------------------------------------------------------}
var
  vec_detalles: detalles; v: ventas; mae: arch_mae; nomb, mayorNombre, menorNombre: String; mayorFecha, menorFecha: fechaF;
begin
  write('Ingrese el nombre del archivo maestro: ');
  readln(nomb);
  assign(mae, nomb);
  reset(mae);
  leerYabrirDetalles(vec_detalles);
  cargarElementos(v, vec_detalles);
  actualizarMaestro(mae, vec_detalles, v, mayorFecha, menorFecha, mayorNombre, menorNombre);
  writeln('El seminario ', mayorNombre, ' del dia ', mayorFecha.dia, '/', mayorFecha.mes, '/', mayorFecha.anio, ' fue el mas vendido');
  writeln('El seminario ', menorNombre, ' del dia ', menorFecha.dia, '/', menorFecha.mes, '/', menorFecha.anio, ' fue el menos vendido');
end.
