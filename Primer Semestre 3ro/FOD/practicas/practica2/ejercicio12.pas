const
     df = 2;
     valorAlto = 'zzzzzzzz';
type
    regMaestro = record
               destino: string;
               fecha: integer;
               horaS: integer;
               asientosD:integer;
    end;
    regDetalle = record
               destino: string;
               fecha: integer;
               horaS: integer;
               asientosC: integer;
    end;
    maestro = file of regMaestro;
    detalle = file of regDetalle;
    vRegistros = array[1..df] of regDetalle;
    vDetalles = array[1..df] of detalle;
procedure leerDetalle(var arc:detalle;var reg:regDetalle);
begin
     if (not eof(arc)) then
        read(arc,reg)
     else
         reg.Destino:= valorAlto;
end;
procedure leerDetalles(var v:vDetalles;var vReg:vRegistros);
var
   i:integer;
begin
     for i:= 1 to df do
         leerDetalle(v[i],vReg[i]);
end;
procedure minimo (var v:vDetalles; var vReg:vRegistros; var regMin:regDetalle);
var
   reg:regDetalle;  i,posMin,fechaMin,horaMin:integer;  min:string;
begin
     regMin.destino:= valorAlto;
     min:= 'zzzzz';
     fechaMin:= 999999;
     horaMin:= 9999999;
     for i:= 1 to df do begin
         if (vReg[i].destino < min)  then begin
            min:= vReg[i].destino;
            fechaMin:= vReg[i].fecha;
            horaMin:= vReg[i].horaS;
            regMin:= vReg[i];
            posMin:= i;
         end
         else begin
             if (vReg[i].destino = min) and (vReg[i].fecha < fechaMin) then begin
                min:= vReg[i].destino;
                fechaMin:= vReg[i].fecha;
                horaMin:= vReg[i].horaS;
                regMin:= vReg[i];
                posMin:= i;
             end
             else begin
                  if (vReg[i].destino = min) and (vReg[i].fecha = fechaMin) and (vReg[i].horaS < horaMin) then begin
                     min:= vReg[i].destino;
                     fechaMin:= vReg[i].fecha;
                     horaMin:= vReg[i].horaS;
                     regMin:= vReg[i];
                     posMin:= i;
                  end;
             end;
         end;
     end;
     if (regMin.destino <> valorAlto) then begin
        leerDetalle(v[posMin],reg);
        vReg[posMin]:= reg;
     end;
end;
procedure actualizar (var arc:maestro; var vD: vDetalles);
var
   reg:regMaestro; regMin:regDetalle; i,fecha,hora,totalComprado:integer;  vR:vRegistros; destino:string;
begin
     reset(arc);
     for i:= 1 to df do
         reset(vD[i]);
     leerDetalles(vD,vR);
     minimo(vD,vR,regMin);
     while (regMin.destino <> valorAlto) do begin
           destino:= regMin.destino;
           while (regMin.destino = destino) do begin
                 fecha:= regMin.fecha;
                 while (regMin.destino = destino) and (regMin.fecha = fecha) do begin
                       hora:= regMin.horaS;
                       totalComprado:= 0;
                       while (regMin.destino = destino) and (regMin.fecha = fecha) and (regMin.horaS = hora) do begin
                             totalComprado:= totalComprado + regMin.asientosC;
                             minimo(vD,vR,regMin);
                       end;
                       read(arc,reg);
                       while (reg.destino <> destino) do
                             read(arc,reg);
                       reg.asientosD:= reg.asientosD - totalComprado;
                       seek(arc,FilePos(arc)-1);
                       write(arc,reg);
                 end;
           end;

     end;
     close(arc);
     for i:= 1 to df do
         close(vD[i]);
end;
procedure listarArchivo(var arc:maestro; var txt:text; num:integer);
var
   reg:regMaestro;
begin
     reset(arc);
     rewrite(txt);
     while (not eof(arc)) do begin
           read(arc,reg);
           if (reg.asientosD < num) then
              writeln(txt,reg.destino,' ',reg.fecha,' ',reg.horaS);
     end;
     close(arc);
     close(txt);
end;
var
   arc_m:maestro; vDet:vDetalles; i,num:integer;  nombre:string;  txt:text;
begin
     Assign(arc_m,'maestro');
     for i:= 1 to df do begin
         writeln('ingrese nombre fisico de ', i);
         readln(nombre);
         Assign(vDet[i],nombre);
     end;
     actualizar(arc_m,vDet);
     Assign(txt,'lista.txt');
     writeln('ingresar una cantidad de asientos: ');
     readln(num);
     listarArchivo(arc_m,txt,num);
end.
