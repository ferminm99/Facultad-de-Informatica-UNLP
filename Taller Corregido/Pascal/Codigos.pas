



procedure agregarOrdenado(var l: lista;v: ventas);
var
   nue,act,ant: lista;
begin
     new(nue);nue^.datos:=v;ant:=l;act:=l;
     while (act<>nil) and (act^.codigo<v.codigo)
           ant:=act;act:=act^.sig;
     end;
     if(act=ant)then l:=nue;
     else ant^.sig:=nue;
     nue^.sig:=act;
end;

procedure agregarAtras(var l,ult: lista;v: ventas);
var
   nue: lista;
begin
     new(nue);nue^.sig:=nil;nue^.datos:=v;
     if(l=nil)then l:=nue;
     else ult^.sig:=nue;
     ult:=nue;
end;


procedure ordenar(var v: vector;diml: integer);
var
   i,j,actual: integer;
begin
     for i:=2 to diml do begin
         actual:=v[i];
         j:=i-1;
         while (actual<v[j]) and (j>0) do begin
               v[j+1]:=v[j];
               j:=j-1;
         end;
         v[j+1]:=actual;
     end;
end;

procedure busquedaDicotomica(v: vector; ini,num,fin: integer);
var
   pos: integer;
begin
     if (ini>fin) then
        writeln('No se encontro');
     else begin
          pos:=(ini+fin)div 2;
          if (num<v[pos])then begin
             fin:=pos-1;
             busquedaDicotomica(v,ini,num,fin);
          end
          else if(num>v[pos])then begin
               ini:=pos+1;
               busquedaDicotomica(v,ini,num,fin);
          end
          else
              writeln('El numero fue encontrado en la pos: ',pos);
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



PARA EL IMPRIMIR POR NIVEL:

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
AGREGARATRAS - Agrega un elemento atr?s en l}

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
IMPRIMIRPORNIVEL - Muestra los datos del ?rbol a por niveles }

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


