program BusquedaDicotomic;
uses crt;
Const
     dimF = 50;
Type
    vector = array [1..dimF] of integer;
procedure OrdenarVector(var v: vector);
var
   i, j, aux: integer;
begin
     for i := 2 to dimF do begin
         aux := v[i];
         j := i-1;
         while ((j>0) and (v[j] > aux))do begin
             v[j+1] := v[j];
             j := j-1;
         end;
         v[j+1] := aux;
     end;
end;
procedure GenerarVector(var v: vector);
var
   i: integer;
begin
     Randomize;
     for i := 1 to dimF do
         v[i] := random(dimF+1);
end;
procedure CrearOrdenadoV (var v:vector);
begin
     GenerarVector (v);
     OrdenarVector (v);
end;
procedure MostrarV (v:vector);
var
   i:integer;
begin
     for i:= 1 to dimF do
         writeln (v[i]);
end;
procedure BusquedaDicotomica (v:vector; ini,fin,num:integer; var med:integer);
begin
     if (ini > fin)then
        writeln ('el numero a buscar en el vector no se encontró')
     else begin
          med:= (ini + fin) div 2;
          if (v[med] = num) then
             writeln ('el numero se encuentra en la pos', med)
          else begin
              if (num < v[med]) then
                 fin:= med -1
              else
                  ini:= med +1;
              BusquedaDicotomica (v,ini,fin,num,med);
          end;
     end;
end;

Var
   v:vector; num,ini,med,fin:integer;
begin
     CrearOrdenadoV (v);
     MostrarV (v);
     writeln ('se ingresa un numero a buscar en el vector: ');
     read (num);
     ini:= 1;
     fin:= dimF;
     BusquedaDicotomica (v,ini,fin,num,med);
     readkey;
end.


