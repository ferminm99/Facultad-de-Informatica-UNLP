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
procedure AgregarPersonas(var per : archivo_personas);
var
  persona : persona;
begin
  reset(per);
  writeln('###################################');writeln;
  writeln('Agregar personas');
  seek(per, filesize(per));
  LeerPersona(persona);
  while(persona.apellido <> '') do begin
    write(per,persona);
    LeerPersona(persona);
  end;
  close(per);
end;
procedure ModificarEdad(var per : archivo_personas);
var
  persona : persona;
  dni : integer;
  encontrado : boolean;
begin
  reset(per);
  write('Ingresar DNI de la persona a modificar su edad: ');
  readln(dni);
  encontrado := false;
  while(not eof(per) and not encontrado)do begin
    read(per,persona);
    if(persona.dni = dni) then encontrado := true;
  end;
  if(encontrado)then begin
    seek(per,filepos(per)-1);
    write('Ingresar nueva edad: ');
    readln(persona.edad);
    write(per,persona);
  end else writeln('no se encontro la persona');
  close(per);
end;
procedure ExportarTxt(var per : archivo_personas);
var
  persona : persona;
  txt : text;
  nombre_archivo : String;
begin
  nombre_archivo := 'personas';
  assign(txt,'C:\Users\Thugg\Desktop\Tercer Cuatrimestre\FOD\practica1\'+nombre_archivo+'.txt');
  reset(per);
  rewrite(txt);
  while(not eof(per)) do begin
    read(per,persona);
    With persona do WriteLn(txt,dni,' ',nombre,' ',apellido,' ', edad);
  end;
  close(txt);
  close(per);
end;
procedure ExportarErrores(var per : archivo_personas);
var
  persona : persona;
  txt : text;
  nombre_archivo : String;
begin
  nombre_archivo := 'Errores';
  assign(txt,'C:\Users\Thugg\Desktop\Tercer Cuatrimestre\FOD\practica1\'+nombre_archivo+'.txt');
  reset(per);
  rewrite(txt);
  while(not eof(per)) do begin
    read(per,persona);
    if (persona.dni = 0) then With persona do WriteLn(txt,dni,' ',nombre,' ',apellido,' ', edad);
  end;
  close(txt);
  close(per);
end;
procedure ImportarTxT(var per : archivo_personas);
var
  txt : text;
  persona : persona;
  nombre_archivo : String;
begin
  nombre_archivo := 'personas';
  assign(txt,'C:\Users\Thugg\Desktop\Tercer Cuatrimestre\FOD\practica1\'+nombre_archivo+'.txt');
  reset(txt); rewrite(per);
  while(not eof(txt)) do begin
     with persona do readln(txt, dni, nombre, apellido, edad);
     write(per,persona);
  end;
  close(txt); close(per);
end;
var
  per : archivo_personas;
  nombre_archivo : String;
  eleccion : integer;
begin
  writeln('###################################');writeln;
  writeln('1 - Crear archivo');
  writeln('2 - Abrir archivo');
  writeln('3 - Agregar personas');
  writeln('4 - Modificar edad');
  writeln('5 - exportar a txt');
  writeln('6 - exportar errores a txt');
  writeln('7 - Importar de txt');
  write('Ingresar eleccion: ');
  readln(eleccion);
  //write('Ingrese nombre del archivo: ');
  //readln(nombre_archivo);
  nombre_archivo := 'personas_ej4';
  assign(per,'C:\Users\Thugg\Desktop\Tercer Cuatrimestre\FOD\practica1\'+nombre_archivo+'.dat');
  case (eleccion) of
    1: CrearArchivo(per);
    2: AbrirArchivo(per);
    3: AgregarPersonas(per);
    4: ModificarEdad(per);
    5: ExportarTxt(per);
    6: ExportarErrores(per);
    7: ImportarTxT(per);
  end;
  readln;
end.
