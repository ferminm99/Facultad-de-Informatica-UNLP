program a;

Uses sysutils;

const
  valorImposible = 'zzzz';
Type
  tTitulo = String[50];
  tArchLibros = file of tTitulo ;


{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
procedure leerMaestro(var mae: tArchLibros; var r: tTitulo);
begin
  if(not EOF(mae))then
    read(mae, r)
  else
    r:= valorImposible;
end;
{--------------------------------------------------------------------------}
procedure agregar (var a: tArchLibros ; titulo: string[50]);
var
  cabecera: tTitulo; pos: integer;
begin
  reset(a);
  leerMaestro(a, cabecera);           //leo la cabecera
  if (cabecera[1] = '-') then begin    //si tiene una posicion
    pos := StrToInt(cabecera);          //me la guardo como un int positivo en una variable pos
    pos := pos * -1;
    seek(a, pos);                      //voy a esa posicion y leo el valor del que estaba guardado para actualizar la cabecera
    leerMaestro(a, cabecera);
    seek(a, pos);                      //vuelvo de nuevo a la posicion y escribo el nuevo titulo
    write(a, titulo);
    seek(a, 0);
    write(a, cabecera);                 //actualizo la cabecera
    writeln('Titulo agregado!');
    end
  else begin
    seek(a, fileSize(a));              //si no escribo al final
    write(a, titulo);
    writeln('Titulo agregado!');
    end;
  close(a);
end;
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}
{--------------------------------------------------------------------------}

var
  opc: char; pos: integer; nomb: String; mae: tArchLibros; r, r_mae, cabecera, title, codNovela: tTitulo;
begin
  writeln('Ingrese una opción');
  writeln('A- Crear archivo de titulos');
  writeln('B- Borrar titulo');
  writeln('C- Ingresar un nuevo titulo a un archivo ya creado');
  writeln('D- Listar el contenido del archivo');
  readln(opc);
  case opc of
    'A', 'a': begin
      write('Ingrese el nombre del archivo a crear: ');
      readln(nomb);
      assign(mae, nomb);
      rewrite(mae);
      r:= '0';
      write(mae, r);
      write('Ingrese una nueva novela: ');
      readln(r);
      while(r <> valorImposible) do begin
        write(mae, r);
        writeln('Novela cargada!');
        writeln();
        write('Ingrese una nueva novela: ');
        readln(r);
        end;
      writeln('Carga de novelas finalizada!');
      close(mae);
      end;
    'B', 'b': begin
       write('Ingrese el nombre del archivo maestro: ');
       readln(nomb);
       assign(mae, nomb);
       reset(mae);
       write('Ingresar el titulo a borrar: ');
       readln(codNovela);
       leerMaestro(mae, cabecera);
       leerMaestro(mae, r_mae);
       while((r_mae <> valorImposible) and (r_mae <> codNovela)) do
         leerMaestro(mae, r_mae);
       if(r_mae = codNovela) then begin       //si encontro el titulo
         writeln('r_mae[1]' , r_mae[1]);
         r_mae:= cabecera;                    //actualizo el puntero al proximo titulo de la lista
         seek(mae, filePos(mae) - 1);
         cabecera:= IntToStr(filePos(mae) * -1);
         write(mae, r_mae);
         writeln('r_mae = ', r_mae);
         writeln('cabecera = ', cabecera);
         seek(mae, 0);
         write(mae, cabecera);
         writeln('Novela borrada correctamente!');
         end
       else
         writeln('No se encontro la novela');
       close(mae);
       end;

     'C', 'c': begin
       write('Ingrese el nombre del archivo maestro: ');
       readln(nomb);
       assign(mae, nomb);
       write('Ingrese el titulo a agregar al archivo: ');
       readln(title);
       agregar(mae, title);
       end;

     'D', 'd': begin
       write('Ingrese el nombre del archivo maestro a listar: ');
       readln(nomb);
       assign(mae, nomb);
       reset(mae);
       leerMaestro(mae, cabecera);
       leerMaestro(mae, r_mae);
       while(r_mae <> valorImposible) do begin
         if((r_mae[1] <> '-') and (r_mae[1] <> '0')) then
           writeln('Titulo: ', r_mae);
         leerMaestro(mae, r_mae);
         end;
       close(mae);
       end;
     end;
  readln;
end.
