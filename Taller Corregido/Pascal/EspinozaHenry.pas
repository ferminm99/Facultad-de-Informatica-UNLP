program EspinozaHenry;
type
    vehiculos = record
              patente: integer;
              fecha: integer;
              hora: integer;
              precio: integer;
    end;
    lista = ^nodo;
    nodo = record
         dato: vehiculos;
         sig: lista;
    end;
    arbol = ^nodo2;
    nodo2 = record
         datos: integer;
         l: lista;
         hi: arbol;
         hd: arbol;
    end;
    listaNivel = ^nodo3;
    nodo3 = record
      info: arbol;
      sig: listaNivel;
    end;
procedure leerVehiculos (var v:vehiculos);
begin
     v.precio:= random (100);
     if (v.precio <> 0) then begin
        v.patente:= random (800);
        v.fecha:= random (32);
        v.hora:= random (60);
        v.precio:= random (500);
     end;
end;
procedure agregarAdelante (var l:lista;v:vehiculos);
var
   nue: lista;
begin
     new (nue);
     nue^.dato:= v;
     nue^.sig:= l;
     l:= nue;
end;

procedure InsertarA (var a:arbol; v:vehiculos);
var
   nue:arbol;
begin
     if (a = nil) then begin
        new (nue);
        nue^.datos:= v.patente;
        nue^.hi:= nil;
        nue^.hd:= nil;
        nue^.l:= nil;
        a:= nue;
        agregarAdelante (a^.l,v);

     end
     else
         if (a^.datos > v.patente) then
            insertarA (a^.hi,v)
         else
             if (a^.datos < v.patente) then
               insertarA (a^.hd,v)
             else
                 agregarAdelante (a^.l,v);
end;

procedure generarArbol (var a:arbol);
var
   v:vehiculos;
begin
     a:= nil;
     leerVehiculos (v);
     while (v.precio <> 0) do begin
           insertarA (a,v);
           leerVehiculos (v);
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
Procedure determinarCant( a: arbol;var cant:integer );
var
   suma: integer;  aux:lista;
begin
     suma:= 0;
     if (a <> nil ) then begin
        aux:= a^.l;
        while (aux <> nil) do begin
              suma:= aux^.dato.precio + suma;
              aux:= aux^.sig;
        end;
        if (suma >= 200) and (suma <= 800) then
              cant:= cant +1;
        determinarCant (a^.hi,cant);
        determinarCant (a^.hd,cant);
     end;
end;

procedure imprimirPasosLista (l:lista);
begin
     writeln ('pasos de un vehiculo : ');

     while (l <> nil) do begin
           writeln ('precio: ', l^.dato.precio);
           writeln ('patente: ', l^.dato.patente);
           writeln ('fecha: ', l^.dato.fecha);
           writeln ('hora: ', l^.dato.hora);
           l:= l^.sig;
     end;
end;

procedure imprimirPasos (a: arbol; inf, sup: integer);
begin
if (a <> nil) then
   if (a^.datos >= inf) then
      if (a^.datos <= sup) then begin
         imprimirPasosLista (a^.l);
         imprimirPasos (a^.hi, inf, sup);
         imprimirPasos (a^.hd, inf, sup);
         end
      else
      imprimirPasos (a^.hi, inf, sup)
   else
   imprimirPasos (a^.hd, inf, sup);
end;
var
   a:arbol; valor1,valor2,cant:integer;
begin
     generarArbol (a);
     imprimirpornivel (a);
     cant:= 0;
     determinarCant (a,cant);
     writeln ('cantidad de patentes que deben pagar entre 200 y 800 pesos: ', cant);
     writeln ('se ingresa un valor: ');
     readln (valor1);
     writeln ('se ingresa otro valor: ');
     readln (valor2);
     imprimirPasos (a,valor1,valor2);
     readln ();
end.
