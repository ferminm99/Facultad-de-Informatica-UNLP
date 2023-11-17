const
     df = 10;
     valorAlto = 99999;
type
    regMaestro = record
               dni:integer;
               cod:integer;
               montoTotal:integer;
    end;
    regDetalle = record
               dni:integer;
               cod:integer;
               monto:integer;
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
         reg.dni:= valorAlto;
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
   reg:regDetalle;  i,posMin,min,codMin:integer;
begin
     regMin.dni:= valorAlto;
     min:= 99999;
     codMin:= 999999;
     for i:= 1 to df do begin
         if (vReg[i].dni < min)  then begin
            min:= vReg[i].cod;
            codMin:= vReg[i].cod;
            regMin:= vReg[i];
            posMin:= i;
         end
         else begin
             if (vReg[i].dni = min) and (vReg[i].cod < codMin) then begin
                min:= vReg[i].cod;
                codMin:= vReg[i].cod;
                regMin:= vReg[i];
                posMin:= i;
             end;
         end;
     end;
     if (regMin.cod <> valorAlto) then begin
        leerDetalle(v[posMin],reg);
        vReg[posMin]:= reg;
     end;
end;
procedure actualizar (var arc:maestro; var v:vDetalles);
var
   vReg: vRegistros ; i,dni,cod,totalPago:integer;  regMin:regDetalle;     reg:regMaestro;
begin
     reset(arc);
     for i:= 1 to df do
         reset(v[i]);
     leerDetalles(v,vReg);
     minimo(v,vReg,regMin);
     while (regMin.dni <> valorAlto) do begin
           dni:=regMin.dni;
           while (regMin.dni = dni) do begin
                 cod:= regMin.cod;
                 totalPago:= 0;
                 while (regMin.dni = dni) and (regMin.cod = cod) do begin
                       totalPago:= totalPago+regMin.monto;
                       minimo(v,vReg,regMin);
                 end;
                 read(arc,reg);
                 while (reg.dni <> dni) do
                       read(arc,reg);
                 reg.montoTotal:= reg.montoTotal + totalPago;
                 seek(arc, FilePos(arc)-1);
                 write(arc,reg);
           end;
     end;
     close(arc);
     for i:= 1 to df do
         close(v[i]);
end;
procedure generarTexto(var arc:maestro; var txt:text);
var
   reg:regMaestro;
begin
     reset(arc);
     rewrite(txt);
     while (not eof(arc)) do begin
           read(arc,reg);
           if (reg.montoTotal = 0) then begin
              writeln(txt,reg.dni,' ', reg.cod,' ','alumno moroso');
           end;
     end;
     close(arc);
     close(txt);
end;
var
   arc:maestro; vD:vDetalles;  i:integer; nombre:string; txt:text;
begin
     Assign(arc,'maestro');
     for i:= 1 to df do begin
         writeln('ingrese nombre fisico para archivo ',i);
         readln(nombre);
         assign(vD[i],nombre);
     end;
     actualizar(arc,vD);
     assign(txt,'txt');
     generarTexto(arc,txt);
end.
