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
procedure Leer(var arch : archivo_personas; var reg : persona);
begin
   if (not eof(arch))then read(arch,reg)
                     else reg.dni := 9999;
end;
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
  assign(txt,nombre_archivo+'listado.txt');
  reset(per);
  rewrite(txt);
  while(not eof(per)) do begin
    read(per,persona);
    With persona do WriteLn(txt,dni, ' ', edad,' ',nombre,' ',apellido);
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
  assign(txt,nombre_archivo+'.txt');
  reset(per);
  rewrite(txt);
  while(not eof(per)) do begin
    read(per,persona);
    if (persona.dni = 0) then With persona do WriteLn(txt,dni,' ', edad,' ',nombre,' ',apellido);
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
  assign(txt,nombre_archivo+'.txt');
  reset(txt); rewrite(per);
  while(not eof(txt)) do begin
     With persona do ReadLn(txt, dni, edad, nombre, apellido);
     write(per,persona);
  end;
  close(txt); close(per);
end;
procedure Reemplazar(var original, nuevo : archivo_personas);
var
  persona : persona;
begin
   rewrite (original); reset(nuevo);
   while(not eof(nuevo)) do begin
       read(nuevo,persona);
       write(original,persona);
   end;
   close(original); close(nuevo);
end;
procedure Borrar(var per : archivo_personas; nombre_archivo : String);
var
  ult_persona : persona;
  persona : persona;
  dni_eliminar : integer;
  new_personas : archivo_personas;
  encontrado: boolean;
begin
   encontrado := false;
   reset(per);
   //archivo auxiliar para cargar a todas las personas que se deben mantener
   assign(new_personas,nombre_archivo+'new.dat');
   rewrite(new_personas);
   if(not eof(per)) then begin
      seek(per, filesize(per)-1); // me posiciono en la ultima persona del archivo
      read(per, ult_persona); // leo la persona que va a reemplazar al borrado
   end;
   write('Ingrese dni de la persona a eliminar >:) : '); readln(dni_eliminar);

   //if(dni_eliminar > 9999999999) then begin writeln('se va a cerrar'); readln; end;

   reset(per); // vuelvo al inicio del archivo original

   Leer(per,persona);
   while (persona.dni <> 9999) do begin

     if (filepos(per) <> filesize(per)) then begin // si no estoy en la ultima posicion
         if (dni_eliminar = persona.dni) then begin// y si el dni es el que tengo que eliminar
            write(new_personas,ult_persona);   // escribo la ultima persona del archivo en esa posicion
            encontrado := true;
         end else
            write(new_personas,persona); // y si no escribo la persona que lei puesto que se debe mantener
     end else if (not encontrado) then begin
         writeln('no se encontro la persona con dni: ',dni_eliminar);
         write(new_personas,ult_persona);
     end;

     Leer(per,persona);
   end;
   // cierrro los archivos
   close(per); close(new_personas);
   //reescribo el archivo original con las nuevas personas
   Reemplazar(per,new_personas);
end;

var
  per : archivo_personas;
  nombre_archivo : String;
  eleccion : integer;
begin
  repeat
    writeln('###################################');writeln;
    writeln('1 - Crear archivo');
    writeln('2 - Abrir archivo');
    writeln('3 - Agregar personas');
    writeln('4 - Modificar edad');
    writeln('5 - exportar a txt');
    writeln('6 - exportar errores a txt');
    writeln('7 - Importar de txt');
    writeln('8 - Borrar');
    writeln('9 - Borrar todo');
    write('Ingresar eleccion: ');
    readln(eleccion);
    //write('Ingrese nombre del archivo: ');
    //readln(nombre_archivo);
    nombre_archivo := 'personas_ej4';
    assign(per,nombre_archivo+'.dat');

    writeln;
    case (eleccion) of
      1: CrearArchivo(per);
      2: AbrirArchivo(per);
      3: AgregarPersonas(per);
      4: ModificarEdad(per);
      5: ExportarTxt(per);
      6: ExportarErrores(per);
      7: ImportarTxT(per);
      8: Borrar(per,nombre_archivo);
      9: begin rewrite(per); close(per); end;
    end;
    writeln;
  until(eleccion = 10);
end.
