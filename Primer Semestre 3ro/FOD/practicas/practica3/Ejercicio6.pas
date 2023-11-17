const
     valorAlto=99999;
type
    prenda = record
           cod:integer;
           desc:string;
           colores:integer;
           tipo:string;
           stock:integer;
           precio:integer;
    end;
    prendas = file of prenda;
    prendasO = file of integer;
procedure leerP(var p:prenda);
begin
     writeln('cod: ');
     readln(p.cod);
     if (p.cod <> 0) then begin
        writeln('desc: ');
        readln(p.desc);
        writeln('tipo: ');
        readln(p.tipo);
        p.stock:= random(6);
        writeln('stock: ',p.stock);
        p.precio:= random(100);
        writeln('precio: ',p.precio);
        p.colores:= random(5);
        writeln('colores: ',p.colores);
     end;
end;
procedure generarArchivo(var arc:prendas);
var
   p:prenda;
begin
     randomize;
     rewrite(arc);
     leerP(p);
     while (p.cod <> 0) do begin
           write(arc,p);
           leerP(p);
     end;
     close(Arc);
end;
procedure generarArc2(var arc:prendasO);
var
   cod:integer;
begin
     writeln('codigos obsoletos: ');
     rewrite(arc);
     writeln('cod : ');
     readln(cod);
     while (cod <> 0) do begin
           write(arc,cod);
           writeln('cod : ');
           readln(cod);
     end;
     close(arc);
end;
procedure leer(var arc:prendasO; var cod:integer);
begin
     if (not eof(arc))then
        read(arc,cod)
     else
         cod:= valorAlto;
end;
procedure actualizar (var arc:prendas;var arcO:prendasO);
var
   reg:prenda; cod:integer;
begin
     reset(arc);
     reset(arcO);
     while (not eof(arc)) do begin
           read(arc,reg);
           leer(arcO,cod);
           while (cod <> valorAlto) and (cod <> reg.cod) do
                 leer(arcO,cod);
           if (cod = reg.cod) then begin
              reg.stock:= reg.stock*(-1);
              seek(arc,filePos(arc)-1);
              write(arc,reg);
           end;
           seek(arcO,0);
     end;
     close(arcO);
     close(arc);
end;
procedure compactar(var arc:prendas );
var
  reg:prenda;  arcc:prendas;
begin
     Assign(arcc,'auxasd');
     reset(arc);
     rewrite(arcc);
     while (not eof(arc)) do begin
           read(arc,reg);
           if (reg.stock >= 0) then
              write(arcc,reg);
     end;
     arc:= arcc;
     close(arc);
     close(arcc);
     writeln('se compacto');
end;
procedure mostrarArchivo (var arc:prendas);
var
   reg:prenda;
begin
     writeln('codigos prendas: ');
     reset(arc);
     while (not eof(arc)) do begin
           read(arc,reg);
           writeln('cod: ',reg.cod,' stock: ',reg.stock);
     end;
     close(arc);
end;
procedure mostrarArc2 (var arc:prendasO);
var
   reg:integer;
begin
     writeln('codigos obsoletos');
     reset(arc);
     while (not eof(arc)) do begin
           read(arc,reg);
           writeln('cod: ',reg);
     end;
     close(arc);
end;
var
   arc:prendas; arcO:prendasO;
begin
     Assign(arc,'prendas');
     Assign(arcO,'prendasO');
     generarArchivo(arc);
     mostrarArchivo(arc);
     generarArc2(arcO);
     mostrarArc2(arcO);
     actualizar(arc,arcO);
     mostrarArchivo(arc);
     compactar(arc);
     mostrarArchivo(arc);
     readln();
end.
