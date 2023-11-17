program ejercicio1;
Uses sysutils;
type
  archivo_enteros = file of integer;
var
  ent : archivo_enteros;
  num : integer;
  nombre_archivo : String;
  i : integer;
begin
  write('Ingrese el nombre del archivo: ');
  readln(nombre_archivo);
  //assign(ent,'C:\Users\fer\Desktop\Primer Semestre 3ro\FOD\practicas\practica1\'+nombre_archivo+'.dat');
  assign(ent,nombre_archivo);
  rewrite(ent);
  write('Ingresar numero a cargar en el archivo: ');
  readln(num);
  while(num<>10000) do begin
    write(ent,num);
    write('Ingresar numero a cargar en el archivo: ');
    readln(num);
  end;
  close(ent);
end.
