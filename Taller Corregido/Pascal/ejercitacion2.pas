program ejercitacion2;
type
    fechas = record
           ano: integer;
           mes: integer;
           dia: integer;
    end;
    ventas = record
           fecha: fechas;
           cod: integer;
           tipo: string;
           cant: integer;
           montoT: integer;
    end;

    lista = ^nodo;
    nodo = record
         dato: ventas;
         sig: lista;
    end;
    arbol = ^nodo2;
    nodo2 = record
         dato: ventas;
         hi: arbol;
         hd: arbol;
    end;
        listaNivel = ^nodo3;
    nodo3 = record
          info: arbol;
          sig: listaNivel;
    end;
procedure leerFecha (var f:fechas);
begin
     f.ano:= (random(9)+2010);
     f.mes:= (random(12))+1;
     f.dia:= (random(31))+1;
end;

procedure leerVentas (var v:ventas);
begin
     v.cant:= (random(7))-1;
     if (v.cant <> -1) then begin
        v.cod:= random (2000);
        v.cod:= 1000 + v.cod;
        writeln ('tipo :');
        readln (v.tipo);
        v.montoT:= random(300);
        leerFecha (v.fecha);
     end;
end;
procedure agregarAdelante (var l:lista; v:ventas);
var
   nue: lista;
begin
     new (nue);
     nue^.dato:= v;
     nue^.sig:= l;
     l:= nue;
end;

procedure generarLista (var l:lista;var v:ventas);
begin
     leerVentas (v);
     if (v.cant <> -1) then begin
        agregarAdelante (l,v);
        generarLista (l,v);
     end;
end;
procedure mostrarL (l:lista);
begin
     if (l <> nil) then begin
        writeln ('codigo: ',l^.dato.cod);
        writeln ('montoT: ',l^.dato.montoT);
        writeln ('tipo: ',l^.dato.tipo);
        mostrarL (l^.sig);
     end;
end;
procedure insertar (var a:arbol; v:ventas);
var
   nue: arbol;
begin
     if (a = nil) then begin
        new (nue);
        nue^.dato:= v;
        nue^.hi:= nil;
        nue^.hd:= nil;
        a:= nue;
     end
     else begin
         if (a^.dato.cod > v.cod) then
            insertar (a^.hi,v)
         else
             insertar (a^.hd,v);
     end;
end;

procedure generarArbol (var a:arbol; l:lista);
begin
     a:= nil;
     while (l <> nil) do begin
           insertar (a,l^.dato);
           l:= l^.sig;
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
                write (l^.info^.dato.cod, ' - ');
                if (l^.info^.hi <> nil) then
                   agregarAtras (l,ult,l^.info^.hi);
                if (l^.info^.hd <> nil) then
                   agregarAtras (l,ult,l^.info^.hd);
                aux:= l;
                l:= l^.sig;
                dispose (aux);
            end;
                writeln;
      end;
   end;
end;
procedure imprimirTipo (a: arbol; inf,sup: integer);
begin
     if (a <> nil) then begin
        if (a^.dato.cod >= inf) then begin
           if (a^.dato.cod <= sup) then begin
              writeln ('tipo : ', a^.dato.tipo);
              imprimirTipo (a^.hi,inf,sup);
              imprimirTipo (a^.hd,inf,sup);
           end
           else
               imprimirTipo (a^.hi,inf,sup);
        end
        else
            imprimirTipo (a^.hd,inf,sup);
     end;
end;
procedure cantVentas (a:arbol; var cant:integer);
begin
     if (a <> nil) then begin
        if (a^.dato.montoT > 100) then
           cant:= cant+1;
        cantVentas (a^.hi,cant);
        cantVentas (a^.hd,cant);
     end;
end;
var
   a:arbol; l:lista; v:ventas; inf,sup,cant:integer;
begin
     randomize;
     l:= nil;
     generarLista (l,v);
     writeln ('lista :');
     mostrarL (l);
     generarArbol (a,l);
     imprimirpornivel (a);
     inf:= 1500;
     sup:= 2200;
     writeln ('tipos de productos con codigo entre 1500 y 2200');
     imprimirTipo (a,inf,sup);
     cant:= 0;
     cantVentas (a,cant);
     writeln ('cantidad de ventas con precio mayor a 100: ', cant);
     readln();
end.
