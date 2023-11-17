program prueba;
Uses sysutils;
type
  persona = record
    dni : integer;
    nombre : String;
    apellido : String;
    edad : integer;
  end;
  archivo_personas = file of persona;
procedure LeerPersona(var per : persona);
begin
  write('Ingrese el apellido de la persona: ');
  readln(per.apellido);
  if(per.apellido<>'')then begin
    write('Ingrese nombre de la persona: ');
    readln(per.nombre);
    write('Ingrese dni de la persona: ');
    readln(per.dni);
    write('Ingrese edad de la persona: ');
    readln(per.edad);
  end;
end;
procedure CrearArchivo(var per : archivo_personas);
var
  per_reg : persona;
begin
  rewrite(per);
  writeln('###################################');writeln;
  writeln('Carga de personas');
  LeerPersona(per_reg);
  while(per_reg.apellido <> '') do begin
    write(per,per_reg);
    LeerPersona(per_reg);
  end;
  close(per);
end;
procedure ImprimirPersona(per : persona);
begin
   writeln('## ',per.apellido,' ',per.nombre,' ',per.edad,' anios ',' dni ',per.dni,' ##');
   {writeln('Apellido: ',per.apellido);}
   {writeln('Nombre: ',per.nombre);}
   {writeln('DNI: ',per.dni);    }
   {writeln('Edad: ',per.edad); }
end;
procedure AbrirArchivo(var per : archivo_personas);
var
  persona : persona;
begin
  reset(per);
  writeln('##################### personas #####################');
  while(not eof(per)) do begin
    read(per,persona);
    ImprimirPersona(persona);
  end;
  writeln('####################################################');
  close(per);
end;
var
  per : archivo_personas;
  nombre_archivo : String;
  eleccion : integer;
begin
  writeln('###################################');writeln;
  writeln('1 - Crear archivo');
  writeln('1 - Abrir archivo');
  write('Ingresar eleccion: ');
  readln(eleccion);
  write('Ingrese nombre del archivo: ');
  readln(nombre_archivo);
  assign(per,'C:\Users\Thugg\Desktop\Tercer Cuatrimestre\FOD\practica1\'+nombre_archivo+'.dat');
  case (eleccion) of
    1: CrearArchivo(per);
    2: AbrirArchivo(per);
  end;
  readln;
end.
