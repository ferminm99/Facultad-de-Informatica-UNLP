program a;
const
 separador_registro:char='*';
 separador_campo: char = '|';
Type

  producto = record
    nombre: String;
    desc: String;
    SM: integer;
    SA: integer;
    end;

  arch = file;


//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------
procedure leerRegistro (var r: producto);
begin
  writeln('Ingrese el nombre del producto:');
  readln(r.nombre);
  if (r.nombre <> 'fin') then begin
    writeln('Ingrese la descripcion:');
    readln(r.desc);
    writeln('Ingrese el stock minimo:');
    readln(r.SM);
    writeln('Ingrese el stock actual:');
    readln(r.SA);
  end;
end;
//--------------------------------------------------------------------------------------------------
procedure crearArchivo(nombre: String);
var
  archivo: arch; r: producto; strNuevo: String;
begin
  assign(archivo, nombre);
  rewrite(archivo, 1);
  writeln('Nuevo Producto: ');
  leerRegistro(r);
  while(r.nombre <> 'fin')do begin
    r.nombre:= r.nombre + separador_campo;
    blockwrite(archivo, r.nombre[1], length(r.nombre));
    r.desc:= r.desc + separador_campo;
    blockwrite(archivo, r.desc[1], length(r.desc));
    str(r.SM, strNuevo);
    strNuevo:= strNuevo + separador_campo;
    blockwrite(archivo, strNuevo[1], length(strNuevo));
    str(r.SA, strNuevo);
    strNuevo:= strNuevo + separador_campo;
    blockwrite(archivo, strNuevo[1], length(strNuevo));
    blockwrite(archivo, separador_registro, 1); //Aca no deberia ser (..., separador_registro[1], ...) ?    
    writeln;
    writeln('Nuevo Producto: ');
    leerRegistro(r);
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
  campo: String; car: char; archivo: arch; N_reg: integer;
begin
  assign(archivo, nombre);
  reset(archivo, 1);
  car:= 'x';
  writeln('INFORMACION DEL REGISTRO');
  N_reg:= 1;
  while(not EOF(archivo))do begin
    campo:= '';
    blockread(archivo, car, 1);
    while ((car <> separador_registro) and (car <> separador_campo) and (not EOF(archivo))) do begin
      campo:= campo + car;
      blockread(archivo, car, 1);
    end;
    if ((car = separador_registro) and (not eof(archivo))) then begin
      writeln;
      writeln('INFORMACION DEL REGISTRO');
      blockread(archivo, car, 1);
      seek(archivo, filePos(archivo) - 1);
      N_reg:= 1;
      end
    else begin
      if(not EOF(archivo)) then begin
        case N_reg of
          1: write('  NOMBRE DEL PRODUCTO: ');
          2: write('  DESCRIPCION PRODUCTO: ');
          3: write('    STOCK MINIMO: ');
          4: write('    STOCK ACTUAL: ');
        end;
        writeln(campo);
        N_reg:= N_reg + 1;
      end;
    end;
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

