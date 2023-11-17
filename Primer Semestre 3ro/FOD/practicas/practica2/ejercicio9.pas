const
     df =2;
     valorAlto = 'zzzzzz';
type
    provincia = record
              nombre:string;
              cantA:integer;
              cantE:integer;
    end;
    Detalle = record
            nombre:string;
            codL:integer;
            cantA:integer;
            cantE:integer;
    end;
    detalles = file of detalle;
    vDetalles = array[1..df] of detalles;
    vRegistros = array[1..df] of detalle;
    provincias = file of provincia;
procedure leer (var arc: detalles; var reg:detalle);
begin
     if (not eof(arc)) then
        read(arc,reg)
     else
         reg.nombre:= valorAlto;
end;
procedure leerDetalles(var v:vDetalles;var vReg:vRegistros);
var
   reg:detalle; i:integer;
begin
     for i:= 1 to df do begin
         leer(v[i],reg);
         vReg[i]:= reg;
     end;
end;
procedure minimo (var vDet:vDetalles; var vReg:vRegistros; var regMin:detalle);
var
   posMin,i:integer; reg:detalle;  min:string;
begin
     regMin.nombre:= valorAlto;
     min:= valorAlto;
     for i:= 1 to df do begin
         if (vReg[i].nombre < min) then begin
            min:= vReg[i].nombre;
            regMin:= vReg[i];
            posMin:= i;
         end;
     end;
     if (regMin.nombre <> valorAlto) then begin
        leer(vDet[posMin],reg);
        vReg[posMin]:= reg;
     end;
end;
procedure actualizar (var arc:provincias; var vDet:vDetalles);
var
   regMin:detalle; regP,reg:provincia;    i:integer;     vReg: vRegistros;
begin
     reset(arc);
     for i:= 1 to df do
         reset(vDet[i]);
     leerDetalles(vDet,vReg);
     minimo(vDet,vReg,regMin);
     while (regMin.nombre <> valorAlto) do begin
           regP.cantA:= 0;
           regP.cantE:= 0;
           regP.nombre:= regMin.nombre;
           while (regMin.nombre = regP.nombre ) do begin
                 regP.cantA:= regP.cantA + regMin.cantA;
                 regP.cantE:= regP.cantE + regMin.cantE;
                 minimo(vDet,vReg,regMin);
           end;
           read(arc,reg);
           while (reg.nombre <> regP.nombre) do
                 read(arc,reg);
           seek(arc,FilePos(arc)-1);
           write(arc,regP);
     end;
     close(arc);
     for i:= 1 to df do
         close(vDet[i]);
end;
var
   vDet:vDetalles; arc_p:provincias;    i:integer; nombre:string;
begin
     Assign(arc_p,'maestro');
     for i:= 1 to df do begin
         writeln('ingrese nombre fisico para detalle ',i);
         readln(nombre);
         Assign(vDet[i],nombre);
     end;
     Actualizar(arc_p,vDet);
end.
