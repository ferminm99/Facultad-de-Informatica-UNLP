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
ale:= random (20);
while (ale <> 0) do begin
      agregarAdelante (l,ale);
      ale:= random (20);
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
function BusMin (a:arbol):integer;
begin
         if (a <> nil) then begin
		       if (a^.Izq <> nil) then
                    busMin:= busMin (a^.Izq)
               else
                   busMin:= a^.datos;
         end
         else
		       busMin:= -1;
end;

function BusMax (a:arbol):integer;
begin
         if (a <> nil) then begin
		       if (a^.der <> nil) then
                    busMax:= busMax (a^.der)
               else
                   busMax:= a^.datos;
         end
         else
		       busMax:= -1;
end;
var
   l:lista; a:arbol;
begin
     GenerarLista (l);
     writeln ('Lista generada aleatoriamente: ');
     imprimirOrdenado (l);
     GenerarArbol1 (a,l);
     writeln ('Por nivel: ');
     imprimirPorNivel (a);
     if (BusMin(a) = -1) then
        writeln ('el arbol estaba vacio')
     else
         writeln ('el numero minimo es: ', BusMin(a));
     if (BusMax(a) = -1) then
        writeln ('el arbol estaba vacio')
     else
         writeln ('el numero maximo es: ', BusMax(a));
     readkey;
end.
