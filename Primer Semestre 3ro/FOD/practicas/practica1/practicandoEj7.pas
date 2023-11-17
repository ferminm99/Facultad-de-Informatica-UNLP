program practicando;
type
    novela = record
            codigo: integer;
            genero: string;
            precio: real;
            nombre: string;
    end;
    archivo_texto = text;
    archivo_binario = file of novela;
procedure leerNovela (var n: novela);
begin
     writeln('Escribe el codigo del producto: ');
     readln(n.codigo);
     writeln('Escribe el genero del producto: ');
     readln(n.genero);
     writeln('Escribe el precio del producto: ');
     readln(n.precio);
     writeln('Escribe el nombre del producto: ');
     readln(n.nombre);
end;
{------------------------------------------------------------------------}
var
   opc: char;
   texto: archivo_texto;
   novelas: archivo_binario;
   nombre_archivo: string;
   n: novela;
   cod: integer;
   ok: boolean;
begin
     writeln('Ingrese A para crear archivo binario a partir de novelas.txt');
     writeln('Ingrese B para modificar archivo');
     writeln('Ingrese C para agregar archivo');
     writeln('Ingrese D para imprimir archivo en pantalla');
     readln(opc);
     writeln;
{------------------------------------------------------------------------}
     if (opc = 'A')then begin
        assign(texto, 'novelas.txt');
        reset(texto);
        writeln('Ingrese el archivo a crear: ');
        readln(nombre_archivo);
        assign(novelas,nombre_archivo);
        rewrite(novelas);
        while (not EOF (texto)) do begin
              readln(texto, n.codigo, n.precio);
              readln(texto,n.genero, n.nombre);
              write(novelas, n);
        end;
        close(texto);
     end;
{------------------------------------------------------------------------}
     if (opc = 'B') then begin
        write('Ingrese el nombre del archivo al que le desea modificar algo: ');
        readln (nombre_archivo);
        ok:=false;
        assign(novelas,nombre_archivo);
        reset(novelas);
        writeln('Ingrese el codigo de la novela que desea modificar');
        readln(cod);
        while ((ok = false) and (not EOF (novelas))) do begin
              read(novelas,n);
              if (n.codigo = cod) then begin
                 writeln('Ingrese los nuevos datos de la novela: ');
                 leerNovela(n);
                 seek(novelas,FilePos(novelas) - 1);
                 write(novelas,n);
                 ok:= true;
              end;
        end;
        if(ok = false) then writeln('No se encontro el artículo');
     end;
{------------------------------------------------------------------------}
     if (opc = 'C') then begin
        write('Ingrese el nombre del archivo al que le desea agregar la novela: ');
        readln (nombre_archivo);
        assign(novelas,nombre_archivo);
        reset(novelas);
        seek(novelas, FileSize(novelas) );
        leerNovela(n);
        write(novelas,n);
     end;
{------------------------------------------------------------------------}
     if (opc = 'D') then begin
        write('Ingrese el nombre del archivo al que le desea agregar la novela: ');
        readln (nombre_archivo);
        assign(novelas,nombre_archivo);
        reset(novelas);
        while (not EOF(novelas)) do begin
              read(novelas,n);
              writeln(n.nombre);
              writeln(n.genero);
              writeln(n.precio:0:2);
              writeln(n.codigo);
              writeln;
        end;
     end;
{------------------------------------------------------------------------}
     close(novelas);
     readln;
end.
