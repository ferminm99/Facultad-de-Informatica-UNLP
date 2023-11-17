program P2R2;
const
  valorImposible = -1;
Type
  alumno = record
    cod: integer;
    apellido: String[50];
    nombre: String[50];
    CMC: integer;
    CMA: integer;
    end;

  detalle = record
    cod: integer;
    aprobo: String;
    end;

  arch_bin = file of alumno;
  arch_det = file of detalle;
  arch_tex = text;
{------------------------------------------------------------------------------------}
procedure leerMaestro (var mae: arch_bin; var r: alumno);
begin
  if (not EOF(mae)) then
    read(mae, r)
  else
    r.cod:= valorImposible;
end;
procedure leerDetalle (var det: arch_det; var r: detalle);
begin
  if (not EOF(det)) then
    read(det, r)
  else
    r.cod:= valorImposible;
end;
{------------------------------------------------------------------------------------}
{a. Crear el archivo maestro a partir de un archivo de texto llamado “alumnos.txt”.}
procedure crearBinarioMDesdeTexto(var mae: arch_bin; var texto: arch_tex);
var
  r: alumno;
begin
  while(not EOF(texto)) do begin
    readln(texto, r.cod);
    readln(texto, r.apellido);
    readln(texto, r.nombre);
    readln(texto, r.CMC);
    readln(texto, r.CMA);
    write(mae, r);
    end;
end;
{------------------------------------------------------------------------------------}
{b. Crear el archivo detalle a partir de en un archivo de texto llamado “detalle.txt”.}
procedure crearBinarioDDesdeTexto(var det: arch_det; var texto: arch_tex);
var
  r: detalle;
begin
  while(not EOF(texto)) do begin
    readln(texto, r.cod);
    readln(texto, r.aprobo);
    write(det, r);
    end;
end;
{------------------------------------------------------------------------------------}
{c. Listar el contenido del archivo maestro en un archivo de texto llamado “reporteAlumnos.txt”.}
procedure imprimirMaestro(var mae: arch_bin; var texto: arch_tex);
var
  r: alumno;
begin
  while (not EOF (mae)) do begin
    read(mae, r);
    writeln(texto, r.cod);
    writeln(texto, r.apellido);
    writeln(texto, r.nombre);
    writeln(texto, r.CMC);
    writeln(texto, r.CMA);
    end;
end;
{------------------------------------------------------------------------------------}
{d. Listar el contenido del archivo detalle en un archivo de texto llamado “reporteDetalle.txt”.}
procedure imprimirDetalle(var det: arch_det; var texto: arch_tex);
var
  r: detalle;
begin
  while (not EOF (det)) do begin
    read(det, r);
    writeln(texto, r.cod);
    writeln(texto, r.aprobo);
    end;
end;
{------------------------------------------------------------------------------------}
{e. Actualizar el archivo maestro}
procedure actualizarMaestro(var mae: arch_bin; var det: arch_det);
var
  a: alumno; d: detalle; codActual: integer; cursadas: integer; finales: integer;
begin
  leerDetalle(det, d);
  leerMaestro(mae, a);
  while(d.cod <> valorImposible) do begin
    codActual:= d.cod;
    cursadas:= 0;
    finales:= 0;
    while (a.cod <> codActual) do
      leerMaestro(mae, a);
    while (d.cod = codActual) do begin
      if(d.aprobo = 'Cursada') then begin
        writeln(d.aprobo);
        cursadas:= cursadas + 1;
        writeln('Cursadas acumuladas: ', cursadas);
        end
      else
        finales:= finales + 1;
      leerDetalle(det, d);
      end;
    a.CMA:= a.CMA + finales;
    a.CMC:= a.CMC + cursadas;
    seek(mae, filePos(mae)-1);
    write(mae, a);
    end;
end;
{------------------------------------------------------------------------------------}
{f. Listar en un archivo de texto los alumnos que tengan más de cuatro materias con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.}
procedure listarMaestroConCondiciones(var mae: arch_bin; var texto: arch_tex);
var
  r: alumno;
begin
  while (not EOF (mae)) do begin
    read(mae, r);
    if ((r.CMC - r.CMA) >= 4) then begin
      writeln(texto, r.cod);
      writeln(texto, r.apellido);
      writeln(texto, r.nombre);
      writeln(texto, r.CMC);
      writeln(texto, r.CMA);
      end;
    end;
end;
{------------------------------------------------------------------------------------}
var
  opc: char; nombre: String; mae: arch_bin; det: arch_det; texto: arch_tex;
begin
writeln('Eliga una opcion:');
writeln('a. Crear el archivo maestro a partir de un archivo de texto llamado alumnos.txt.');
writeln('b. Crear el archivo detalle a partir de en un archivo de texto llamado detalle.txt.');
writeln('c. Listar el contenido del archivo maestro en un archivo de texto llamado reporteAlumnos.txt.');
writeln('d. Listar el contenido del archivo detalle en un archivo de texto llamado reporteDetalle.txt.');
writeln('e. Actualizar el archivo maestro de la siguiente manera:');
writeln('  i. Si aprobo el final se incrementa en uno la cantidad de materias con final aprobado.');
writeln('  ii. Si aprobo la cursada se incrementa en uno la cantidad de materias aprobadas sin final.');
writeln('f. Listar en un archivo de texto los alumnos que tengan más de cuatro materias con cursada aprobada pero no aprobaron el final. Deben listarse todos los campos.');
readln(opc);
case opc of

  'a': begin
  write('Ingrese el nombre del archivo maestro a crear: ');
  readln(nombre);
  assign(mae, nombre);
  rewrite(mae);
  assign(texto, 'alumnos.txt');
  reset(texto);
  crearBinarioMDesdeTexto(mae, texto);
  close(mae);
  close(texto);
  end;

  'b': begin
  write('Ingrese el nombre del archivo detalle a crear: ');
  readln(nombre);
  assign(det, nombre);
  rewrite(det);
  assign(texto, 'detalle.txt');
  reset(texto);
  crearBinarioDDesdeTexto(det, texto);
  close(det);
  close(texto);
  end;

  'c': begin
  write('Ingrese el nombre del archivo maestro a listar en "reporteAlumnos.txt": ');
  readln(nombre);
  assign(mae, nombre);
  reset(mae);
  assign(texto, 'reporteAlumnos.txt');
  rewrite(texto);
  imprimirMaestro(mae, texto);
  close(mae);
  close(texto);
  end;

  'd': begin
  write('Ingrese el nombre del archivo detalle a listar en "reporteDetalle: ');
  readln(nombre);
  assign(det, nombre);
  reset(det);
  assign(texto, 'reporteDetalle.txt');
  rewrite(texto);
  imprimirDetalle(det, texto);
  close(det);
  close(texto);
  end;

  'e': begin
  write('Ingrese el nombre del archivo maestro a actualizar: ');
  readln(nombre);
  assign(mae, nombre);
  reset(mae);
  write('Ingrese el nombre del archivo detalle con el que se quiere actualizar: ');
  readln(nombre);
  assign(det, nombre);
  reset(det);
  actualizarMaestro(mae, det);
  close(mae);
  close(det);
  end;

  'f': begin
  write('Ingrese el nombre del archivo maestro que se quiere analizar: ');
  readln(nombre);
  assign(mae, nombre);
  reset(mae);
  write('Ingrese el nombre del archivo de texto en el cual escribir los resultados: ');
  readln(nombre);
  assign(texto, nombre);
  rewrite(texto);
  listarMaestroConCondiciones(mae, texto);
  close(mae);
  close(texto);
  end;
end;
readln;
end.

