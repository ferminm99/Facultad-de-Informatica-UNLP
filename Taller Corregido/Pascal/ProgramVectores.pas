program Arreglos;

const
    dimF = 8;  {Dimensi�n f�sica del vector}

type

    vector = array [1..dimF] of LongInt;

    dim = 0..dimF;


{-----------------------------------------------------------------------------
CARGARVECTOR - Carga nros aleatorios entre 0 y 100 en el vector hasta que
llegue el nro 99 o hasta que se complete el vector}
Procedure CargarVector ( var vec: vector; var dimL: dim);
var
   d: integer;
begin
     Randomize;  { Inicializa la secuencia de random a partir de una semilla}
     dimL := 0;
     d:= random(100);
     while (d <> 99)  and ( dimL < dimF ) do begin
           dimL := dimL + 1;
           vec[dimL] := d;
           d:= random(100);
     end;
End;



{-----------------------------------------------------------------------------
IMPRIMIRVECTOR - Imprime todos los nros del vector }
Procedure ImprimirVector ( var vec: vector;  dimL: dim );
var
   i: dim;
begin
     for i:= 1 to dimL do
         write ('-----');
     writeln;
     write (' ');
     for i:= 1 to dimL do begin
        if(vec[i] < 9)then
            write ('0');
        write(vec[i], ' | ');
     end;
     writeln;
     for i:= 1 to dimL do
         write ('-----');
     writeln;
     writeln;
End;
procedure Ordenar (var v: vector; n: dim);
var
   i,j,num:integer;
begin
     for i:=2 to n do begin
         num:= v[i];
         j:= i-1;
         while (j > 0) and (v[j] > num) do begin
                  v[j+1]:= v[j];
                  j:= j - 1;
         end;
         v[j+1]:=num;
     end;
end;
{PROGRAMA PRINCIPAL}
var
   v: vector;
   dimL : dim;

begin
     CargarVector(v,dimL);
     writeln('Nros almacenados: ');
     ImprimirVector(v, dimL);
     ordenar (v,dimL);
     ImprimirVector(v, dimL);
     readln;
end.
