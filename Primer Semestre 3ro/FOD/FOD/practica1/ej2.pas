program prueba;
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
  assign(ent,'C:\Users\Thugg\Desktop\Tercer Cuatrimestre\FOD\practica1\'+nombre_archivo+'.dat');
  reset(ent);
  write('numeros multiplos de 2: ');
  read(ent,num);
  while(not eof(ent))do begin
    if(num mod 2 = 0)then
      write(num,'-');
    read(ent,num);
  end;
  close(ent);
  readln;
end.
