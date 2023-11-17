program prueba;
type
    archivo_numeros = file of integer;
var
   arch: archivo_numeros; num: integer;
begin
   assign(arch, 'numeros');
   reset(arch);
   while (not EOF (arch)) do begin
         read(arch, num);
         writeln(num);
   end;
   readln;
end.

