program x;
const
  valorImposible= 'zzzzzz';
Type

  fechaF = record
    dia: integer;
    mes: integer;
    ano: integer;
    end;

  horaH = record
    hora: integer;
    minuto: integer;

  vuelo = record
    destino: String;
    fecha: fechaF;
    hora: horaH;
    cantDisponibles: integer;
    end;

  venta = record
    destino: String;
    fecha: fechaF;
    hora: horaH;
    cantComprados: integer;
    end;

  arch_mae = file of vuelo;
  arch_det = file of venta;

{---------------------------------------------------------------------------------}
procedure leerMaestro(var mae: arch_mae; var rm: vuelo);
begin
  if(not EOF(mae)) then
    read(mae, rm)
  else
    rm.destino:= valorImposible;
end;
{---------------------------------------------------------------------------------}
procedure leerDetalle(var det: arch_det; var rd: venta);
begin
  if(not EOF(det)) then
    read(det, rd)
  else
    rd.destino:= valorImposible;
end;
{---------------------------------------------------------------------------------}
procedure minimo(var det1, det2: arch_det; var rd, d1, d2: venta;); lo va a hacer ella
{---------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------}
var
  cantUsuario, minimoDisponible: integer; mae: arch_mae; det1, det2: arch_det; rm: usuario; rd: envio; nomb: String;
begin
  write('Ingrese el valor desde el cual se debe informar si los vuelos poseen menor asientos disponibles: ');
  readln(minimoDisponible);
  lis:= nil;
  assign(mae, 'logmail.dat');
  reset(mae);
  write('Ingrese el nombre del primer archivo detalle con el que se desea actualizar el maestro: ');
  readln(nomb);
  assign(det1, nomb);
  reset(det1);
  write('Ingrese el nombre del segundo archivo detalle con el que se desea actualizar el maestro: ');
  readln(nomb);
  assign(det2, nomb);
  reset(det2);
  leerMaestro(mae, rm);
  leerDetalle(det1, d1);
  leerDetalle(det2, d2);
  minimo(d1, d2, det1, det2, rd);
  while(rm.destino <> valorImposible) do begin
    if (rm.destino = rd.destino) and (rm.fecha = rd.fecha) and (rm.hora = rd.hora) then begin
      cantVendidos:= 0;
      while (rm.destino = rd.destino) and (rm.fecha = rd.fecha) and (rm.hora = rd.hora) do begin
        cantVendidos := cantVendidos + rd.cantComprados;
        minimo(d1, d2, det1, det2, rd);
        end;
      rm.cantDisponibles:= rm.cantDisponibles - cantVendidos;
      seek(mae, filePos(mae) - 1);
      write(mae, rm);
      end;
    if(rm.cantDisponibles < minimoDisponible) then
      agregarALaLista(rm, lis);
    leerMaestro(mae, rm);
    end;
  close(det1);
  close(det2);
  close(mae);
end.



