program CalculoDePotencia;

Function potencia (x,n: integer): real;
begin
  if (n = 0) then 
    potencia:= 1
  else
    potencia := x * potencia(x,n-1);
end;

{PROGRAMA PRINCIPAL}

var
   x,n:integer;
begin
     read (x);
     read (n);
     writeln ('potencia de ', x ,' elevado a la ', n,' es ', potencia (x,n));
     readln;
     readln;
end.
