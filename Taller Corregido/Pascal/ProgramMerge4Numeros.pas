Program  Merge;
Const
     dimf = 4;
Type
    rango = 1..10;
    lista = ^nodo;
    nodo = record
         elem : rango;
         sig: lista;
    end;
    vector = array[1..dimf]of lista;
    lista2 = ^nodo2;
    nodo2 = record
          elem : rango;
          sig: lista2;
    end;
procedure AgregarAlFinal (var l, ult: lista2; n: rango);
var
   nue : lista2;
begin
     new (nue);
     nue^.elem:= n;
     nue^.sig := NIL;
     if (l<>Nil) then
        ult^.sig := nue
     else
        l := nue;
     ult := nue;
end;

Procedure InsertarElemento ( var l: lista; n: integer);
var ant, nue, act: lista;
begin
new (nue);
nue^.elem := n;
act := l;
ant := l;
while (act<>NIL) and (act^.elem < n ) do begin
      ant := act;
      act := act^.sig ;
end;
if (ant = act) then
   l := nue {el dato va al principio}
else
    ant^.sig := nue; {va entre otros dos o al final}
nue^.sig := act ;
end;
procedure CargarVector (var v:vector);
var
   i: integer; ale: rango;
begin
     for i:= 1 to dimf do begin
         ale := random (11);
         while (ale<>0)do begin
               InsertarElemento (v[i],ale);
               ale := random (11);
         end;
     end;
end;
procedure CrearVectorListas (var v:vector);
var
   i: integer;
begin
     for i:= 1 to dimf do
         v[i]:= nil;
end;

procedure ImprimirVectorListas (v:vector);
var
   i:integer;
begin
     for i:= 1 to dimf do begin
         writeln('Libros del estante ',i,' : ');
         writeln ();
         while (v[i] <> nil) do begin
               writeln (v[i]^.elem,', ');
               v[i]:= v[i]^.sig;
         end;
     end;
end;
procedure cambiarPunt (var l:lista);
var
   aux:lista;
begin
     aux:= l;
     l:= l^.sig;
     dispose (aux);
end;
procedure DeterminarMinimo (var min:integer; var v:vector);
var
   i,j:integer;
begin
     min:=11 ;
     for i := 1 to dimf do
         if (v[i] <> nil) then
            if (v[i]^.elem < min)then begin
               min:= v[i]^.elem;
               j:=i;
            end;
     if (min <> 11) then
        cambiarPunt (v[j]);
end;

procedure Merge4(var v:vector; var l:lista2);
var
   ult: lista2; minimo: integer;
begin
    DeterminarMinimo(minimo,v);
    while (minimo <> 11) do begin
          AgregarAlFinal(l,ult,minimo);
          DeterminarMinimo (minimo,v);
    end;
end;
procedure ImprimirNL (l:lista2);
begin
     writeln();
     writeln('Estante nuevo : ');
     writeln();
     while (l <> nil) do begin
           write (l^.elem, ', ');
           l:= l^.sig;
     end;
end;

var
   v:vector; l2:lista2;
Begin
     randomize;
     crearVectorListas (v);
     CargarVector (v);
     ImprimirVectorListas (v);
     Merge4 (v,l2);
     ImprimirNL (l2);
     readln();
End.
