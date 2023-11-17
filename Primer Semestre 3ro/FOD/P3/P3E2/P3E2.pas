program a;
const
  valorImposible = 'zzzz';
Type

  fechaF = record
    dia: integer;
    mes: integer;
    anio: integer;
    end;

  empleado = record
    cod: integer;
    nombre: String;
    apellido: String;
    direccion: String;
    altura: integer;
    telefono: integer;
    DNI: integer;
    nacimiento: fechaF;
    end;

  arch_mae = file of empleado;

{--------------------------------------------------------------------------}
procedure leerRegistro(var r: empleado);
begin
  writeln('Ingrese el codigo del empleado');
  readln(r.cod);
  if (r.cod <> -1) then begin
    writeln('Ingrese el nombre del empleado');
    readln(r.nombre);
    writeln('Ingrese el apellido del empleado');
    readln(r.apellido);
    writeln('Ingrese la direccion del empleado');
    readln(r.direccion);
    writeln('Ingrese la altura de la direccion');
    readln(r.altura);
    writeln('Ingrese el telefono del empleado');
    readln(r.telefono);
    writeln('Ingrese el DNI del empleado');
    readln(r.DNI);
    writeln('Ingrese la fecha de nacimiento del empleado');
    readln(r.nacimiento.dia);
    write('/');
    readln(r.nacimiento.mes);
    write('/');
    readln(r.nacimiento.anio);
    end;
end;
{--------------------------------------------------------------------------}
procedure leerMaestro(var mae: arch_mae; var r: empleado);
begin
  if(not EOF(mae))then
    read(mae, r)
  else
    r.nombre:= valorImposible;
end;
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}

var
  opc: char; nomb: String; mae: arch_mae; r: empleado;
begin
  writeln('Ingrese una opción');
  writeln('A- Crear archivo de empleados');
  writeln('B- Eliminar empleados con DNI menor a 5 millones');
  readln(opc);
  case opc of
    'A', 'a': begin
      write('Ingrese el nombre del archivo a crear: ');
      readln(nomb);
      assign(mae, nomb);
      rewrite(mae);
      leerRegistro(r);
      while(r.cod <> -1) do begin
        write(mae, r);
        leerRegistro(r);
        end;
      writeln('Carga de empleados finalizada!');
      close(mae);
      end;
    'B', 'b': begin
      write('Ingrese el nombre del archivo a editar: ');
      readln(nomb);
      assign(mae, nomb);
      reset(mae);
      leerMaestro(mae, r);
      while (r.nombre <> valorImposible) do begin
        if (r.DNI < 5000000) then begin
          r.nombre:= '*' + r.nombre;
          seek(mae, filePos(mae) - 1);
          write(mae, r);
          end;
        leerMaestro(mae, r);
        end;
      close(mae);
      end;
    'C', 'c': begin
      write('Ingrese el nombre del archivo a imprimir: ');
      readln(nomb);
      assign(mae, nomb);
      reset(mae);
      leerMaestro(mae, r);
      while (r.nombre <> valorImposible) do begin
        writeln(r.nombre);
        leerMaestro(mae,r);
        end;
      end;
    end;
  readln;
end.
