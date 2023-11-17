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
  anioActual = 2019;
  valorImposible = anioActual + 1;
Type
  sesion = record
    anio: integer;
    mes: integer;
    dia: integer;
    id: string;
    tiempo: integer;
    end;



  arch_mae = file of sesion;
{---------------------------------------------------------------------}
procedure leerRegistro(var arch: arch_mae; var r_arch: sesion);
begin
  if(not EOF(arch)) then
    read(arch, r_arch)
  else
    r_arch.anio := valorImposible;
end;
{---------------------------------------------------------------------}

var
  nombre, idActual: string; arch: arch_mae; r_arch: sesion; anioElegido, mesActual, diaActual, tiempoAnio, tiempoMes, tiempoDia, tiempoId: integer;
begin
  write('Ingrese la ruta del archivo a procesar: ');
  readln(nombre);
  assign(arch, nombre);
  reset(arch);
  write('Ingrese el año del archivo: ');
  readln(anioElegido);
  leerRegistro(arch, r_arch);
  while ((anioElegido <> r_arch.anio) and (r_arch.anio <> valorImposible)) do
    leerRegistro(arch, r_arch);
  if (anioElegido <> r_arch.anio) then
    writeln('No se encontro el año ingresado en el archivo.')
  else begin
    writeln('Año: ', anioElegido);
    tiempoAnio:= 0;
    while(anioElegido = r_arch.anio) do begin
      mesActual:= r_arch.mes;
      tiempoMes:= 0;
      writeln('Mes: ', mesActual);
      while((mesActual = r_arch.mes) and (anioElegido = r_arch.anio)) do begin
        diaActual:= r_arch.dia;
        tiempoDia:= 0;
        writeln('Dia: ', diaActual);
        while((diaActual = r_arch.dia) and (mesActual = r_arch.mes) and (anioElegido = r_arch.anio)) do begin
          idActual:= r_arch.id;
          tiempoId:= 0;
          while((idActual = r_arch.id) and (diaActual = r_arch.dia) and (mesActual = r_arch.mes) and (anioElegido = r_arch.anio)) do begin
            tiempoId:= tiempoId + r_arch.tiempo;
            leerRegistro(arch, r_arch);
            end;
          writeln('Usuario: ', idActual, '.Tiempo Total de acceso en el dia ', diaActual, ' mes ', mesActual);
          writeln(tiempoId);
          tiempoDia:= tiempoDia + tiempoId;
          end;
        writeln('Tiempo total acceso dia ', diaActual, ' mes ', mesActual);
        writeln(tiempoDia);
        tiempoMes:= tiempoMes + tiempoDia;
        end;
      writeln('Total tiempo de acceso mes ', mesActual);
      writeln(tiempoMes);
      tiempoAnio:= tiempoAnio + tiempoMes;
      end;
    writeln('Total tiempo de acceso año ', anioActual);
    writeln(tiempoAnio);
    end;
  readln;
end.
