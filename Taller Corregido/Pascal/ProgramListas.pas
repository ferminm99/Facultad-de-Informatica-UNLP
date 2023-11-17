Program  ejemplo;
Type  
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

Procedure InsertarElemento ( var pri: lista; per: integer);
var ant, nue, act: lista;
begin
  new (nue);
  nue^.datos := per;
  act := pri;
  ant := pri;
{Recorro mientras no se termine la lista y no encuentro la posición correcta}
  while (act<>NIL) and (act^.datos < per) do begin
      ant := act;
      act := act^.sig ;
  end;
  if (ant = act)  then pri := nue   {el dato va al principio}
                  else  ant^.sig  := nue; {va entre otros dos o al final}
  nue^.sig := act ;
end;

procedure AgregarAlFinal2 (var pri, ult: lista; per: integer);
var
   nue : lista;

begin 
 new (nue);
 nue^.datos:= per;
 nue^.sig := NIL;
 if (pri <> Nil) then
                 ult^.sig := nue
               else 
                 pri := nue;
 ult := nue;
end;

Var
 L,l2,l3,ult : Lista;
 ale: integer;
Begin {prog. ppal}
      randomize;
      L:=nil;
      l2:=nil;
      l3:=nil;
      ale:= random(50);
      While (ale <>0) do Begin
            AgregarAdelante (L, ale);
            AgregarAlFinal2(l2,ult,ale);
            InsertarElemento(l3,ale);
            ale:= random(50);
      End;
      writeln('Lista 1: ');
      imprimir (l);
      writeln('Lista 2: ');
      imprimir (l2);
      writeln('Lista 3: ');
      imprimir (l3);
      readln(ale);
End.


End.
