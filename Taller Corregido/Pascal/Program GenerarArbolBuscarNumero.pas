program GenerarArbol;
uses crt;
type
lista = ^nodo;
nodo = record
      dato:integer;
      sig:lista;
end;
arbol = ^nodo2;
nodo2 = record
      datos:integer;
      Izq:arbol;
      Der:arbol;
end;
listaNivel = ^nodo3;
nodo3 = record
      info: arbol;
      sig: listaNivel;
end;
procedure agregarAdelante (var l: lista; ale: integer);
var
   nue: lista;
begin
     new (nue);
     nue^.dato:= ale;
     nue^.sig:= l;
     l:= nue;
end;
procedure imprimirOrdenado (L: lista);
begin
if (L <> nil) then begin
   writeln (l^.dato);
   imprimirOrdenado (L^.sig);
   end;
end;
procedure GenerarLista (var l:lista);
var
   ale:integer;
begin
randomize;
ale:= random (10);
while (ale <> 0) do begin
      agregarAdelante (l,ale);
      ale:= random (10);
      end;
end;
function ContarElementos (l: listaNivel): integer;
  var c: integer;
begin
 c:= 0;
 While (l <> nil) do begin
   c:= c+1;
   l:= l^.sig;
 End;
 contarElementos := c;
end;
Procedure AgregarAtras (var l, ult: listaNivel; a:arbol);
 var nue:listaNivel;

 begin
 new (nue);
 nue^.info := a;
 nue^.sig := nil;
 if l= nil then l:= nue
           else ult^.sig:= nue;
 ult:= nue;
 end;
Procedure imprimirpornivel(a: arbol);
var
   l, aux, ult: listaNivel;
   nivel, cant, i: integer;
begin
   l:= nil;
   if (a <> nil)then begin
      nivel:= 0;
      agregarAtras (l,ult,a);
      while (l<> nil) do begin
            nivel := nivel + 1;
            cant:= contarElementos(l);
            write ('Nivel ', nivel, ': ');
            for i:= 1 to cant do begin
                write (l^.info^.datos, ' - ');
                if (l^.info^.Izq <> nil) then
                   agregarAtras (l,ult,l^.info^.Izq);
                if (l^.info^.Der <> nil) then
                   agregarAtras (l,ult,l^.info^.Der);
                aux:= l;
                l:= l^.sig;
                dispose (aux);
            end;
                writeln;
      end;
   end;
end;
procedure InsertarA (var a:arbol; num:integer);
var
   nue:arbol;
begin
if (a = nil) then begin
   new (nue);
   nue^.datos:= num;
   nue^.izq:= nil;
   nue^.der:= nil;
   a:= nue;
end
else
if (a^.datos > num) then
   insertarA (a^.izq,num)
else
    insertarA (a^.der,num);
end;
Procedure GenerarArbol1 (var a:arbol;l:lista);
begin
a:= nil;
while (l <> nil) do begin
      insertarA (a,l^.dato);
      l:= l^.sig;
      end;
end;
procedure buscar (a:arbol; num:integer; var a2:arbol);
begin
     if (a <> nil) and (a^.datos <> num) then
        if (a^.datos > num) then
           buscar (a^.izq,num,a2)
        else
           buscar (a^.der,num,a2);
     if (a = nil) then
        a2:= nil
     else
         if (a^.datos = num) then
            a2:= a;
end;

var
   l:lista; a,a2:arbol; num:integer;
begin
     GenerarLista (l);
     writeln ('Lista generada aleatoriamente: ');
     imprimirOrdenado (l);
     GenerarArbol1 (a,l);
     writeln ('Por nivel: ');
     imprimirPorNivel (a);
     writeln ('se ingresa un numero a buscar: ');
     readln (num);
     buscar (a,num,a2);
     if (a2 = nil) then
        writeln ('el numero no se encuentra en el arbol')
     else
         writeln ('el numero se encuentra en el arbol');
readkey;
end.
