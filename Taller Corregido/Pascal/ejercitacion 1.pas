Program Ejercitacion1;
Type
    producto = record
             tipo: string;
             descrip: string;
             cod: integer;
             precio: integer;
    end;
    arbol = ^nodo;
    nodo = record
         dato: producto;
         hd: arbol;
         hi: arbol;
    end;
    listaNivel = ^nodo3;
    nodo3 = record
          info: arbol;
          sig: listaNivel;
    end;
procedure insertar (var a:arbol; p:producto);
var
   nue: arbol;
begin
     if (a = nil) then begin
        new (nue);
        nue^.dato:= p;
        nue^.hi:= nil;
        nue^.hd:= nil;
        a:= nue;
     end
     else begin
         if (a^.dato.cod > p.cod) then
            insertar (a^.hi,p)
         else
             insertar (a^.hd,p);
     end;
end;

procedure leerProducto (var p:producto);
begin
     writeln ('se ingresa un tipo: ');
     readln (p.tipo);
     if (p.tipo <> 'ZZZ') then begin
        writeln ('descripcion: ');
        readln (p.descrip);
        p.cod:= random(5000);
        p.precio:= random(200);
     end;
end;

procedure generarArbol (var a:arbol);
var
   p:producto;
begin
     a:= nil;
     leerProducto (p);
     while (p.tipo <> 'ZZZ') do begin
           insertar (a,p);
           leerProducto (p);
     end;
end;
procedure MostrarArbol (var a:arbol);
begin
     writeln ('-');
     if (a <> nil) then begin
        writeln ('codigo: ', a^.dato.cod);
        writeln ('precio: ', a^.dato.precio);
        writeln ('tipo: ', a^.dato.tipo);
        writeln ('descripcion: ', a^.dato.descrip);
        mostrarArbol (a^.hi);
        mostrarArbol (a^.hd);
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
procedure informarTipoDisc (a:arbol; inf,sup:integer);
begin
     if (a <> nil) then begin
        if (a^.dato.cod >= inf) then begin
           if (a^.dato.cod <= sup) then begin
              writeln ('tipo: ', a^.dato.tipo);
              writeln ('descripcion: ', a^.dato.descrip);
              informarTipoDisc (a^.hi,inf,sup);
              informarTipoDisc (a^.hd,inf,sup);
           end
           else
               informarTipoDisc (a^.hi,inf,sup);
        end
        else
            informarTipoDisc (a^.hd,inf,sup);
     end;
end;
procedure informarCantP (a:arbol; var cant: integer; inf, sup:integer);
begin
     if (a <> nil) then begin
        if (a^.dato.precio >= inf) and (a^.dato.precio <= sup) then
           cant:= cant +1;
        informarCantP (a^.hi,cant,inf,sup);
        informarCantP (a^.hd,cant,inf,sup);
     end;
end;

Var
   a: arbol; inf,sup,cant: integer;
Begin
     randomize;
     generarArbol (a);
     writeln ('datos del arbol: ');
     MostrarArbol (a);
     imprimirpornivel (a);
     inf:= 1500;
     sup:= 2200;
     informarTipoDisc (a,inf,sup);
     inf:= 50;
     sup:= 100;
     cant:= 0;
     informarCantP (a,cant,inf,sup);
     writeln ('cantidad de producots con precio entre 50 y 100: ', cant);
     readln();
end.
