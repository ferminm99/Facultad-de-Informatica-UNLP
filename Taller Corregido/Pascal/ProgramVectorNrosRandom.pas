Program  ejemplo;
Const
     dimf = 10;
type
     rango = 1..dimf;
     vector = array [rango] of integer;

Procedure cargar ( var num: vector; var dimL: rango );
var
    dato : integer;
begin
   dimL := 0;
   dato:= random(50);
   while (dato <> 0)  and ( dimL < dimF ) do begin
          dimL := dimL + 1;
       num [dimL] := dato;
       dato:= random(50);
   end;
End;
procedure imprimir (v:vector;dml:rango);
var
   i:rango;
begin
     writeln('Nros almacenados: ');
     for i:= 1 to dml do
         write (v[i],' | ');
end;

var
   v:vector; dimL: rango;
Begin
     randomize;
     cargar(v,dimL);
     imprimir(v,dimL);
     readln();
End.
