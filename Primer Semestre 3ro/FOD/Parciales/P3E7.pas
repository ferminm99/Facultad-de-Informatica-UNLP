//7. Realizar un programa con opciones para: 
//   a. Crear un archivo de nombres de personas. 
//   b. Abrir un archivo existente para listar su contenido en pantalla. 
//Para la creación, los nombres se ingresan desde teclado, y la carga finaliza con un
//nombre igual a nulo,elcualnoseincorporaalarchivo.Losregistrossealmacenancon                                
//longitud variable. Los nombres deben incorporarse al archivo separandolos con el                      
//caracter ‘@’.

program a;
const
 separador_registro:char='#';
Type
  arch = file;


//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
procedure crearArchivo(nombre: String);
var
  archivo: arch; nomb: String;
begin
  assign(archivo, nombre);
  rewrite(archivo, 1);
  write('Ingrese el nombre a cargar: ');
  readln(nomb);
  while(nomb <> '')do begin
    nomb:= nomb + separador_registro;
    blockwrite(archivo, nomb[1], length(nomb));
    write('Ingrese el nombre a cargar: ');
    readln(nomb);
  end;
  writeln('Archivo cargado!');
  close(archivo);
end;
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
procedure leerArchivo (nombre: String);
var
  campo: String; car: char; archivo: arch;
begin
  assign(archivo, nombre);
  reset(archivo, 1);
  car:= 'x';
  while(not EOF(archivo))do begin
    campo:= '';
    blockread(archivo, car, 1);
    while(car <> separador_registro) and (not EOF(archivo)) do begin
      campo:= campo + car;
      blockread(archivo, car, 1);
    end;
    writeln(campo);
    writeln('---');
  end;
  close(archivo);
end;
//--------------------------------------------------------------------------------------------------








//PROGRAMA PRINCIPAL
var
  opc: char; nomb: string;

begin
  writeln('Ingrese una opcion o cualquier otro caracter para salir: ');
  writeln('a. Crear un archivo de nombres de personas.');
  writeln('b. Abrir un archivo existente para listar su contenido en pantalla.');
  readln(opc);
  case opc of
    'A', 'a':
      begin
        write('Ingrese el nombre del archivo a crear: ');
        readln(nomb);
        writeln;
        crearArchivo(nomb);
      end;

    'B', 'b':
      begin
        write('Ingrese el nombre del archivo a leer: ');
        readln(nomb);
        writeln;
        leerArchivo(nomb);
      end;
    end;
  readln;
end.

