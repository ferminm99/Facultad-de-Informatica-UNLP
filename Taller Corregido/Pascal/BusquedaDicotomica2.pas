program BusquedaDicotomica123;
type
    vector = array[1..20] of integer;
    indice = 1..20;
procedure CargarVector (var v : vector;var dimL : indice);
var
   n : integer;
begin
     Randomize;
     n := random(19);
     while (n <> 0) do begin
           dimL := dimL + 1;
           v[dimL] := n;
           n := random(19);
     end;
end;
procedure mostrarVector (v : vector; dimL : indice);
var
   i : integer;
begin
     for i:=1 to dimL do
         write(v[i],' | ');
end;
procedure ordenarVector (var v : vector; dimL : indice);
var
   i,j,actual : integer;
begin
     for i:=2 to dimL do begin
         actual := v[i];
         j:=i-1;
         while (j > 0) and (actual < v[j]) do begin
               v[j+1] := v[j];
               j:=j-1;
         end;
         v[j+1]:=actual;
     end;
end;
procedure busquedaDicotomica(v: vector; ini, fin: indice; dato: integer; var pos: indice);
begin
  if (ini > fin) then writeln('El numero ingresado no se encuentra en el vector')
  else begin
    pos := (ini + fin) div 2;
    if (v[pos] = dato) then writeln('El numero ingresado se encuentra en la posicion ', pos, ' del vector.')
    else begin
      if (dato < v[pos]) then begin
        fin := pos - 1;
      end
      else ini := pos + 1;
      busquedaDicotomica(v, ini, fin, dato, pos);
    end;
  end;
end;
var
   v : vector;
   dimL, i, p : indice;
   d : integer;
begin
     i := 1;
     CargarVector(v,dimL);
     ordenarVector(v,dimL);
     mostrarVector(v,dimL);
     writeln();
     writeln('Ingresar valor a buscar');
     readln(d);
     busquedaDicotomica(v,i,dimL,d,p);
     readln;
end.
