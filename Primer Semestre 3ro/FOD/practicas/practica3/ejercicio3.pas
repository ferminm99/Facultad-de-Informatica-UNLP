program ejercicio3;
const
     valorAlto = 99999;
type
    novela = record
             cod:integer;
             genero:string;
             director:string;
             nombre:string;
             duracion:integer;
             precio:integer;
    end;
    novelas = file of novela;
procedure leerNovela(var e:novela);
begin
     writeln('nombre: ');
     readln(e.nombre);
     if (e.nombre <> ' ' ) then begin
        writeln('codigo: ');
        readln(e.cod);
        writeln('director: ');
        readln(e.director);
        writeln('genero: ');
        readln(e.genero);
        e.duracion:= random(100);
        writeln('duracion: ',e.duracion);
        e.precio:= random(5343);
        writeln('precio: ',e.precio);
     end;
end;
procedure generarArchivo(var archivo:novelas);
var
   e:novela;
begin
     randomize;
     rewrite(archivo);
     e.cod:= 0;
     write(archivo,e);
     leerNovela(e);
     while (e.nombre <> ' ') do begin
           write(archivo,e);
           leerNovela(e);
     end;
     close(archivo);
end;
procedure mostrarArchivo(var arc:novelas);
var
   reg:novela;
begin
     reset(arc);
     while (not eof(arc)) do begin
           read(arc,reg);
           writeln('cod: ', reg.cod);
     end;
     close(arc);
end;
procedure leer(var arc:novelas;var reg:novela);
begin
     if (not eof(arc)) then
        read(arc,reg)
     else
         reg.cod:= valorAlto;
end;
procedure darAlta(var arc:novelas; regNuevo:novela);
var
   reg,reg2:novela;
begin
     reset(arc);
     leer(arc,reg);
     if (reg.cod < 0) then begin
        seek(arc,-(reg.cod));
        read(arc,reg2);
        seek(arc,0);
        write(arc,reg2);
        seek(arc,-(reg.cod));
        write(arc,regNuevo);
     end
     else begin
          seek(arc,FileSize(arc));
          write(arc,regNuevo);
     end;
     close(arc);
end;
procedure modificarNovela(var arc:novelas);
var
   reg:novela;  cod:integer;
begin
     reset(arc);
     leer(arc,reg);
     writeln('ingrese cod novela a modificar: ');
     readln(cod);
     while (reg.cod <> valorAlto) and(reg.cod <> cod)do
           leer(arc,reg);
     if (reg.cod = cod) then begin
        writeln('nombre novela nuevo: ');
        readln(reg.nombre);
        writeln('directo nuevo: ');
        readln(reg.director);
        writeln('genero nuevo: ');
        readln(reg.genero);
        writeln('duracion: ');
        readln(reg.duracion);
        writeln('precio : ');
        readln(reg.precio);
        seek(arc,FilePos(arc)-1);
        write(arc,reg);
        writeln('se modifico novela correctamente');
     end
     else
         writeln('no se encontro cod novela');
     close(arc);
end;
procedure darBaja(var arc:novelas);
var
   reg,reg2:novela; cod:integer; pos:integer;
begin
     reset(arc);
     writeln('ingresar cod novela a eliminar');
     readln(cod);
     leer(arc,reg);
     while (reg.cod <> valorAlto) and (reg.cod <> cod) do
           leer(arc,reg);
     if (reg.cod = cod) then begin
        pos:= FilePos(arc)-1;
        seek(arc,0);
        read(arc,reg2);
        seek(arc,pos);
        write(arc,reg2);
        seek(arc,0);
        reg.cod:= -(pos);
        write(arc,reg);
     end;
     close(Arc);
     writeln('se dio de baja con exito');
end;
procedure listarTexto(var arc:novelas; var txt: text);
var
   reg:novela;
begin
     reset(arc);
     rewrite(txt);
     while (not eof(arc)) do begin
           read(arc,reg);
           writeln(txt,reg.cod,reg.nombre,reg.director,reg.duracion,reg.precio,reg.genero);
     end;
end;
var
   arc:novelas; reg:novela; txt:text;   num:integer;
begin
     writeln('ingrese opcion: ');
     writeln('1) para generar archivo');
     writeln('2) para abrir archivo');
     readln(num);
     case (num) of
          1: begin
                  Assign(arc,'novelass');
                  generarArchivo(arc);
             end;
          2: begin
                  mostrarArchivo(arc);
                  modificarNovela(arc);
                  darBaja(arc);
                  mostrarArchivo(arc);
                  leerNovela(reg);
                  darAlta(arc,reg);
                  mostrarArchivo(arc);
                  assign(txt,'novelas.txt');
                  listarTexto(arc,txt);
             end;
     end;
     readln();
end.
