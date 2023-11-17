program prueba;
type
    archivo_numeros = file of integer;
var
   arch: archivo_numeros; num, cant, numeros, cant_mayor: integer; nombre: String;
begin
   cant:= 0; cant_mayor:= 0; numeros:= 0;
   write('Escriba el nombre del archivo a procesar: ');
   readln(nombre);
   assign(arch, nombre);
   reset(arch);
   writeln('----------------------------------------------------------------------');
   writeln('Contenido del archivo:');
   while (not EOF (arch)) do begin
         read(arch, num);
         writeln(num);
         numeros:= numeros + num;
         cant:= cant + 1;
         if(num > 100000) then
                cant_mayor:= cant_mayor + 1;
   end;
   writeln('----------------------------------------------------------------------');
   writeln('El promedio de los numeros ingresados es: ', (numeros/cant) );
   writeln('La cantidad de numeros mayores a 100000 es: ', cant_mayor);
   close(arch);
   readln;
end.

