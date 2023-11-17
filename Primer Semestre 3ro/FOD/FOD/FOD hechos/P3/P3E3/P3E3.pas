program a;
const
  valorImposible = 999999;
Type

  novela = record
    cod: integer;
    genero: String;
    nombre: String;
    duracion: integer;
    director: String;
    precio: real;
    enlace: integer;
    end;

  arch_mae = file of novela;
  arch_tex = text;

{--------------------------------------------------------------------------}
procedure leerRegistro(var r: novela);
begin
  writeln('Ingrese el codigo de la novela');
  readln(r.cod);
  if (r.cod <> valorImposible) then begin
    writeln('Ingrese el genero');
    readln(r.genero);
    writeln('Ingrese el nombre');
    readln(r.nombre);
    writeln('Ingrese la duracion');
    readln(r.duracion);
    writeln('Ingrese el director');
    readln(r.director);
    writeln('Ingrese precio');
    readln(r.precio);
    end;
end;
{--------------------------------------------------------------------------}
procedure leerMaestro(var mae: arch_mae; var r: novela);
begin
  if(not EOF(mae))then
    read(mae, r)
  else
    r.cod:= valorImposible;
end;
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}

var
  opc: char; opc2, pos, codNovela: integer; nomb: String; mae: arch_mae; r, r_mae, cabecera: novela;  tex: arch_tex;
begin
  writeln('Ingrese una opción');
  writeln('A- Crear archivo de novelas');
  writeln('B- Editar archivo de novelas (modificar, agregar o borrar)');
  writeln('C- Listar en un archivo de texto (llamado "novelas.txt") todas las novelas, incluyendo las borradas');
  readln(opc);
  case opc of
    'A', 'a': begin
      write('Ingrese el nombre del archivo a crear: ');
      readln(nomb);
      assign(mae, nomb);
      rewrite(mae);
      r.cod:= 0;
      write(mae, r);
      leerRegistro(r);
      while(r.cod <> valorImposible) do begin
        write(mae, r);
        writeln('Novela cargada!');
        writeln();
        leerRegistro(r);
        end;
      writeln('Carga de novelas finalizada!');
      close(mae);
      end;
    'B', 'b': begin
      write('Ingrese el nombre del archivo a editar: ');
      readln(nomb);
      assign(mae, nomb);
      reset(mae);
      writeln('Ingrese nuevamente una opcion');
      writeln('1- Agregar una novela');
      writeln('2- Modificar una novela (el codigo no se puede modificar)');
      writeln('3- Borrar una novela');
      readln(opc2);
      case opc2 of
        1: begin
             leerRegistro(r);
             leerMaestro(mae, cabecera);
             if (cabecera.cod < 0) then begin
               pos:= cabecera.cod * -1;
               seek(mae, pos);
               leerMaestro(mae, r_mae);      //lee el archivo que va a sobreescribirse para actualizar con el enlace la cabecera
               cabecera.cod:= r_mae.enlace;
               seek(mae, pos);               //lo sobreescribe
               write(mae, r);
               seek(mae, 0);
               write(mae, cabecera);         //actualiza la cabecera en el archivo
               end
             else begin
               while(not EOF(mae)) do
                 leerMaestro(mae, r_mae);    //Se para en la ultima posicion
               write(mae, r);                //Guarda el nuevo registro
               end;
             writeln('Novela agregada!');
          end;
        2: begin
            writeln('Ingresar el codigo de la novela a modificar con los nuevos datos');
            leerRegistro(r);
            leerMaestro(mae, r_mae);
            while((r_mae.cod <> valorImposible) and (r_mae.cod <> r.cod)) do begin
              leerMaestro(mae, r_mae);
              end;
            if(r_mae.cod = r.cod)then begin
              seek(mae, filePos(mae) -1);
              write(mae, r);
              writeln('Novela modificada!');
              end
            else
              writeln('No se encontro la novela');
            end;
        3: begin
            write('Ingresar el codigo de la novela a borrar: ');
            readln(codNovela);
            leerMaestro(mae, cabecera);
            leerMaestro(mae, r_mae);
            while((r_mae.cod <> valorImposible) and (r_mae.cod <> codNovela)) do
              leerMaestro(mae, r_mae);
            if(r_mae.cod = codNovela) then begin       //si encontro la novela
              r_mae.enlace:= cabecera.cod;              //enlace de la novela = codigo de la cabecera
              cabecera.cod := filepos(mae) * -1;        //nuevo codigo de la cabecera apunta a la posicion negativa del archivo borrado
              r_mae.cod := r_mae.cod + 1000000;         //marco como borrado el codigo de la novela
              seek(mae, filePos(mae) -1);               //vuelvo 1 lugar a escribir la novela borrada
              write(mae, r_mae);
              seek(mae, 0);                             //escribo la nueva cabecera
              write(mae, cabecera);
              writeln('Novela borrada');
              end
            else
              writeln('No se encontro la novela');
          end;
        end;
      close(mae);
      end;
    'C', 'c': begin
      write('Ingrese el nombre del archivo a imprimir: ');
      readln(nomb);
      assign(mae, nomb);
      reset(mae);
      assign(tex, 'novelas.txt');
      rewrite(tex);
      leerMaestro(mae, cabecera);
      leerMaestro(mae, r_mae);
      while(r_mae.cod <> valorImposible) do begin
        writeln(tex, r_mae.cod, ' --> codigo');
        writeln(tex, r_mae.enlace, ' --> enlace');
        leerMaestro(mae, r_mae);
        end;
      close(tex);
      end;
    end;
  readln;
end.
