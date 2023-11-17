program x;
Type

  sesion = record
    anio: integer;
    mes: integer;
    dia: integer;
    id: string;
    tiempo: integer;
    end;

  arch_mae = file of sesion;

{----------------------------------------------------------}
{----------------------------------------------------------}
{----------------------------------------------------------}
{----------------------------------------------------------}
{----------------------------------------------------------}
{----------------------------------------------------------}
{----------------------------------------------------------}
{----------------------------------------------------------}

var
  anioElegido, totalAnio, mesActual, totalMes, diaActual, totalDia, totalId: integer; nomb: string; mae: arch_mae; r: sesion;  idActual: string;
begin
  write('Ingrese el nombre del archivo con el que desea trabajar: ');
  readln(nomb);
  assign(mae, nomb);
  reset(mae);
  write('Ingrese el anio que desea imprimir: ');
  readln(anioElegido);
  r.anio:= -1;
  while((not EOF(mae)) and (r.anio <> anioElegido)) do
    read(mae, r);
  if(r.anio <> anioElegido) then
    writeln('No se encontró el anio a buscar')
  else begin
    writeln('Anio: ', anioElegido);
    totalAnio:= 0;
    while((not EOF(mae)) and (r.anio = anioElegido)) do begin
      mesActual:= r.mes;
      writeln('  Mes: ', mesActual);
      totalMes:= 0;
      while((mesActual = r.mes) and (not EOF(mae))and (r.anio = anioElegido)) do begin
        diaActual:= r.dia;
        writeln('    Dia: ', diaActual);
        totalDia:= 0;
        while((r.dia = diaActual) and (mesActual = r.mes) and (not EOF(mae))and (r.anio = anioElegido)) do begin
          idActual:= r.id;
          totalId:= 0;
          while ((r.id = idActual) and (r.dia = diaActual) and (mesActual = r.mes) and (not EOF(mae))and (r.anio = anioElegido)) do begin
            totalId:= totalId + r.tiempo;
            read(mae, r);
            end;
          writeln('      id = ' + idActual + ', tiempo total el ', diaActual, '/', mesActual, ': ', totalId);
          totalDia:= totalDia + totalId;
          end;
        writeln('    Tiempo total en el ', diaActual, '/', mesActual, ': ', totalDia);
        totalMes:= totalMes + totalDia;
        end;
      writeln('  Tiempo total en el mes ', mesActual, ': ', totalMes);
      totalAnio:= totalAnio + totalMes;
      end;
    writeln('Tiempo total de acceso en el anio: ', totalAnio);
  end;
  readln;
end.
