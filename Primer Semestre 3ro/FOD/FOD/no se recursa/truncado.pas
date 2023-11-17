program ejercicio6;
const
     valor_alto = 99999;
type
    prenda = record
           codigo : integer;
           stock : integer;
           precio : real;
    end;
    maestro = file of prenda;
    archivo = file of integer;

procedure LeerMaestro (var a: maestro;var r: prenda);
begin
     if (not eof(a)) then
        read(a,r)
     else
         r.codigo := valor_alto;
end;

procedure LeerArchivo (var a: archivo;var r: integer);
begin
     if (not eof(a)) then
        read(a,r)
     else
         r := valor_alto;
end;

procedure truncadoFisico (var mae: arch_mae);
var
  r, aux: prenda; posActual, tam: integer;
begin
  tam:= fileSize(mae);
  while(filePos(mae) < tam) do begin
    read(mae, r);
    if (r.stock <= 0) then begin
      posActual:= filePos(mae) - 1;
      seek(mae, tam - 1);
      read(mae, aux);
      seek(mae, posActual);
      write(mae, aux);
      tam:= tam - 1;
      seek(mae, posActual);
    end; 
  end;
  seek(mae, tam);
  truncate(mae);
end;

var
   m : maestro;
   a : archivo;
   reg,reg2 : prenda;
   cod,delete,contador : integer;
begin
     assign(m,'D:\Facultad\FOD\Practica 3\maestro.dat');
     assign(a,'D:\Facultad\FOD\Practica 3\detalle.dat');
     reset(m);
     reset(a);
     LeerArchivo(a,cod);
     while (cod <> valor_alto) do begin
           seek(m,0);
           LeerMaestro(m,reg);
           while (reg.codigo <> valor_alto) and (cod <> reg.codigo) do
                 LeerMaestro(m,reg);
           if (reg.codigo <> valor_alto) then begin
              seek(m,filepos(m)-1);
              reg.stock := reg.stock*(-1);
              write(m,reg);
           end;
           LeerArchivo(a,cod);
     end;
     close(a);
     seek(m,0);
     LeerMaestro(m,reg);
     delete := 0;
     contador := 0;
     while (reg.codigo <> valor_alto) do begin
           contador := contador+1;
           if (reg.stock < 0) then begin
              contador := 0;
              delete := delete+1;
              LeerMaestro(m,reg2);
              while (reg2.codigo <> valor_alto) do begin
                    seek(m,filepos(m)-2);
                    write(m,reg2);
                    seek(m,filepos(m)+1);
                    LeerMaestro(m,reg2);
              end;
           end;
           seek(m,contador);
           LeerMaestro(m,reg);
     end;
     if (delete > 0) then begin
        seek(m,filesize(m)-delete);
        Truncate(m);
     end;
     close(m);
     reset(m);
     LeerMaestro(m,reg);
     while (reg.codigo <> valor_alto) do begin
           writeln(reg.codigo);
           LeerMaestro(m,reg);
     end;
     close(m);
     readln;
end.
