program CalculoDigitoMaximoRec;
type digito=-1..9;

var num: integer;
    max: digito;

procedure digitoMaximoRec(n: integer; var max: digito);
var
  dig: integer;
begin
  if (n <> 0) then begin
                dig:= n mod 10;
                if (dig > max) then
                                max:= dig;
                n:= n div 10;
                digitoMaximoRec(n, max);
              end;
end;
procedure imprimirDigitos1 (num:integer);
var
   dig:integer;
begin
     if (num <> 0) then begin
        dig:= num mod 10;
        writeln (dig);
        num:= num div 10;
        imprimirDigitos1 (num);
     end;
end;
procedure imprimirDigitos2 (num:integer);
var
   dig:integer;
begin
     if (num <> 0) then begin
        dig:= num mod 10;
        num:= num div 10;
        imprimirDigitos2 (num);
        writeln (dig);
     end;
end;
begin
  writeln ('se ingresa un numero: ');
  read (num);
  max := -1;
  digitoMaximoRec(num, max);
  writeln ('El digito maximo de ', num, ' es: ', max);
  writeln ('numero en orden: ');
  imprimirDigitos1 (num);
  writeln ('numero al reves: ');
  imprimirDigitos2 (num);
  readln;
  readln;
end.

