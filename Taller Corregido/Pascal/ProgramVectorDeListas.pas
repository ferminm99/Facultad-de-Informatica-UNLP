Program  VectorDeListas;
type
    anoR = 1980..2018;
    cate = 1..4;
    empleado = record
             cod: integer;
             apellido: string;
             ano: anoR;
             cat: cate;
    end;
    lista = ^nodo;
    nodo = record
         dato: empleado;
         sig: lista;
    end;
    vec = array [cate] of lista;
Procedure InsertarElemento ( var pri: lista; per: empleado);
var ant, nue, act: lista;
begin
  new (nue);
  nue^.dato := per;
  act := pri;
  ant := pri;
{Recorro mientras no se termine la lista y no encuentro la posición correcta}
  while (act<>NIL) and (act^.dato.apellido < per.apellido) do begin
      ant := act;
      act := act^.sig ;
  end;
  if (ant = act)  then pri := nue   {el dato va al principio}
                  else  ant^.sig  := nue; {va entre otros dos o al final}
  nue^.sig := act ;
end;
procedure leerEmpleado (var e:empleado);
begin
     e.cod:= random (100);
     writeln ('Apellido: ');
     readln (e.apellido);
     e.cat:= random(4);
     e.cat:= e.cat+1;
     e.ano:= random(39);
     e.ano:= e.ano +1980;
end;

procedure GenerarVector (var v:vec);
var
   i,j: integer; e:empleado;
begin
     for i:= 1 to 4 do
         v[i]:= nil;
     for j:= 1 to 15 do begin
         leerEmpleado (e);
         InsertarElemento (v[e.cat],e);
     end;
end;
procedure ImprimirVector (v:vec);
var
   i:integer;
begin
     for i:= 1 to 4 do begin
         writeln();
         writeln('Categoria ',i,' : ');
         writeln();
         while (v[i] <> nil) do begin
               writeln ('Apellido : ',v[i]^.dato.apellido,', Codigo: ',v[i]^.dato.cod);
               v[i]:= v[i]^.sig;
         end;
     end;
end;

var
   v:vec;
Begin
     GenerarVector (v);
     ImprimirVector (v);
     readln();
End.
