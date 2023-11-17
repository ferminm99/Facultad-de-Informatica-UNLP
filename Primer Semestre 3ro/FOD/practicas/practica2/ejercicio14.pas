const
     df = 100;
     valorAlto = 99999;
type
    regMaestro = record
               fecha:integer;
               cod:integer;
               nombre:string;
               desc:string;
               precio:integer;
               ejemTotal:integer;
               ejemV:integer;
    end;
    regDetalle = record
               fecha:integer;
               cod:integer;
               vendidos:integer;
    end;
    maestro = file of regMaestro;
    detalle = file of regDetalle;
    vDetalles = array[1..df] of detalle;
    vRegistros = array[1..df] of regDetalle;
procedure leerDetalle(var arc:detalle;var reg:regDetalle);
begin
     if (not eof(arc)) then
        read(arc,reg)
     else
         reg.fecha:= valorAlto;
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
     regMin.fecha:= valorAlto;
     min:= 99999;
     codMin:= 999999;
     for i:= 1 to df do begin
         if (vReg[i].fecha < min)  then begin
            min:= vReg[i].fecha;
            codMin:= vReg[i].cod;
            regMin:= vReg[i];
            posMin:= i;
         end
         else begin
             if (vReg[i].fecha = min) and (vReg[i].cod < codMin) then begin
                min:= vReg[i].fecha;
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
procedure maximo (reg:regMaestro; var fechaMax,codMax,max:integer);
begin
     if (reg.ejemTotal > max) then begin
        fechaMax:= reg.fecha;
        codMax:= reg.cod;
        max:= reg.ejemTotal;
     end;
end;
procedure minimo2 (reg:regMaestro; var fechaMin,codMin,min:integer);
begin
     if (reg.ejemTotal < min) then begin
        fechaMin:= reg.fecha;
        codMin:= reg.cod;
        min:= reg.ejemTotal;
     end;
end;
procedure actualizar (var arc:maestro; var v:vDetalles;var fechaMax,codMax,fechaMin,codMin:integer);
var
   vReg:vRegistros; regMin:regDetalle;   i,fecha,total,cod,max,min:integer;  reg:regMaestro;
begin
     max:= -1;
     min:= 99999999;
     reset(arc);
     for i:= 1 to df do
         reset(v[i]);
     leerDetalles(v,vReg);
     minimo(v,vReg,regMin);
     while (regMin.fecha <> valorAlto) do begin
           fecha:= regMin.fecha;
           while (regMin.fecha = fecha) do begin
                 cod:= regMin.cod;
                 total:= 0;
                 while (regMin.fecha = fecha) and (regMin.cod = cod) do begin
                       total:= total + regMin.vendidos;
                       minimo(v,vReg,regMin);
                 end;
                 read(arc,reg);
                 while (reg.fecha <> fecha) do
                       read(arc,reg);
                 //Como dice "No se realizan ventas de semanarios si no hay ejemplares para hacerlo" entiendo que en caso de no tener suficientes no se hara NINGUNA compra
                 if((reg.ejemTotal - total) >=0)then begin
                     reg.ejemTotal:= reg.ejemTotal - total;
                     seek(arc,FilePos(arc)-1);
                     write(arc,reg);
                     maximo(reg,fechaMax,codMax,max);
                     minimo2(reg,fechaMin,codMin,min);
                 end;
           end;
     end;
     close(arc);
     for i:= 1 to df do
         close(v[i]);
end;
var
   arc_m:Maestro; v:vDetalles; i,fechaMax,fechaMin,codMin,codMax:integer; nombre:string;
begin
     Assign(arc_m,'ejemplares');
     for i:= 1 to df do begin
         writeln('ingrese nombre fisico de archivo ',i);
         readln(nombre);
         assign(v[i],nombre);
     end;
     actualizar(arc_m,v,fechaMax,codMax,fechaMin,codMin);
end.
