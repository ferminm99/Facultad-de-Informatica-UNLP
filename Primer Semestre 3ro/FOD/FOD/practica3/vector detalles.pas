program prueba;
uses Sysutils;
type
    vector_arch = array[1..5] of Text;
    vector_registros = array[1..5] of integer;
procedure Leer(var arch : Text; var reg : integer);
begin
   if (not eof(arch))then readln(arch,reg)
                     else reg := 9999;
end;
procedure Minimo(var V_arch : vector_arch; var V_reg : vector_registros; var min : integer);
var
  i : integer;
begin
   min := 9999;
   for i:=1 to 5 do begin
      if(V_reg[i]<min)then begin
           min := V_reg[i];
           Leer(V_arch[i],V_reg[i]);
      end;
   end;
end;
var
  i : integer;
  V_arch: vector_arch;
  V_reg : vector_registros;
  min : integer;
begin
  randomize;

  // asignacion
  for i:=1 to 5 do
      assign(V_arch[i],'C:\Users\Thugg\Desktop\Tercer Cuatrimestre\FOD\prueba\det'+IntToStr(i)+'.txt');

  // abrir todos los archivos
  for i:=1 to 5 do
      rewrite(V_arch[i]);

  //escribir, editar, etc
  for i:=1 to 5 do
     writeln(V_arch[i],random(100));

  for i:=1 to 5 do
    
      close(V_arch[i]);

  for i:=1 to 5 do
      reset(V_arch[i]);
  //leer de todos los archivos
  for i:=1 to 5 do
      Leer(V_arch[i],V_reg[i]);

  Minimo(V_arch,V_reg,min);
  //read(V_arch[1],min);
  writeln(min);
  // cerrar los archivos


  for i:=1 to 5 do  close(V_arch[i]);

  readln;
end.
