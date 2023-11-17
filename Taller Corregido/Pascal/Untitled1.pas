program test;
const
  dimF = 150;
type
  vector = array[1..dimF] of real;
procedure cargarvector(var v:vector; var dimL:integer);
var
  num:real;
begin
  dimL:=0;
  writeln('ingrese un numero cara cargar en el vector:');
  readln(num);
  while(num <> 0) and (dimL <= dimF) do begin
    dimL:=dimL+1;
    v[dimL]:=num;
    writeln('ingrese un numero para cargar en el vector:');
    readln(num);
  end;
end;
var
   v : vector;
   dimL, i : integer;
begin
   cargarvector(v,dimL);
   for i:=1 to dimL do writeln(v[i]);
   readln;
end.
