program ejercicio7;
const
     valorAlto = 99999;
type
    mesa = record
            codP: integer;
            codL: integer;
            mesa: integer;
            votos: integer;
    end;
    archivo_maestro = file of mesa;
procedure leerMaestro(var mae: archivo_maestro; var reg: mesa );
begin
     if (not eof(mae)) then
        read(mae,reg);
     else begin
         reg.codP:= valorAlto;
     end;
end;
var
   mae: archivo_maestro;
   nombre: string;
   regM: mesa;
   codActual,localidadAct,montoP,montoL,montoT : integer;
begin
     writeln('Ingrese el nombre del archivo maestro: ');
     readln(nombre);
     assign(mae,nombre);
     reset(mae,nombre);
     leerMaestro(mae,regM);
     montoT:= 0;
     if (regM.codP<>valorAlto) then begin
        codAct := regM.cod;
        montoP:= 0;
        writeln('Codigo provincia: ',regM.codP);
        while (codAct = regD.codP) do begin
              localidadAct:= regM.codL;
              montoL:= 0;
              while (codAct = regD.codP)and(localidadAct = regM.codL) do begin
                    montoL:= montoL + regM.votos;
                    leerMaestro(mae,regM);
              end;
              writeln('Codigo localidad ',regM.codL,' Total Votos: ',montoL);
              montoP:= montoL + montoP;
        end;
        montoT:= montoT + montoP;
     end;
     writeln('El monto total de voto es: ',montoT);
     close(mae);
     readln;
end;


