program prueba;
type
    archivo_numeros = file of integer;
var
   arch: archivo_numeros; num, cant_par, cant_mayor: integer; nombre: String;
begin
   cant_par:= 0; cant_mayor:= 0;
   write('Escriba el nombre del archivo a procesar: ');
   readln(nombre);
   assign(arch, nombre);
   reset(arch);
   writeln('----------------------------------------------------------------------');
   writeln('Contenido del archivo:');
   while (not EOF (arch)) do begin
         read(arch, num);
         writeln(num);
         if(num mod 2 = 0)then
                cant_par:= cant_par + 1;
         if(num > 100000) then
                cant_mayor:= cant_mayor + 1;
   end;
   writeln('----------------------------------------------------------------------');
   writeln('La cantidad de numeros pares es: ', cant_par);
   writeln('La cantidad de numeros mayores a 100000 es: ', cant_mayor);
   close(arch);
   readln;
end.

