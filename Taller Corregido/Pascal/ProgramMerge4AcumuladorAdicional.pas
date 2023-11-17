Program  MergeDeRegistros;
Const
     dimf = 4;
type
    venta = record
             fecha: integer;
             codigo: integer;
             cantidad: integer;
    end;
    lista1 = ^nodo1;
    nodo1 = record
         dato: venta;
         sig: lista1;
    end;
    vector = array [1..dimf] of lista1;

    venta2 = record
              codigo:integer;
              cantidad: integer;
    end;
    lista2 = ^nodo2;
    nodo2 = record
          dato : venta2;
          sig:lista2;
    end;
Procedure InsertarElemento ( var pri: lista1; per: venta);
var ant, nue, act: lista1;
begin
  new (nue);
  nue^.dato := per;
  act := pri;
  ant := pri;
{Recorro mientras no se termine la lista y no encuentro la posición correcta}
  while (act<>NIL) and (act^.dato.codigo < per.codigo) do begin
      ant := act;
      act := act^.sig ;
  end;
  if (ant = act)  then pri := nue   {el dato va al principio}
                  else  ant^.sig  := nue; {va entre otros dos o al final}
  nue^.sig := act ;
end;
procedure leerEmpleado (var e:venta);
begin
     e.codigo := random(12);
     e.codigo := e.codigo - 1;
     if (e.codigo<> -1)then begin
         e.cantidad:= random(1001);
         e.fecha:= random(39);
         e.fecha:= e.fecha +1980;
     end;
end;

procedure generar(var v: vector);
var
   i:integer;
begin
     for i:= 1 to dimf do
         v[i]:= nil;
end;

procedure CrearVector (var v:vector);
var
   i: integer; e:venta;
begin
     for i :=1 to dimf do begin
         leerEmpleado (e);
         while (e.codigo <> -1) do begin
               InsertarElemento (v[i],e);
               leerEmpleado (e);

         end;
     end;
end;

procedure AgregarAlFinal (var l,ult: lista2; e: venta2);
var
   nue : lista2;
begin
     new (nue);
     nue^.dato:= e;
     nue^.sig := NIL;
     if (l<>Nil) then
        ult^.sig := nue
     else
        l := nue;
     ult := nue;
end;

procedure DeterminarMinimo (var min:venta2; var v:vector);
var
   i,j:integer;
begin
     min.codigo:=11 ;
     for i := 1 to dimf do begin
         if (v[i] <> nil) then begin
            if (v[i]^.dato.codigo < min.codigo)then begin
               min.codigo:= v[i]^.dato.codigo;
               min.cantidad:= v[i]^.dato.cantidad;
               j:=i;
            end;
         end;
     end;
     if (min.codigo <> 11) then begin
        v[j]:= v[j]^.sig;
     end;

end;

procedure Merge4(v:vector; var l:lista2);
var
   ult: lista2; e,pAcum:venta2;
begin
    DeterminarMinimo(e,v);
    while (e.codigo<> 11) do begin
          pAcum.codigo:= e.codigo;
          pAcum.cantidad:= 0;
          while (pAcum.codigo = e.codigo)do begin
                pAcum.cantidad:= pAcum.cantidad + e.cantidad;
                DeterminarMinimo (e,v);
          end;
          AgregarAlFinal(l,ult,pAcum);
    end;
end;
procedure ImprimirNL (l:lista2);
begin
     writeln();
     writeln('Lista nueva : ');
     writeln();
     while (l <> nil) do begin
           writeln ('codigo : ',l^.dato.codigo, ',cantidad :  ',l^.dato.cantidad);
           l:= l^.sig;
     end;
end;

procedure ImprimirVector (v:vector);
var
   i:integer;
begin
     for i:= 1 to dimf do begin
         writeln();
         writeln('Vector ',i,' : ');
         writeln();
         while (v[i] <> nil) do begin
               writeln ('codigo : ',v[i]^.dato.codigo,', cantidad: ',v[i]^.dato.cantidad,', fecha: ',v[i]^.dato.fecha);
               v[i]:= v[i]^.sig;
         end;
     end;
end;

var
   v:vector; l2:lista2;
Begin
     randomize;
     generar(v);
     CrearVector (v);
     ImprimirVector (v);
     Merge4 (v,l2);
     ImprimirNL(l2);
     readln();
End.
