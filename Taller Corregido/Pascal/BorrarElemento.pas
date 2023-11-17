Program arboles;
Type

  // Arbol de enteros
  arbol= ^nodoA;
  nodoA = Record
    dato: integer;
    HI: arbol;
    HD: arbol;
  End;

  // Lista de Arboles
  listaNivel = ^nodoN;
  nodoN = record
    info: arbol;
    sig: listaNivel;
  end;

   lista = ^nodo;
 nodo = record
         datos: integer;
       	 sig: lista;
 end;
procedure imprimir (l:lista);
begin
     while (l <> nil) do begin
           writeln (l^.datos);
           l:= l^.sig;
     end;
end;

Procedure AgregarAdelante (var L:lista; per:integer);
Var
   nue:Lista;
Begin
   New(nue);
   nue^.datos:=per;
   nue^.sig:=L;
   L:=nue;
End;


{-----------------------------------------------------------------------------
CONTARELEMENTOS - Devuelve la cantidad de elementos de una lista l }

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


{-----------------------------------------------------------------------------
AGREGARATRAS - Agrega un elemento atrás en l}

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


{-----------------------------------------------------------------------------
IMPRIMIRPORNIVEL - Muestra los datos del árbol a por niveles }

Procedure imprimirpornivel(a: arbol);
var
   l, aux, ult: listaNivel;
   nivel, cant, i: integer;
begin
   l:= nil;
   if(a <> nil)then begin
                 nivel:= 0;
                 agregarAtras (l,ult,a);
                 while (l<> nil) do begin
                    nivel := nivel + 1;
                    cant:= contarElementos(l);
                    write ('Nivel ', nivel, ': ');
                    for i:= 1 to cant do begin
                      write (l^.info^.dato, ' - ');
                      if (l^.info^.HI <> nil) then agregarAtras (l,ult,l^.info^.HI);
                      if (l^.info^.HD <> nil) then agregarAtras (l,ult,l^.info^.HD);
                      aux:= l;
                      l:= l^.sig;
                      dispose (aux);
                     end;
                     writeln;
                 end;
               end;
end;


procedure GenerarLista (var l: lista);
var
   ale: integer;
begin
     l:= nil;
     ale:=random(20);
     while (ale<>0)do begin
           AgregarAdelante(l,ale);
           ale:=random(20);
     end;
end;
procedure insertar (var a:arbol; num:integer);
var
   nue:arbol;
begin
     if (a = nil) then begin
        new (nue);
        nue^.dato:= num;
        nue^.HI:= nil;
        nue^.HD:= nil;
        a:= nue;
     end
     else begin
         if (a^.dato > num) then
            insertar (a^.HI,num)
         else
             if (a^.dato < num) then
                insertar (a^.HD,num);
     end;
end;
procedure generarArbol (var a:arbol; l:lista);
begin
     a:= nil;
     while (l <> nil) do begin
           insertar (a,l^.datos);
           l:= l^.sig;
     end;
end;
Procedure PreOrden( a: arbol );
begin
 if ( a <> nil ) then begin
    writeln (a^.dato, '');
    PreOrden (a^.HI);
    PreOrden (a^.HD)
 end;
end;
procedure Orden(a:arbol);
begin
     if (a<>nil)then begin
        Orden(a^.HI);
        writeln(a^.dato);
        Orden(a^.HD);
     end;
end;
procedure postOrden(a:arbol);
begin
     if (a<>nil)then begin
        postOrden(a^.HI);
        postOrden(a^.HD);
        writeln(a^.dato);
     end;
end;



procedure BuscarMinDer (a:arbol; var dato:integer);
begin
     if (a^.HI <> nil) then
        BuscarMinDer (a^.HI, dato)
    else
       dato:= a^.dato; {encontro el minimo derecho}
end;

procedure borrarElemento (var a:arbol; dato:integer; var r:boolean);
var
    aux:arbol;
begin
if (a = nil) then begin
   r:= false;
  end
  else
      if (dato < a^.dato) then begin
         borrarElemento (a^.HI, dato, r);
      end
      else begin
            if (dato > a^.dato) then begin
               borrarElemento (a^.HD, dato, r);
            end
            else begin
                  r:=true;
                  if (a^.HI = nil ) then begin
                      aux:=a;
                      a:=a^.HD;
                      dispose(aux);
                  end
                  else begin
                      if (a^.HD = nil) then begin
                          aux:=a;
                          a:=a^.HI;
                          dispose(aux)
                      end
                      else {tiene los 2 hijos}
                           begin
                            BuscarMinDer ( a^.HD, dato );
                            writeln('El dato a borrar es: ', a^.dato);
                            a^.dato := dato;
                            borrarElemento (a^.HD, dato, r);
                           end;
                  end;
              end;
       end;

end;
procedure recorridoAcotado(a:arbol; inf,sup: integer);
begin
     if (a <> nil) then begin
        if (a^.dato >= inf) then begin
           if (a^.dato <= sup) then begin
              writeln (a^.dato);
              recorridoAcotado (a^.HI, inf, sup);
              recorridoAcotado (a^.HD, inf, sup);
           end
           else
               recorridoAcotado (a^.HI, inf, sup);
        end
        else
            recorridoAcotado (a^.HD, inf, sup);
     end;
end;
{PROGRAMA PRINCIPAL}
var
   l:lista; a:arbol; dato:integer;r:boolean;
begin
 r:=false;
 Randomize;
 GenerarLista(l);
 writeln ('lista :' );
 imprimir(l);
 generarArbol (a,l);
 imprimirpornivel (a);
 writeln('preOrden: ');
 PreOrden(a);
 imprimirPorNivel(a);
 write ('Ingrese dato a borrar: ');
 readln(dato);
 borrarElemento(a,dato,r);
 if (r)then
    writeln ('el elemento se borro')
 else
     writeln ('el elemento no esta en la estructura');
 PreOrden(a);
 writeln ();
 imprimirPorNivel(a);
 readln;
end.
