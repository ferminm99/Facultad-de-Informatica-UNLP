Program  MergeDeRegistros;
Const
     dimf = 2;
type
    consumo = record
             tipo: integer;
             fecha: integer;
             monto: integer;
    end;
    lista1 = ^nodo1;
    nodo1 = record
         dato: consumo;
         sig: lista1;
    end;
    vector = array [1..dimf] of lista1;

    consumo2 = record
              monto:integer;
              tipo: integer;
    end;
    lista2 = ^nodo2;
    nodo2 = record
          dato : consumo2;
          sig:lista2;
    end;
Procedure InsertarElemento ( var pri: lista1; per: consumo);
var ant, nue, act: lista1;
begin
  new (nue);
  nue^.dato := per;
  act := pri;
  ant := pri;
{Recorro mientras no se termine la lista y no encuentro la posición correcta}
  while (act<>NIL) and (act^.dato.tipo < per.tipo) do begin
      ant := act;
      act := act^.sig ;
  end;
  if (ant = act)  then pri := nue   {el dato va al principio}
                  else  ant^.sig  := nue; {va entre otros dos o al final}
  nue^.sig := act ;
end;
procedure leerEmpleado (var e:consumo);
begin
     e.tipo:= random(11);
     if (e.tipo <> 0)then begin
         e.monto:= random(1001);
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

procedure CargarVector (var v:vector);
var
   i: integer; e:consumo;
begin
     for i :=1 to dimf do begin
         leerEmpleado (e);
         while (e.tipo <> 0) do begin
               InsertarElemento (v[i],e);
               leerEmpleado (e);

         end;
     end;
end;

procedure AgregarAlFinal (var l,ult: lista2; e: consumo2);
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

procedure DeterminarMinimo (var min:consumo2; var v:vector);
var
   i,j:integer;
begin
     min.tipo:=11 ;
     for i := 1 to dimf do begin
         if (v[i] <> nil) then begin
            if (v[i]^.dato.tipo < min.tipo)then begin
               min.tipo:= v[i]^.dato.tipo;
               min.monto:= v[i]^.dato.monto;
               j:=i;
            end;
         end;
     end;
     if (min.tipo <> 11) then begin
        v[j]:= v[j]^.sig;
     end;

end;

procedure MergeAcumulador(v:vector; var l:lista2);
var
   ult: lista2; e,pAcum:consumo2;
begin
    DeterminarMinimo(e,v);
    while (e.tipo <> 11) do begin
          pAcum.tipo:= e.tipo;
          pAcum.monto:= 0;
          while (pAcum.tipo = e.tipo)do begin
                pAcum.monto:= pAcum.monto + e.monto;
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
           writeln ('tipo : ',l^.dato.tipo, ',monto :  ',l^.dato.monto);
           l:= l^.sig;
     end;
end;

procedure ImprimirVector (v:vector);
var
   i:integer;
begin
     for i:= 1 to dimf do begin
         writeln();
         writeln('lista ',i,' : ');
         writeln();
         while (v[i] <> nil) do begin
               writeln ('tipo : ',v[i]^.dato.tipo,', monto: ',v[i]^.dato.monto,', fecha: ',v[i]^.dato.fecha);
               v[i]:= v[i]^.sig;
         end;
     end;
end;

var
   v:vector; l2:lista2;
Begin
     randomize;
     generar(v);
     CargarVector (v);
     ImprimirVector (v);
     MergeAcumulador (v,l2);
     ImprimirNL(l2);
     readln();
End.
