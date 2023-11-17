program ejercicio4;
const
     valorAlto = 99999;
     anoActual = 2020;
     df = 5;
type
    fechaF = record
           dia: integer;
           mes: integer;
           ano: integer;
    end;
    red = record
        cod_usuario: integer;
        fecha: fechaF;
        tiempo_total_de_sesiones_abiertas: integer;
    end;
    maquina = record
            cod_usuario: integer;
            fecha: fechaF;
            tiempo_sesion: integer;
    end;
    maestro = file of red;
    detalles = file of maquina;
    vArchivos = array [1..df] of detalles;
    vDetalles = array [1..df] of maquina;

procedure leer (var arc_det: detalles; var reg: detalles);
begin
     if (not eof(arc_det)) then
        read(arc_det,reg);
     else
         reg.cod_usuario:= valorImposible;
         reg.fecha.dia:= 32;
         reg.fecha.mes:= 13;
         reg.fecha.ano:= anoActual + 1;
     end
end;
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
procedure leerDetalles (var v: vArchivos;var d: vDetalles);
var
   reg: detalles; i : integer;
begin
     for i:= 1 to df do begin
         leer(v[i],reg);
         d[i]:= reg;
     end;
end;
procedure minimo (var vArch: vArchivos; var regMin: detalles; var registros: vDetalles; maquina: integer);
var
   min: integer; fechaMin: fechaF; reg: detalles;
begin
     regMin.cod_usuario:= valorAlto;
     min:= valorAlto;
     fechaMin.ano:= anoActual + 1;
     fechaMin.mes:= 13;
     fechaMin.dia:= 32;
     for i:= 1 to df do begin
         if (registros[i].cod_usuario < min) and ((fechaMenor(v[i].fecha, fechaMin))) do begin
            fechaMin:= registros[i].fecha;
            min:= registros[i].cod_usuario;
            maquina:= i;
            regMin:= registros[i];
         end;
         else begin(registros[i].cod_usuario = min) and ((fechaMenor(v[i].fecha, fechaMin))) do begin
            fechaMin:= registros[i].fecha;
            min:= registros[i].cod_usuario;
            maquina:= i;
            regMin:= registros[i];
         end;
     end;
     if ((regMin.cod_usuario <> valorAlto) {and ((regMin.fecha.dia <> 32) and (regMin.fecha.mes <> 13) and (regMin.fecha.ano <> (anoActual+1) ))] } ) do begin
        leer(vArch[maquina],reg);
        registros[maquina]:= reg;
     end;
end;
function fechasIguales (fecha1, fecha2: fechaF): boolean;
var
  ok: boolean;
begin
  ok:= false;
  if ((fecha1.ano = fecha2.ano) and (fecha1.mes = fecha2.mes) and (fecha1.dia = fecha2.dia)) then
    ok:= true;
  fechasIguales:= ok;
end;
var
   mae: maestro;
   r_maestro: red;
   det, regMin: detalles;
   fechaActual: fechaF;
   i,maquina,codActual, tiempoTotal: integer
   nombre: string;
   vArch: vArchivos;
   vDet: vDetalles;
begin
     for i:= 1 to df do begin
         writeln('Ingrese el nombre del archivo de la maquina: ');
         readln(nombre);
         assign(vArch[i],nombre);
     end;
     writeln('Ingrese el nombre del archivo maestro: ');
     readln(nombre);
     assign(mae,nombre);
     rewrite(mae,nombre);
     ok:=true;
     for i:= 1 to df do
         reset(vArch[i]);
     leerDetalles(vArch[i],vDet);
     minimo(vArch,regMin,vDet,maquina);
     while (regMin.cod_usuario<>valorAlto) do begin
           codActual:= regMin.cod_usuario;
           fechaActual:= regMin.fecha;
           tiempoTotal:= 0;
           while ((regMin.cod_usuario = codActual) and (fechasIguales(fechaActual,regMin.fecha)) do begin
                 tiempoTotal:= tiempoTotal + regMin.tiempo_sesion;
                 minimo(vArch,regMin,vDet,maquina);
           end;
           r_maestro.cod_usuario:= codActual;
           r_maestro.fecha:= fechaActual;
           r_maestro.tiempo_total_de_sesiones_abiertas:= tiempoTotal;
           write(mae,r_maestro);
           writeln('Codigo actual: ',codActual);
           writeln('Fecha actual: ',fechaActual.ano, '/' ,fechaActual.mes, '/' ,fechaActual.dia);
           writeln('Tiempo total: ',tiempoTotal);
     end;
     close(mae);
     for i:= 1 to df do close(vArch[i]);
end;



