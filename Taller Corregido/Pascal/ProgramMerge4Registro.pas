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
    vector = array [cate] of lista;

    empleado2 = record
              apellido:string;
              ano: anoR;
              cat: cate;
    end;
    lista2 = ^nodo2;
    nodo2 = record
          elem : empleado2;
          sig:lista2;
    end;
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

procedure crearVector(var v: vector);
var
   i:integer;
begin
     for i:= 1 to 4 do
         v[i]:= nil;
end;

procedure CargarVector (var v:vector);
var
   j: integer; e:empleado;
begin
     for j:= 1 to 15 do begin
         leerEmpleado (e);
         InsertarElemento (v[e.cat],e);
     end;
end;

procedure AgregarAlFinal (var l, ult: lista2; e: empleado2);
var
   nue : lista2;
begin
     new (nue);
     nue^.elem:= e;
     nue^.sig := NIL;
     if (l<>Nil) then
        ult^.sig := nue
     else
        l := nue;
     ult := nue;
end;

procedure DeterminarMinimo (var min:empleado2; var v:vector);
var
   i,j:integer;
begin
     min.apellido:='zzzzzz' ;
     for i := 1 to 4 do begin
         if (v[i] <> nil) then begin
            if (v[i]^.dato.apellido < min.apellido)then begin
               min.apellido:= v[i]^.dato.apellido;
               j:=i;
            end;
         end;
     end;
     if (min.apellido <> 'zzzzzz') then begin
        min.cat:= v[j]^.dato.cat;
        min.ano:= v[j]^.dato.ano;
        v[j]:= v[j]^.sig;
     end;

end;

procedure Merge4(v:vector; var l:lista2);
var
   ult: lista2; e:empleado2;
begin
    DeterminarMinimo(e,v);
    while (e.apellido<> 'zzzzzz') do begin
          AgregarAlFinal(l,ult,e);
          DeterminarMinimo (e,v);
    end;
end;
procedure ImprimirNL (l:lista2);
begin
     writeln();
     writeln('Lista nueva : ');
     writeln();
     while (l <> nil) do begin
           writeln ('Apellido : ',l^.elem.apellido, ',Categoria :  ',l^.elem.cat,' ,Ano : ',l^.elem.ano);
           l:= l^.sig;
     end;
end;

procedure ImprimirVector (v:vector);
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
   v:vector; l2:lista2;
Begin
     crearVector(v);
     cargarVector (v);
     ImprimirVector (v);
     Merge4 (v,l2);
     ImprimirNL(l2);
     readln();
End.
