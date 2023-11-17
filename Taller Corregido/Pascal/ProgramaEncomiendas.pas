Program encomiendas;
Type

   encomienda = record
                  codigo: integer;
                  peso: integer;
                end;

  // Lista de encomiendas
  lista = ^nodoL;
  nodoL = record
    dato: encomienda;
    sig: lista;
  end;
  lista2 = ^nodo2;
  nodo2 = record
        dato: integer;
        sig: lista2;
  end;
  arbol = ^nodo;
  nodo = record
       peso: integer;
       l:lista2;
       izq: arbol;
       der: arbol;
  end;
  listaNivel = ^nodo3;
  nodo3 = record
      info: arbol;
      sig: listaNivel;
  end;

{-----------------------------------------------------------------------------
AgregarAdelante - Agrega una encomienda adelante en l}
procedure agregarAdelante(var l: Lista; enc: encomienda);
var
  aux: lista;
begin
  new(aux);
  aux^.dato := enc;
  aux^.sig := l;
  l:= aux;
end;


{-----------------------------------------------------------------------------
CREARLISTA - Genera una lista con datos de las encomiendas }
procedure crearLista(var l: Lista);
var
  e: encomienda;
  i: integer;
begin
 l:= nil;
 for i:= 1 to 10 do begin
   e.codigo := i;
   e.peso:= random (10);
   while (e.peso = 0) do e.peso:= random (10);
   agregarAdelante(L, e);
 End;
end;

procedure agregarAdelante2 (var l:lista2; peso:integer);
var
   nue: lista2;
begin
     new (nue);
     nue^.dato:= peso;
     nue^.sig:= l;
     l:= nue;
end;
{-----------------------------------------------------------------------------
IMPRIMIRLISTA - Muestra en pantalla la lista l }
procedure imprimirLista(l: Lista);
begin
 While (l <> nil) do begin
   writeln('Codigo: ', l^.dato.codigo, '  Peso: ', l^.dato.peso);
   l:= l^.sig;
 End;
end;
procedure insertar (var a:arbol; e:encomienda);
var
   nue: arbol;
begin
     if (a = nil) then begin
        new (nue);
        nue^.peso:= e.peso;
        nue^.izq:= nil;
        nue^.der:= nil;
        nue^.l:= nil;
        a:= nue;
        agregarAdelante2 (nue^.l,e.codigo);
     end
     else
         if (a^.peso > e.peso) then
            insertar (a^.izq,e)
         else
             if (a^.peso < e.peso) then
                insertar (a^.der,e)
             else
                 agregarAdelante2 (a^.l,e.codigo);
end;
procedure generarArbol (var a:arbol; l:lista);
begin
     a:= nil;
     while (l <> nil) do begin
           insertar (a,l^.dato);
           l:=l^.sig;
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
                write (l^.info^.peso, ' - ');
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

procedure imprimirEnOrden (a:arbol);
var
   aux: lista2;
begin
     if (a <> nil) then begin
        imprimirEnOrden(a^.izq);
        writeln('codigos del peso ', a^.peso, ':');
        aux:= a^.l;
        while (aux <> nil) do begin
              writeln (aux^.dato);
              aux:=aux^.sig
        end;
        imprimirEnOrden(a^.der);
     end;
end;

procedure imprimirPreOrden (a:arbol);
var
   aux: lista2;
begin
     if (a <> nil) then begin
        writeln ('codigos del peso', a^.peso, ' :');
        aux:= a^.l;
        while (aux <> nil) do begin
              writeln (aux^.dato);
              aux:= aux^.sig
        end;
        imprimirPreOrden(a^.izq);
        imprimirPreOrden(a^.der);
     end;
end;

procedure imprimirPostOrden (a:arbol);
var
   aux: lista2;
begin
     if (a <> nil) then begin
        imprimirPostOrden(a^.izq);
        imprimirPostOrden(a^.der);
        writeln ('codigos del peso', a^.peso, ' :');
        aux:= a^.l;
        while (aux <> nil) do begin
              writeln (aux^.dato);
              aux:= aux^.sig
        end;
     end;
end;

Var
 l: lista; a:arbol;

begin
 Randomize;
 crearLista(l);
 writeln ('Lista de encomiendas generada: ');
 imprimirLista(l);
 generarArbol (a,l);
 imprimirpornivel (a);
 writeln ('recorrido en orden: ');
 imprimirEnOrden(a);
 writeln ('recorrido pre orden: ');
 imprimirPreOrden (a);
 writeln ('recorrido post orden: ');
 imprimirPostOrden (a);
 readln;
end.
