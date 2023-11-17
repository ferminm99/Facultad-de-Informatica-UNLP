const
     valorAlto = 9999;
type
    ave = record
        cod:integer;
        especie:string;
        familia:integer;
        desc:integer;
        zona:integer;
    end;
    aves = file of ave;
    avesB = file of integer;
procedure leerA(var a:ave);
begin
     writeln('cod: ');
     readln(a.cod);
     if (a.cod <> 0) then begin
        writeln('especie: ');
        readln(a.especie);
        a.familia:= random(15);
        writeln('familia: ',a.familia);
        a.desc:= random(100);
        writeln('desc: ',a.desc);
        a.zona:= random(20);
        writeln('zona: ',a.zona);
     end;
end;
procedure generarArchivo(var arc:aves);
var
   a:ave;
begin
     rewrite(arc);
     leerA(a);
     while (a.cod <> 0) do begin
           write(arc,a);
           leerA(a);
     end;
     close(arc);
end;
procedure mostrarArchivo(var arc:aves);
var
   reg:ave;
begin
     reset(arc);
     writeln('cantidad : ',FileSize(arc));
     while (not eof(arc)) do begin
           read(arc,reg);
           writeln('cod ', reg.cod,' especie: ',reg.especie);
     end;
     close(arc);
end;
procedure generarArcABorrar(var arc:avesB);
var
   especie:integer;
begin
     writeln('ingresar codigos a borrar ');
     rewrite(arc);
     writeln('cod: ');
     readln(especie);
     while (especie <> 10000) do begin
           write(arc,especie);
           writeln('cod: ');
           readln(especie);
     end;
     close(arc);
end;
procedure mostrarArchivo2(var arc:avesB);
var
   reg:integer;
begin
     reset(arc);
     while (not eof(arc)) do begin
           read(arc,reg);
           writeln('cod: ',reg);
     end;
     close(arc);
end;
procedure leer(var arc:aves;var esp:ave);
begin
     if (not eof(arc)) then
        read(arc,esp)
     else
         esp.cod:= valorAlto;
end;
procedure eliminarAves(var arc:aves; var arcB:avesB);
var
   reg:ave; esp:integer;
begin
     reset(arc);
     reset(arcB);
     while (not eof(arcB)) do begin
           read(arcB,esp);
           leer(arc,reg);
           while (reg.cod <> valorAlto) do begin
                 if (reg.cod = esp) then begin
                    reg.cod:= reg.cod*(-1);
                    seek(arc,filepos(arc)-1);
                    write(arc,reg);
                 end;
                 leer(arc,reg);
           end;
           seek(arc,0);
     end;
     close(arc);
     close(arcB);
end;
procedure compactar(var arc:aves);
var
   reg,reg2:ave;pos:integer;
begin
     reset(arc);
     while (not eof(arc)) do begin
           read(arc,reg);
           if (reg.cod < 0) then begin
              pos:= filePos(arc)-1;
              seek(arc,FileSize(arc)-1);
              read(arc,reg2);
              seek(arc,pos);
              write(arc,reg2);
              seek(arc,FileSize(arc)-1);
              truncate(arc);
              seek(arc,pos+1);
           end;
     end;
     writeln('se compacto');
end;
var
   arc:aves;   arcB:avesB;
begin
     Assign(arc,'aves.doc');
     Assign(arcB,'avesAborrar');
     generarArchivo(arc);
     mostrarArchivo(arc);
     generarArcABorrar(arcB);
     mostrarArchivo2(arcB);
     eliminarAves(arc,arcB);
     mostrarArchivo(arc);
     compactar(arc);
     mostrarArchivo(arc);
     readln();
end.
