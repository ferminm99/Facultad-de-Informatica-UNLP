program a;
const
  valorImposible = 999999;
Type

  mesa = record
    codProv: integer;
    codLoc: integer;
    numero: integer;
    cant: integer;
    end;

  arch_mae = file of mesa;

{-----------------------------------------------------------------}
procedure leerMaestro(var mae: arch_mae; var rm: mesa);
begin
  if(not EOF(mae)) then
    read(mae, rm)
  else begin
    rm.codProv:= valorImposible;
    rm.codLoc:= valorImposible;
    end;
end;
{-----------------------------------------------------------------}
var
  id: String; mae: arch_mae; totalProv, totalLocalidad, provActual, localidadActual: integer; rm: mesa;
begin
  write('Ingrese el nombre del archivo maestro: ');
  readln(id);
  assign(mae, id);
  reset(mae);
  leerMaestro(mae, rm);
  while(rm.codProv <> valorImposible) do begin
    totalProv:= 0;
    provActual:= rm.codProv;
    while (rm.codProv <> valorImposible) and (rm.codProv = provActual) do begin
      totalLocalidad:= 0;
      localidadActual:= rm.codLoc;
      while(rm.codProv <> valorImposible) and (rm.codProv = provActual) and(rm.codLoc = localidadActual) do begin
        totalLocalidad:= totalLocalidad + rm.cant;
        leerMaestro(mae, rm);
        end;
      writeln('Codigo de localidad      Total de Votos');
      write(localidadActual);
      write('                           ');
      writeln(totalLocalidad);
      totalProv:= totalProv + totalLocalidad;
      end;
    writeln('Total de votos de la provincia ', provActual,': ', totalProv);
    writeln;
    end;
  close(mae);
  readln;
end.
