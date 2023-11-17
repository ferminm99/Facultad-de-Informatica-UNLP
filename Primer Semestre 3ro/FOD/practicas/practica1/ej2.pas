program ejercicio2;
type
  archivo_enteros = file of integer;
procedure ej2(var ent: archivo_enteros; var cant_menor: integer; var cant: integer);
var
   num: integer;
begin
     writeln('-----------------------');
     writeln('El contenido del archivo es: ');
     while (not eof(ent)) do begin
        read(ent,num);
        writeln(num);
        cant:=cant+num;
        if (num<1000) then
            cant_menor:= cant_menor + 1;
     end;
     cant:= cant div FileSize(ent);
     close(ent);
end;
procedure cargarNumeros(var ent: archivo_enteros);
var
   num: integer;
begin
     rewrite(ent);
     write('Ingresar numero a cargar en el archivo: ');
     readln(num);
     while (num<>10000) do begin
           write(ent,num);
           write('Ingresar numero a cargar en el archivo: ');
           readln(num);
     end;
     close(ent);
end;
var
  ent : archivo_enteros;
  nombre_archivo : String;
  cant_menor,cant : integer;
begin
  write('Ingrese el nombre del archivo: ');
  readln(nombre_archivo);
  Assign(ent,nombre_archivo);
  cargarNumeros(ent);
  reset(ent);
  cant_menor:=0;
  cant:=0;
  ej2(ent,cant_menor,cant);
  writeln('-----------------------');
  writeln('El promedio de los numeros ingresados es: ',cant);
  writeln('La cantidad de numeros mayores a 10000 es: ',cant_menor);
  readln();
end.
