program P2E4;
const
  anoActual = 2019;
  cant_redes = 5;
  valorImposible = 999999;
Type

  fechaF = record
    dia: integer;
    mes: integer;
    ano: integer;
    end;

  sesion = record
    cod: integer;
    fecha: fechaF;
    tiempo: integer;
    end;

  sesiones = array [1..5] of sesion;

  arch_det = file of sesion;

{------------------------------------------------------------------------------}
function fechaMenor(fecha1, fecha2:fechaF):boolean;
var
  ok: boolean;
begin
  ok:= false;
  if(fecha1.ano < fecha2.ano) then
    ok:= true
  else
    if(fecha1.ano > fecha2.ano) then
      ok:= false
    else
      if(fecha1.mes < fecha2.mes) then
        ok:= true
      else
        if(fecha1.mes > fecha2.mes) then
          ok:= false
        else
          if (fecha1.dia < fecha2.dia) then
            ok:= true
          else
            ok:= false;
  fechaMenor:=ok
end;
{------------------------------------------------------------------------------}
procedure leerDetalle (var det: arch_det; var r_detalle: sesion);
begin
  if (not EOF(det)) then
    read(det, r_detalle)
  else begin
    r_detalle.cod:= valorImposible;
    r_detalle.fecha.dia:= 32;
    r_detalle.fecha.mes:= 13;
    r_detalle.fecha.ano:= anoActual + 1;
    r_detalle.tiempo:= -1;
    end;
end;
{------------------------------------------------------------------------------}
procedure usuarioFechaMin (var v: sesiones; var usuario: sesion; var det1, det2, det3, det4, det5: arch_det; codActual: integer; var otroCodigo: integer);
var                                            {recorre los 5 elementos del vector, y busca el de menor fecha siempre y cuando tenga el mismo codigo que el actual}
  fechaMin: fechaF; i, red: integer;
begin

  otroCodigo:= 0;
  fechaMin.ano:= anoActual + 1;
  fechaMin.mes:= 13;
  fechaMin.dia:= 32;
  for i:= 1 to cant_redes do
    if (v[i].cod = codActual) then begin
      if (fechaMenor(v[i].fecha, fechaMin)) then begin
        fechaMin:= v[i].fecha;
        red:= i;
        end;
      end
    else
      otroCodigo:= otroCodigo + 1;
  if (otroCodigo < 5) then begin
    usuario:= v[red];
    case red of
      1: leerDetalle(det1, v[1]);
      2: leerDetalle(det2, v[2]);
      3: leerDetalle(det3, v[3]);
      4: leerDetalle(det4, v[4]);
      5: leerDetalle(det5, v[5]);
      end;
    end
  else
    usuario.cod := valorImposible;
end;
{------------------------------------------------------------------------------}
procedure leerCodMinimo (var v: sesiones; var usuario: sesion);
var
  i, red: integer; valMin: integer;
begin
  red:= 1;
  valMin:= valorImposible;
  for i:= 1 to cant_redes do
    if (v[i].cod < valMin) then begin
      valMin:= v[i].cod;
      red:= i;
      end;
  usuario:= v[red];
end;
{------------------------------------------------------------------------------}
function fechasIguales (fecha1, fecha2: fechaF): boolean;
var
  ok: boolean;
begin
  ok:= false;
  if ((fecha1.ano = fecha2.ano) and (fecha1.mes = fecha2.mes) and (fecha1.dia = fecha2.dia)) then
    ok:= true;
  fechasIguales:= ok;
end;
{------------------------------------------------------------------------------}
var
  v: sesiones; r_maestro, usuario: sesion; codActual, tiempoTotal, otroCodigo: integer; nombre: String; det1, det2, det3, det4, det5, mae: arch_det; fechaActual: fechaF;
begin
  write('Ingrese el nombre del archivo maestro a crear: ');
  readln(nombre);
  assign(mae, nombre);
  rewrite(mae);
  write('Ingrese el nombre del archivo detalle de la 1er PC: ');
  readln(nombre);
  assign(det1, nombre);
  reset(det1);
  write('Ingrese el nombre del archivo detalle de la 2da PC: ');
  readln(nombre);
  assign(det2, nombre);
  reset(det2);
  write('Ingrese el nombre del archivo detalle de la 3er PC: ');
  readln(nombre);
  assign(det3, nombre);
  reset(det3);
  write('Ingrese el nombre del archivo detalle de la 4ta PC: ');
  readln(nombre);
  assign(det4, nombre);
  reset(det4);
  write('Ingrese el nombre del archivo detalle de la 5ta PC: ');
  readln(nombre);
  assign(det5, nombre);
  reset(det5);   {asignar y abrir detalles: LISTO}
  leerDetalle(det1, v[1]); {inicializo el vector}
  leerDetalle(det2, v[2]);
  leerDetalle(det3, v[3]);
  leerDetalle(det4, v[4]);
  leerDetalle(det5, v[5]);   {poner en un vector el primer registro de cada uno de los 5 detalles}
  leerCodMinimo (v, usuario);   {leerCodMinimo (r): LISTO}
  while(usuario.cod <> valorImposible) do begin   {mientras no se terminen los detalles (det.cod <> valorImposible) hacer}
    writeln('primer while');
    codActual:= usuario.cod;
    readln;
    usuarioFechaMin (v, usuario, det1, det2, det3, det4, det5, codActual, otroCodigo);
    while (usuario.cod = codActual) do begin     {mientras r.codUsuario = codActual}
      writeln('segundo while');
      tiempoTotal:= 0;
      fechaActual:= usuario.fecha;
      writeln(fechaActual.dia, '/', fechaActual.mes, '/', fechaActual.ano);
      readln;
      while((usuario.cod = codActual)and(fechasIguales(fechaActual,usuario.fecha))) do begin   {mientras sea la misma fecha}
        writeln('tercer while');
        tiempoTotal:= tiempoTotal + usuario.tiempo;
        writeln('tiempoTotal = ', tiempoTotal);
        writeln('leo otro usuario minimo con misma fecha');
        readln;
        usuarioFechaMin (v, usuario, det1, det2, det3, det4, det5, codActual, otroCodigo);         {leer proximo con fechamin (registro)}
        writeln('otroCodigo = ', otroCodigo);
        if (otroCodigo = 5) then
          leerCodMinimo(v, usuario);
        writeln('usuario.cod = ', usuario.cod);
        readln;
        end;
      r_maestro.cod:= codActual;
      r_maestro.fecha:= fechaActual;
      r_maestro.tiempo:= tiempoTotal;
      write(mae, r_maestro);       {imprimir codUsuario, fechaActual y tiempoTotal}
      writeln('Imprimio un usuario correctamente!');
      end;
    end;
  close(mae);
  close(det1);
  close(det2);
  close(det3);
  close(det4);
  close(det5);
  writeln('fin');
  readln;
end.


{explota cuando se leen detalles vacios y}
{se come 1 cuando cambia la fecha pero mantiene el usuario}
