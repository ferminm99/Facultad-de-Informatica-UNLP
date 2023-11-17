program x;
const
Type
  novela = record
    cod: integer;
    nomb: string;
    end;

  rArch = record
    novela: novela;
    enlace: integer;
    end;

  arch_mae = file of rArch;


{------------------------------------------------}
{------------------------------------------------}
{------------------------------------------------}
{------------------------------------------------}
{------------------------------------------------}

var
  opc: char; nombre: string; mae: arch_mae;
begin
  writeln('Ingrese una opcion: ');
  writeln('A- Crear el archivo');
  writeln('B- Dar de alta una novela');
  writeln('C- Modificar los datos de una novela');
  writeln('D- Eliminar una novela');
  writeln('E- Listar en un archivo de texto todas las novelas, incluyendo las borradas');
  write('Opcion: ');
  readln(opc);
  writeln;
  case opc of:
    'A' or 'a': begin
      writeln('Ingrese el nombre de la novela a crear');
      readln(nombre);

    end;
    'B' or 'b' or 'C' or 'c' or 'D' or 'd': begin
      writeln('Ingrese el nombre de la novela a modificar');
      readln(nombre);
      assign(mae, nombre);
      reset(mae);
      case opc of:
        'B' or 'b': begin
        end;
        'C' or 'c': begin
        end;
        'D' or 'd': begin
        end;
      close(mae);
    end;
    'E' or 'e': begin
    end;


end.
