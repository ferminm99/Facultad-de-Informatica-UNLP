uses SysUtils;
type
   tTitulo = string[50];
   tArchRevistas = file of tTitulo;

procedure generarArchivo(var arc:tArchRevistas);
var
   titulo: tTitulo;
begin
     rewrite(arc);
     write(arc,'0');
     writeln('ingrese nombre titulo: ');
     readln(titulo);
     while (titulo <> ' ')do begin
           write(arc,titulo);
           writeln('ingrese nombre titulo: ');
           readln(titulo);
     end;
     close(arc);
end;
procedure mostrarArchivo(var arc:tArchRevistas);
var
   t:tTitulo;
begin
     reset(arc);
     while (not eof(arc)) do begin
           read(arc,t);
           writeln('titulo: ',t);
     end;
     close(arc);
end;
procedure leer(var arc:tarchrevistas;var t:tTitulo);
begin
     if (not eof(arc)) then
        read(arc,t)
     else
         t:= 'zzzzzz';
end;

procedure agregar(var arc:tarchrevistas; t: tTitulo);
var
   t2,t3:tTitulo;  num:integer;
begin
     reset(arc);
     leer(arc,t2);
     num:= StrToInt(t2);
     if (num < 0) then begin
        seek(arc,-(num));
        read(arc,t3);
        seek(arc,0);
        write(arc,t3);
        seek(arc,-(num));
        write(arc,t);
     end
     else begin
          seek(arc,FileSize(arc));
          write(arc,t);
     end;
end;
procedure darBaja (var arc:tArchRevistas);
var
   t,t2,t3:tTitulo;   pos:integer;
begin
     reset(arc);
     writeln('ingrese titulo a eliminar');
     readln(t2);
     leer(arc,t);
     while (t <> 'zzzzzz') and (t <> t2)do
           leer(arc,t);
     if (t = t2) then begin
        pos:= filePos(arc)-1;
        seek(arc,0);
        read(arc,t3);
        seek(arc,pos);
        write(arc,t3);
        seek(arc,0);
        pos:= pos*(-1);
        t:= IntToStr(pos);
        write(arc,t);
     end
     else
         writeln('no se encontro el titulo a eliminar');
     close(arc);

end;
procedure listarArchivo(var arc:tarchrevistas; var txt:text);
var
   t:tTitulo;  num:integer;
begin
     reset(arc);
     rewrite(txt);
     while (not eof(arc)) do begin
           read(arc,t);
           num:= StrToInt(t);
           if (num = 0) then
              write(txt,t);
     end;
end;
var
   arc:tArchRevistas;      t:tTitulo;    txt:text;
begin
     Assign(arc,'revistas');
     generarArchivo(arc);
     mostrarArchivo(arc);
     darBaja(arc);
     writeln('titulo a agregar: ');
     readln(t);
     agregar(arc,t);
     Assign(txt,'txtt');
     listarArchivo(arc,txt);
     readln();
end.
