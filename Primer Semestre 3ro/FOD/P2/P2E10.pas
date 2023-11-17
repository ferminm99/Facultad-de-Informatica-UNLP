{La empresa de software ‘X’ posee un servidor web donde se encuentra alojado el sitio de la organización. En dicho servidor, se almacenan en un archivo
todos los accesos que se realizan al sitio. La información que se almacena en el archivo es la siguiente: año, mes, dia, idUsuario y tiempo de acceso
al sitio de la organización. El archivo se encuentra ordenado por los siguientes criterios: año, mes, dia e idUsuario. Se debe realizar un procedimiento
que genere un informe en pantalla, para ello se indicará el año calendario sobre el cual debe realizar el informe. El mismo debe respetar el formato mostrado
a continuación:
Año : --
      Mes:-- 1
         día:-- 1
                         idUsuario 1   Tiempo Total de acceso en el dia 1 mes 1
                         --------
                         idusuario N    Tiempo total de acceso en el dia 1 mes 1
         Tiempo total acceso dia 1 mes 1
         ------------
         día N
             idUsuario 1   Tiempo Total de acceso en el dia N mes 1
             --------
             idusuario N    Tiempo total de acceso en el dia N mes 1
         Tiempo total acceso dia N mes 1
      Total tiempo de acceso mes 1

      Mes 12
        día 1
            idUsuario 1   Tiempo Total de acceso en el dia 1 mes 12
            --------
            idusuario N    Tiempo total de acceso en el dia 1 mes 12
            Tiempo total acceso dia 1 mes 12
            ------------
            día N
                idUsuario 1   Tiempo Total de acceso en el dia N mes 12
                --------
                idusuario N    Tiempo total de acceso en el dia N mes 12
            Tiempo total acceso dia N mes 12
        Total tiempo de acceso mes 12
      Total tiempo de acceso año
Se deberá tener en cuenta las siguientes aclaraciones:
- El año sobre el cual realizará el informe de accesos debe leerse desde teclado.
- El año puede no existir en el archivo, en tal caso, debe informarse en pantalla “año no encontrado”.
- Debe definir las estructuras de datos necesarias.
- El recorrido del archivo debe realizarse una única vez procesando sólo la información necesaria.

año, mes, dia, idUsuario y tiempo de acceso
se encuentra ordenado por los siguientes criterios: año, mes, dia e idUsuario}

program x;
const
  valorImposible= 999999;
Type
  acceso = record
    ano: integer;
    mes: integer;
    dia: integer;
    idUsuario: integer;
    tiempo: integer;
    end;

  arch_mae = file of acceso;

{---------------------------------------------------------------------------------}
procedure leerMaestro(var mae: arch_mae; var rm: acceso);
begin
  if(not EOF(mae)) then
    read(mae, rm)
  else
    rm.idUsuario:= valorImposible;
end;
{---------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------}
var
  mae: arch_mae; rm: acceso; anoIngresado, mesActual, diaActual, usuarioActual, tiempoUsuario, tiempoDia, tiempoMes, tiempoAno: integer;
begin
  assign(mae, 'mae1');
  reset(mae);
  write('Ingrese el año del cual se quiere informar: ');
  readln(anoIngresado);
  leerMaestro(mae, rm);
  while((rm.ano <> anoIngresado) and (rm.idUsuario <> valorImposible)) do
    leerMaestro(mae, rm);
  if(rm.ano = anoIngresado) then begin
    writeln('Año: ', rm.ano);
    tiempoAno:= 0;
    while((rm.ano = anoIngresado) and (rm.idUsuario <> valorImposible)) do begin
      writeln('Mes: ', rm.mes);
      mesActual:= rm.mes;
      tiempoMes:= 0;
      while((rm.mes = mesActual) and (rm.ano = anoIngresado) and (rm.idUsuario <> valorImposible)) do begin
        writeln('Dia: ', rm.dia);
        diaActual:= rm.dia;
        tiempoDia:= 0;
        while ((rm.dia = diaActual) and (rm.mes = mesActual) and (rm.ano = anoIngresado) and (rm.idUsuario <> valorImposible)) do begin
          usuarioActual:= rm.idUsuario;
          tiempoUsuario:= 0;
          while((rm.idUsuario = usuarioActual) and (rm.dia = diaActual) and (rm.mes = mesActual) and (rm.ano = anoIngresado) and (rm.idUsuario <> valorImposible)) do begin
            tiempoUsuario:= tiempoUsuario + rm.tiempo;
            leerMaestro(mae, rm);
            end;
          tiempoDia:= tiempoDia + tiempoUsuario;
          writeln('ID: ', usuarioActual,'. Tiempo total de acceso en el dia ', diaActual, ' mes ', mesActual);
          writeln(tiempoUsuario);
          end;
        tiempoMes:= tiempoMes + tiempoDia;
        writeln('Tiempo total de acceso en el dia ', diaActual, ' mes ', mesActual);
        writeln(tiempoDia);
        end;
      tiempoAno:= tiempoAno + tiempoMes;
      writeln('Tiempo total de acceso en el mes ', mesActual);
      writeln(tiempoMes);
      end;
    writeln('Tiempo total de acceso en el ano ', anoIngresado);
    writeln(tiempoAno);
    end
  else
    writeln('El año ingresado no se encuentra en el archivo de accesos');
  close(mae);
end.



