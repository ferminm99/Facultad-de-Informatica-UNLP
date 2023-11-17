program archivos;
type
    archivo_enteros = file of integer;
var
   arch: archivo_enteros; num: integer; nombre: String;
begin
     write('Ingrese el nombre del archivo a crear: ');
     readln(nombre);
     assign(arch, nombre);
     rewrite(arch);
     write('Ingrese un número: ');
     readln(num);
     while (num <> 0) do begin
           write(arch, num);
           write('Ingrese un número: ');
           readln(num);
     end;
     close(arch);
END.
