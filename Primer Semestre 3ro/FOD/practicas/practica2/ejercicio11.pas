const
     valorAlto = 99999;
type
    regMaestro = record
               nroU:integer;
               nombreU:string;
               nombre:string;
               apellido:string;
               cantM:integer;
    end;
    regDetalle = record
               nroU:integer;
               cuentaD:string;
               mensaje:string;
    end;
    maestro = file of regMaestro;
    detalle = file of regDetalle;
procedure leer(var arc:detalle; var reg:regDetalle);
begin
     if (not eof(arc))then
        read(arc,reg)
     else
         reg.nroU:= valorAlto;
end;
procedure actualizar (var arc:maestro; var arc_d:detalle);
var
   reg:regMaestro; regD:regDetalle;   total,nroU:integer;
begin
     reset(arc);
     reset(arc_d);
     leer(arc_D,regD);
     while (regD.nroU <> valorAlto) do begin
           nroU:= regD.nroU;
           total:= 0;
           while (regD.nroU = nroU) do begin
                 total:= total + 1;
                 leer(arc_d,regD);
           end;
           read(arc,reg);
           while (reg.nroU <> nroU) do begin
                 read(arc,reg);
           end;
           reg.cantM:= reg.cantM + total;
           seek(arc,FilePos(arc)-1);
           write(arc,reg);
     end;
end;
procedure listarArchivo (var arc:maestro; var arc_d:detalle; var txt:text);
var
   reg:regMaestro; regD:regDetalle;   total,nroU:integer;
begin
     reset(arc);
     reset(arc_d);
     rewrite(txt);
     leer(arc_d,regD);
     while (not eof(arc)) do begin
           read(arc,reg);
           if (regD.nroU = reg.nroU) then begin
              nroU:= reg.nroU;
              total:= 0;
              while (nroU = regD.nroU) do begin
                    total:= total+1;;
                    leer(arc_d,regD);
              end;
              reg.cantM:= reg.cantM + total;
              seek(arc,filePos(arc)-1);
              write(arc,reg);
           end;
           write(txt,reg.nroU,reg.nombreU,reg.nombre,reg.apellido,reg.cantM);
     end;
end;
var
   arc_m:maestro; arc_d,arc_d2:detalle;  txt:Text;
begin
     Assign(arc_m,' /var/log/logmail.dat');
     //Este archivo pertenece a un día particular
     Assign(arc_d,'detalle');
     //Otro archivo con un detalle de un día determinado
     Assign(arc_d2,'detalle2');
     Assign(txt,'text');
     actualizar(arc_m,arc_d);
     listarArchivo(arc_m,arc_d2,txt);
end.
