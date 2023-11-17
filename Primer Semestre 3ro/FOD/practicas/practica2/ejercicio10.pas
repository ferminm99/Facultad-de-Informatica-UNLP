const
     valorAlto = 999999;
type
    info = record
         anio:integer;
         mes:integer;
         dia:integer;
         id:integer;
         tiempo:integer;
    end;
    informacion = file of info;
procedure leer(var arc:informacion; var reg:info);
begin
     if (not eof(arc)) then
        read(arc,reg)
     else
         reg.anio:= valorAlto;
end;
procedure informar(var arc:informacion);
var
   reg:info;   num,anio,mes,dia,id,tiempoAnio,tiempoMes,tiempoDia,tiempo:integer;
begin
     reset(arc);
     writeln('ingrese numero de anio para informar:');
     readln(num);
     leer(arc,reg);
     while (reg.anio <> valorAlto) and (reg.anio <> num) do
           leer(arc,reg);
     if (reg.anio <> valorAlto) then begin
           tiempoAnio:= 0;
           writeln('anio: ',num);
           anio:= reg.anio;
           while (reg.anio <> valorAlto) and (reg.anio = anio) do begin
                 tiempoMes:=0;
                 mes:= reg.mes;
                 writeln ('    mes: ', mes);
                 while (reg.anio = anio) and (reg.mes = mes) do begin
                       tiempoDia:= 0;
                       dia:= reg.dia;
                       writeln('          dia: ',dia);
                       while (reg.anio = anio) and (reg.mes = mes) and (reg.dia = dia) do begin
                             tiempo:= 0;
                             id:= reg.id;
                             while (reg.anio = anio) and (reg.mes = mes) and (reg.dia = dia) and (reg.id = id) do begin
                                   tiempo:= reg.tiempo + tiempo;

                                   leer(arc,reg);
                             end;
                             write('             id usuario: ', id);
                             writeln ('             tiempo total del dia ', dia ,' mes ',mes ,' :',tiempo);
                             tiempoDia:= tiempoDia + tiempo;
                       end;
                       writeln('   tiempo total de acceso del dia ',dia,' mes ',mes, ' : ',tiempoDia);
                       tiempoMes:= tiempoMes + tiempoDia;
                 end;
                 writeln(' tiempo total de acceso del mes ', mes, ': ',tiempoMes);
                 tiempoAnio:= tiempoAnio + tiempoMes;
           end;
           writeln('tiempo total acceso del anio ', anio, ': ',tiempoAnio);
     end
     else
         writeln('el anio no se encuentra en el archivo');
     close(arc);
end;
procedure leerInfo(var reg:info);
begin
     writeln('anio: ');
     readln(reg.anio);
     if (reg.anio <> 0) then begin
        writeln('mes: ');
        readln(reg.mes);
        writeln('dia: ');
        readln(reg.dia);
        writeln('id: ');
        readln(reg.id);
        writeln('tiempo: ');
        readln(reg.tiempo);
     end;
end;
procedure generarArchivo(var arc:informacion);
var
   reg:info;
begin
     rewrite(arc);
     leerInfo(reg);
     while (reg.anio <> 0) do begin
           write(arc,reg);
           leerInfo(reg);
     end;
     close(arc);
end;
procedure mostrarArchivo (var arc:informacion);
var
   reg:info;
begin
     reset(arc);
     while (not eof(arc)) do begin
           read(arc,reg);
           writeln('anio: ',reg.anio,' mes: ',reg.mes,' dia: ',reg.dia,' id: ' ,reg.id,' tiempo: ',reg.tiempo);
     end;
     close(arc);
end;
var
   arc:informacion;
begin
     Assign(arc,'info');
     generarArchivo(arc);
     mostrarArchivo(arc);
     informar(arc);
     readln();
end.
