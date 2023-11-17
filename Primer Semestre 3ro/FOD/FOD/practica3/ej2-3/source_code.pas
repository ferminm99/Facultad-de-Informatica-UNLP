program prueba;
Uses sysutils;
const
   ruta = 'C:\Users\Thugg\Desktop\Tercer Cuatrimestre\FOD\practica3\ej2-3\';
type
  persona = record
    dni : integer;
    nombre : String;
    apellido : String;
    edad : integer;
  end;
  persona_list = record
    nrr : integer;
    dni : integer;
    nombre : String;
    apellido : String;
    edad : integer;
  end;

  tTitulo = String[50];
  tArchLibros = file of tTitulo ;

  archivo_personas = file of persona;
  archivo_personas_list = file of persona_list;
Function IntToStr (I : Longint) : String;

Var S : String;

begin
 Str (I,S);
 IntToStr:=S;
end;
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
  assign(txt,ruta+nombre_archivo+'listado.txt');
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
  assign(txt,ruta+nombre_archivo+'.txt');
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
  assign(txt,ruta+nombre_archivo+'.txt');
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
   assign(new_personas,ruta+nombre_archivo+'new.dat');
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

////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////// MODULOS PARA LA LISTA INVERTIDA //////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

procedure LeerPersona_list(var per : persona_list);
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
    per.nrr := 0;
  end;
end;
procedure Creacion_listaInvertida(var per : archivo_personas_list);
var
  per_reg : persona_list;
begin
  rewrite(per);
  writeln('###################################');writeln;
  // cargo primero el registro cabecera
  per_reg.nombre := '******'; per_reg.apellido := '******'; per_reg.dni := -1; per_reg.edad := -1;
  per_reg.nrr := 0;
  write(per,per_reg);
  // empiezo la carga por teclado
  writeln('Carga de personas');
  LeerPersona_list(per_reg);
  while(per_reg.apellido <> '') do begin
    write(per,per_reg);
    LeerPersona_list(per_reg);
  end;
  close(per);
end;

procedure Export_list_txt(var per : archivo_personas_list);
var
  persona : persona_list;
  txt : text;
  nombre_archivo : String;
begin
  nombre_archivo := 'personas';
  assign(txt,ruta+nombre_archivo+'list_inv.txt');
  reset(per);
  rewrite(txt);
  while(not eof(per)) do begin
    read(per,persona);
    With persona do WriteLn(txt,nrr,' ',dni, ' ', edad,' ',apellido,' ',nombre);
    //With persona do WriteLn(txt,nrr,dni,edad,nombre,apellido);
  end;
  close(txt);
  close(per);
end;

procedure ImportarTxT_list(var per : archivo_personas_list);
var
  txt : text;
  persona : persona_list;
  nombre_archivo : String;
begin
  nombre_archivo := 'personas';
  assign(txt,ruta+nombre_archivo+'list_inv.txt');
  reset(txt); rewrite(per);
  while(not eof(txt)) do begin
     With persona do ReadLn(txt, nrr, dni, edad, nombre, apellido);
     write(per,persona);
  end;
  close(txt); close(per);
end;

procedure ImprimirPersona_list(per : persona_list);
begin
   writeln('## ',per.nrr,' ',per.apellido,' ',per.nombre,' ',per.edad,' anios ',' dni ',per.dni,' ##');
end;


procedure AbrirArchivo_list(var per : archivo_personas_list);
var
  persona : persona_list;
begin
  reset(per);
  writeln('##################### personas #####################');
  while(not eof(per)) do begin
    read(per,persona);
    ImprimirPersona_list(persona);
  end;
  writeln('####################################################');
  close(per);
end;

procedure BorradoLogico(var per : archivo_personas_list);
var
  dni_eliminar : integer;
  persona : persona_list;
  posicion_eliminado : integer;
  primera_posicion : integer;
  eliminado : boolean;
begin

   reset(per);
   // me fijo que el archivo no este vacio
   if (eof(per)) then
      writeln('El archivo esta vacio')
   else begin
      read(per,persona);

      primera_posicion := persona.nrr; // guardo el valor que esta en la cabecera

      eliminado := false;

      write('Ingrese dni a eliminar: '); readln(dni_eliminar);

      while(not eof(per))and (not eliminado) do begin  //recorro el archivo hasta encontrar a la persona a eliminar o hasta que se termine
        read(per,persona);
        if (persona.apellido <> '******') and  (persona.dni = dni_eliminar) then begin // si la persona no se elimino antes

           write('Se eliminara a la persona: ');
           ImprimirPersona_list(persona);
           persona.apellido := '******';   // marco el apellido de la persona como eliminado
           seek(per,filepos(per)-1);
           posicion_eliminado := filepos(per)*-1; // guardo la posicion de la persona eliminada
           persona.nrr := primera_posicion;   // cargo la posicion de la cabecera en la persona que se acaba de eliminar
           write(per,persona);

           eliminado := true;   // seteo que encontre y elimine la persona

           //actualizo el valor de la cabecera
           seek(per,0);
           read(per,persona);
           persona.nrr := posicion_eliminado;
           seek(per,filepos(per)-1);
           write(per,persona);

         end else if (persona.dni = dni_eliminar) then writeln('la persona no existe');


      end;
   end;

   close(per);
end;
procedure Agregar_list(var per : archivo_personas_list);
var
  cabecera : persona_list;
  persona : persona_list;
  new_persona : persona_list;
begin
   reset(per);
   //writeln('agregar a lista');
   read(per,cabecera); // leo el registro cabecera
   LeerPersona_list(new_persona); // leo la persona a agregar
   if(cabecera.nrr = 0) then
      seek(per,filesize(per)) // si no hay espacio en el medio se agrega al final
   else begin
      seek(per,cabecera.nrr*-1);  // voy a la posicion indicada en la cabecera
      read(per,persona);      // leo la persona que sera reemplazada
      seek(per,filepos(per)-1); // me reposiciono para reescribir
      cabecera.nrr := persona.nrr;  // guardo el nrr que tenia ya que sera el nuevo nrr de la cabecera
   end;
   write(per,new_persona);
   // actualizo la cabecera
   seek(per,0);
   write(per,cabecera);
   close(per);
end;

procedure ej4_Abrir(var arch : tArchLibros);
var titulo : tTitulo;
begin
  reset(arch);
  while(not eof(arch)) do begin
     read(arch,titulo);
     writeln(titulo);
  end;
  close(arch);
end;

procedure ej4_Crear(var arch : tArchLibros);
var
  titulo : tTitulo;
begin
  rewrite(arch);
  titulo := '0';
  write(arch,titulo);
  write('Ingresar un nuevo titulo: '); readln(titulo);
  while(titulo <>'zz')do begin
     write(arch,titulo);
     write('Ingresar un nuevo titulo: '); readln(titulo);
  end;
  close(arch);
end;
procedure ej4_Eliminar(var arch : tArchLibros);
var
  titulo_eliminar : tTitulo;
  posicion_eliminado : integer;
  primera_posicion : tTitulo;
  eliminado : boolean;
  titulo : tTitulo;
begin
   reset(arch);
   // me fijo que el archivo no este vacio
   if (eof(arch)) then
      writeln('El archivo esta vacio')
   else begin

      read(arch,titulo);
      primera_posicion := titulo; // guardo el valor que esta en la cabecera
      eliminado := false;

      write('Ingrese el titulo a eliminar: '); readln(titulo_eliminar);
      while(not eof(arch))and (not eliminado) do begin  //recorro el archivo hasta encontrar a la persona a eliminar o hasta que se termine
        //writeln('probando');
        read(arch,titulo);
        if (titulo[1] <> '-') and (titulo = titulo_eliminar) then begin // si la persona no se elimino antes
           seek(arch,filepos(arch)-1);
           posicion_eliminado := filepos(arch)*-1; // guardo la posicion de la persona eliminada y convertir en string
           write(arch,primera_posicion);
           eliminado := true;   // seteo que encontre y elimine la persona
           //actualizo el valor de la cabecera
           seek(arch,0);
           titulo := IntToStr(posicion_eliminado);
           write(arch,titulo);
         end;
      end;

   end;
   close(arch);
end;
procedure prueba2;
var
  str : tTitulo;
begin
    str := IntToStr(1);
    writeln(str[1]);

end;
procedure ej4_Listar(var arch : tArchLibros);
var
  titulo : tTitulo;
begin
  reset(arch);
  while(not eof(arch)) do begin
     read(arch,titulo);
     if(titulo[1]<>'-')and(titulo[1]<>'0') then writeln(titulo);
  end;
  close(arch);
end;

procedure ej4_Agregar(var arch : tArchLibros);
var
  nuevo_titulo : tTitulo;
  eliminado : tTitulo;
  val_cabecera: Integer;
  val_eliminado: Integer;
  posicion: tTitulo;
begin

   reset(arch);
   val_eliminado := 0;
   write('Ingrese el nuevo titulo: '); readln(nuevo_titulo);
   read(arch,posicion);
   Val(posicion, val_cabecera);val_cabecera := val_cabecera *-1;
   if(val_cabecera <> 0) then begin
      seek(arch,val_cabecera);
      read(arch,posicion);
      Val(posicion, val_eliminado);
      seek(arch,filepos(arch)-1);
   end else seek(arch,filesize(arch));
   write(arch,nuevo_titulo);
   seek(arch,0);
   eliminado := IntToStr(val_eliminado);
   write(arch,eliminado);
   close(arch);

end;

var
  arch_titulos : tArchLibros;
  per : archivo_personas;
  per_list : archivo_personas_list;
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
    writeln('10 - Creacion con lista invertida');
    writeln('11 - Exportar de lista invertida a txt');
    writeln('12 - Importar de lista invertida a txt');
    writeln('13 - abrir archivo de lista invertida');
    writeln('14 - borrado logico');
    writeln('15 - agregar a lista invertida');
    writeln('16 - ej 4_Crear');
    writeln('17 - ej 4_Abrir');
    writeln('18 - ej 4_Eliminar');
    writeln('19 - ej 4_Listar registros');
    writeln('20 - ej 4_Agregar registros');
    write('Ingresar eleccion: ');
    readln(eleccion);
    //write('Ingrese nombre del archivo: ');
    //readln(nombre_archivo);
    nombre_archivo := 'personas_ej4';

    if(eleccion >= 10)then begin
         if(eleccion >= 16) then begin
           nombre_archivo := 'ej4_binario';
           assign(arch_titulos,ruta+nombre_archivo+'.dat');
         end else begin
           nombre_archivo := 'personas_list - backup - copia';
           assign(per_list,ruta+nombre_archivo+'.dat');
         end;
    end else assign(per,ruta+nombre_archivo+'.dat');

    writeln('###################################');writeln;

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
      10: Creacion_listaInvertida(per_list);
      11: Export_list_txt(per_list);
      12: ImportarTxT_list(per_list);
      13: AbrirArchivo_list(per_list);
      14: BorradoLogico(per_list);
      15: Agregar_list(per_list);
      16: ej4_Crear(arch_titulos);
      17: ej4_Abrir(arch_titulos);
      18: ej4_Eliminar(arch_titulos);
      19: ej4_Listar(arch_titulos);
      20: ej4_Agregar(arch_titulos);
      99: prueba2;
    end;


    writeln;
  until(eleccion = 77);
end.
