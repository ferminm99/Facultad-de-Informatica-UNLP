Const
  df = 5;
  valorAlto = 9999999;
type
    regMaestro = record
               cod : integer;
               fecha : integer;
               tiempoTotal: integer;
    end;
    regDetalle= record
                cod: integer;
                fecha: integer;
                tiempo: integer;
    end;

    maestro = file of regMaestro;
    detalle = file of regDetalle;
    vRegistros = array[1..df] of regDetalle;
    vDetalles = array [1..df] of detalle;
procedure leerDetalle(var arc:detalle;var reg:regDetalle);
begin
     if (not eof(arc)) then
        read(arc,reg)
     else
         reg.cod:= valorAlto;
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
   reg:regDetalle;  i,posMin,min,fechaMin:integer;
begin
     regMin.cod:= valorAlto;
     min:= 99999;
     fechaMin:= 999999;
     for i:= 1 to df do begin
         if (vReg[i].cod < min)  then begin
            min:= vReg[i].cod;
            fechaMin:= vReg[i].fecha;
            regMin:= vReg[i];
            posMin:= i;
         end
         else begin
             if (vReg[i].cod = min) and (vReg[i].fecha < fechaMin) then begin
                min:= vReg[i].cod;
                fechaMin:= vReg[i].fecha;
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

procedure generarMaestro(var arc_m:maestro; var v:vDetalles);
var
   aux:regMaestro; regMin:regDetalle; vReg: vRegistros;
begin
     leerDetalles(v,vReg);
     minimo(v,vReg,regMin);
     while (regMin.cod <> valorAlto) do begin
           aux.cod:= regMin.cod;
           aux.tiempoTotal:= 0;
           aux.fecha:= regMin.fecha;
           while (aux.cod = regMin.cod) and (aux.fecha = regMin.fecha) do begin
                 aux.tiempoTotal:= aux.tiempoTotal+regMin.tiempo;
                 minimo(v,vReg,regMin);
           end;
           write(arc_m,aux);
     end;
end;

var
   arc_m:maestro; v:vDetalles; i:integer;   nombre:string;
begin
     Assign(arc_m,'/var/log');
     for i:= 1 to df do begin
         writeln('ingrese nombre fisico');
         readln(nombre);
         assign(v[i],nombre);
         reset(v[i]);
     end;
     rewrite(arc_m);
     generarMaestro(arc_m,v);
     for i:= 1 to df do
         close(v[i]);
     close(arc_m);
end.
