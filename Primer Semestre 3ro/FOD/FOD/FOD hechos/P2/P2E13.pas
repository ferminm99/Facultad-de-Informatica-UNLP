program x;
const
  cantSucursales = 2;
  valorImposible= 99999999;
Type

   inscripto = record
     dni: integer;
     codCarrera: integer;
     montoPagado: real;
     end;

  informe = record
    dni: integer;
    codCarrera: integer;
    monto: real;
    end;

  arch_mae = file of inscripto;
  arch_det = file of informe;
  arch_tex = text;

  informes = array [1..cantSucursales] of informe;

{---------------------------------------------------------------------------------}
procedure leerMaestro(var mae: arch_mae; var rm: inscripto);
begin
  if(not EOF(mae)) then
    read(mae, rm)
  else
    rm.dni:= valorImposible;
end;
{---------------------------------------------------------------------------------}
procedure leerDetalle(var det: arch_det; var rd: informe);
begin
  if(not EOF(det)) then
    read(det, rd)
  else begin
    rd.dni:= valorImposible;
    rd.codCarrera:= valorImposible;
    end;
end;
{---------------------------------------------------------------------------------}
procedure cargarVector(var v: informes; var det1, det2: arch_det);
var
  rd: informe;
begin
  leerDetalle(det1, rd);
  v[1]:= rd;
  leerDetalle(det2, rd);
  v[2]:= rd;
end;
{---------------------------------------------------------------------------------}
procedure minimo(var v: informes; var rd: informe; var det1, det2: arch_det);
var
  i, sucursal, dniMax, carreraMax: integer;
begin
  sucursal:= 1;
  dniMax:= valorImposible;
  carreraMax:= valorImposible;
  for i:= 1 to cantSucursales do begin
    if(v[i].dni < dniMax) then begin
      dniMax:= v[i].dni;
      carreraMax:= v[i].codCarrera;
      sucursal:= i;
      end
    else
      if(v[i].dni = dniMax) then begin
        if(v[i].codCarrera < carreraMax) then begin
          carreraMax:= v[i].codCarrera;
          sucursal:= i;
          end;
        end;
    end;
  rd:= v[sucursal];
  case i of
    1: begin
      leerDetalle(det1, v[sucursal]);
    end;
    2: begin
      leerDetalle(det2, v[sucursal]);
    end;
    end;
end;
{---------------------------------------------------------------------------------}
procedure actualizarMaestro (var mae: arch_mae; var det1, det2: arch_det);
var
  v: informes; rm: inscripto; rd: informe; dniActual, carreraActual: integer; montoTotal: real;
begin
  cargarVector(v, det1, det2);
  leerMaestro(mae, rm);
  minimo(v, rd, det1, det2);
  while(rd.dni <> valorImposible) do begin
    while(rm.dni <> rd.dni) do
      leerMaestro(mae, rm);
    dniActual:= rd.dni;
    while(rd.dni = dniActual) and (rd.dni <> valorImposible) do begin
      montoTotal:= 0;
      carreraActual:= rd.codCarrera;
      while(rd.codCarrera = carreraActual) and (rd.dni = dniActual) and (rd.dni <> valorImposible) do begin
        montoTotal:= montoTotal + rd.monto;
        minimo(v, rd, det1, det2);
        end;
      rm.montoPagado:= rm.montoPagado + montoTotal;
      seek(mae, filePos(mae) - 1);
      write(mae, rm);
      end;
    end;
end;
{---------------------------------------------------------------------------------}
procedure cargarMorosos(var mae: arch_mae);
var
  tex: arch_tex; rm: inscripto; nomb: String;
begin
  reset(mae);
  write('Ingrese el nombre del archivo de texto en donde informar: ');
  readln(nomb);
  assign(tex, nomb);
  rewrite(tex);
  leerMaestro(mae, rm);
  while(rm.dni <> valorImposible) do begin
    if (rm.montoPagado = 0) then
      write(tex, rm.dni, rm.codCarrera, 'alumno moroso');
    end;
  close(tex);
end;
{---------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------}
var
 mae: arch_mae; det1, det2: arch_det; nomb: String;
begin
  write('Ingrese el nombre del archivo maestro: ');
  readln(nomb);
  assign(mae, nomb);
  reset(mae);
  write('Ingrese el nombre del archivo detalle: ');
  readln(nomb);
  assign(det1, nomb);
  reset(det1);
  write('Ingrese el nombre del archivo detalle: ');
  readln(nomb);
  assign(det2, nomb);
  reset(det2);
  actualizarMaestro(mae, det1, det2);
  cargarMorosos(mae);
  close(mae);
  close(det1);
  close(det2);
end.
