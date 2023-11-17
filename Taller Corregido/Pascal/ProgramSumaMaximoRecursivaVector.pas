program Arreglos;

const
    dimF = 8;  {Dimensión física del vector}

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
procedure maximo (v:vector;var max:integer;dimL:dim;i:integer);
begin
     if (i <= dimL) then begin
        if (v[i] > max) then
           max:= v[i];
        i:= i+1;
        maximo (v,max,dimL,i);
     end;
end;
function suma (v:vector;dimL:dim;i:integer):integer;
begin
     if ((i+1) = dimL) then
        suma:= v[i+1]
     else begin
        i:= i+1;
        suma:= v[i] + suma(v,dimL,i);
     end;
end;
{PROGRAMA PRINCIPAL}
var
   v: vector;
   dimL : dim;
   max,i:integer;
begin
     CargarVector(v,dimL);
     writeln('Nros almacenados: ');
     ImprimirVector(v, dimL);
     max:= -1;
     i:= 1;
     maximo(v,max,dimL,i);
     writeln (' numero maximo del vector: ', max);
     i:= 0;
     writeln ('la suma total de los numeros es: ', suma(v,dimL,i));
     readln;
end.
