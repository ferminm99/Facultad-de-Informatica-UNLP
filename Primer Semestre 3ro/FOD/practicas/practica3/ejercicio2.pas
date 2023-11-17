program ejercicio2;
type
    empleado = record
             cod:integer;
             apellido:string;
             nombre:string;
             direccion:string;
             telef:integer;
             dni:integer;
             fecha:integer;
    end;
    empleados = file of empleado;
procedure leerEmpleado(var e:empleado);
begin
     writeln('apellido: ');
     readln(e.apellido);
     if (e.apellido <> ' ' ) then begin
        e.cod:= random(10);
        writeln('nro empleado: ',e.cod);
        writeln('nombre: ');
        readln(e.nombre);
        writeln('direccion: ');
        readln(e.direccion);
        writeln('dni: ');
        readln(e.dni);
        e.fecha:= random(100);
        writeln('fecha: ',e.fecha);
        e.telef:= random(5343);
        writeln('telefono: ',e.telef);
     end;
end;
procedure generarArchivo(var archivo:empleados);
var
   e:empleado;
begin
     rewrite(archivo);
     leerEmpleado(e);
     while (e.apellido <> ' ') do begin
           write(archivo,e);
           leerEmpleado(e);
     end;
     close(archivo);
end;
procedure mostrarArchivo(var arc:empleados);
var
   reg:empleado;
begin
     reset(arc);
     while (not eof(arc)) do begin
           read(arc,reg);
           writeln('apellido: ', reg.apellido);
     end;
     close(arc);
end;
procedure eliminarEmpleados(var arc: empleados);
var
   reg:empleado;
begin
     reset(arc);
     while (not eof(arc)) do begin
           read(arc,reg);
           if (reg.dni < 5000) then begin
              reg.apellido:= '*'+reg.apellido;
              seek(arc,filePos(arc)-1);
              write(arc,reg);
           end;
     end;
     close(arc);
end;
var
   arc:empleados;
begin
     Assign(arc,'emplead');
     generarArchivo(arc);
     writeln('archivo empleados : ');
     mostrarArchivo(arc);
     eliminarEmpleados(arc);
     writeln('archivo con empleados eliminados: ');
     mostrarArchivo(arc);
     readln();
end.
