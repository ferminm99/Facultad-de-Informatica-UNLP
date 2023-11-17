
program a;
Type

  empleado = record
    cod: integer;
    DNI: String;
    apellido: String;
    nombre: String;
    peso: real;
    estatura: real;
    //fNac: longInt;
  end;

  arch = file;


//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
procedure agregarRegistro (var archivo: arch; r: empleado);
var
  tam: byte;
begin
  tam:= sizeOf(r.cod) + length(r.DNI) + length(r.apellido) + length(r.nombre) + 3 + sizeOf(r.peso) + sizeOf(r.estatura); //tamaño registro
  blockwrite(archivo, tam, sizeOf(tam));
  blockwrite(archivo, r.cod, sizeOf(r.cod));
  tam:= length(r.DNI) + 1;  //  + 1
  //blockwrite(archivo, tam, sizeOf(tam));
  blockwrite(archivo, r.DNI, tam);         //tam)
  tam:= length(r.apellido) + 1;  //  + 1
  //blockwrite(archivo, tam, sizeOf(tam));
  blockwrite(archivo, r.apellido, tam); //tam)
  tam:= length(r.nombre) + 1;   //  + 1
  //blockwrite(archivo, tam, sizeOf(tam));
  blockwrite(archivo, r.nombre, tam);        //tam)
  blockwrite(archivo, r.peso, sizeOf(r.peso));
  blockwrite(archivo, r.estatura, sizeOf(r.estatura));
  //blockwrite(archivo, r.fNac, sizeOf(r.fNac));
end;
//--------------------------------------------------------------------------------------------------
procedure leerRegistro (var r: empleado);
begin
  writeln('Ingrese el codigo del empleado o -1 para terminar la lectura: ');
  readln(r.cod);
  if (r.cod <> -1) then begin
    writeln('Ingrese el DNI: ');
    readln(r.DNI);
    writeln('Ingrese el apellido: ');
    readln(r.apellido);
    writeln('Ingrese el nombre: ');
    readln(r.nombre);
    writeln('Ingrese el peso: ');
    readln(r.peso);
    writeln('Ingrese la estatura: ');
    readln(r.estatura);
    //writeln('Ingrese la fecha de nacimiento en formate ddmmaaaa: ');
    //readln(r.fNac);
    writeln;
  end;
end;
//--------------------------------------------------------------------------------------------------
procedure crearArchivo(path: String);
var
  archivo: arch; r: empleado;
begin
  assign(archivo, path);
  rewrite(archivo, 1);
  leerRegistro(r);
  while(r.cod <> -1) do begin
    agregarRegistro(archivo, r);
    leerRegistro(r);
  end;
  writeln('Archivo cargado!');
  close(archivo);
end;
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
procedure leerRegistroArchivo (var archivo: arch; var r: empleado);
var
  tamReg, tamCam, i: byte;
  dato: array [1..256] of byte;
begin
  blockread(archivo, tamReg, 1);
  writeln('Tamanio: ', tamReg);
  blockread(archivo, dato, tamReg);

  i:= 1;
  move(dato[i], r.cod, sizeOf(r.cod));

  i:= i + sizeOf(r.cod);
  tamCam:= dato[i];
  SetLength(r.DNI, tamCam); // tamCam)
  i:= i + 1;
  //move(dato[i], r.DNI[0], sizeOf(tamCam));
  //i:= i + sizeOf(tamCam);
  move(dato[i], r.DNI[1], tamCam);    // + 1

  i:= i + tamCam;
  tamCam:= dato[i];
  SetLength(r.apellido, tamCam);
  i:= i + 1;
  //move(dato[i], r.apellido[0], sizeOf(tamCam));
  //i:= i + sizeOf(tamCam);
  move(dato[i], r.apellido[1], tamCam);

  i:= i + tamCam;
  tamCam:= dato[i];
  SetLength(r.nombre, tamCam);
  i:= i + 1;
  //move(dato[i], r.nombre[0], sizeOf(tamCam));
  //i:= i + sizeOf(tamCam);
  move(dato[i], r.nombre[1], tamCam);

  i:= i + tamCam;
  move(dato[i], r.peso, sizeOf(r.peso));

  i:= i + sizeOf(r.peso);
  move(dato[i], r.estatura, sizeOf(r.estatura));

  //i:= i + sizeOf(r.estatura);
  //move(dato[i], r.fNac, sizeOf(r.fNac));
end;
//--------------------------------------------------------------------------------------------------
procedure leerArchivo (path: String);
var
  r: empleado; archivo: arch;
begin
  assign(archivo, path);
  reset(archivo, 1);
  while(not EOF(archivo))do begin
    writeln('Nuevo empleado: ');
    leerRegistroArchivo(archivo, r);
    write('Codigo: ');
    writeln(r.cod);
    readln;
    write('DNI: ');
    writeln(r.DNI);
    readln;
    write('Apellido: ');
    writeln(r.apellido);
    readln;
    write('Nombre: ');
    writeln(r.nombre);
    readln;
    write('Peso: ');
    writeln(r.peso:0:2);
    readln;
    write('Estatura: ');
    writeln(r.estatura:0:2);
    readln;
    //write('Fecha de nacimiento (formato ddmmaaaa): ');
    //writeln(r.fNac);
    //readln;
    writeln;
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

