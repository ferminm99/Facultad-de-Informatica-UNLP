program ejercicio1;
const
     valorAlto = 999999;
type
    emp = record
        nro:integer;
        apellido:string;
        nombre: string;
        dni:integer;
        edad:integer;
    end;
    empleados = file of emp;
procedure leerEmpleado(var e:emp);
begin
     writeln('apellido: ');
     readln(e.apellido);
     if (e.apellido <> ' ' ) then begin
        e.nro:= random(10);
        writeln('nro empleado: ',e.nro);
        writeln('nombre: ');
        readln(e.nombre);
        writeln('dni: ');
        readln(e.dni);
        e.edad:= random(100);
        writeln('edad: ',e.edad);
     end;
end;
procedure generarArchivo(var archivo:empleados);
var
   e:emp;
begin
     rewrite(archivo);
     leerEmpleado(e);
     while (e.apellido <> ' ') do begin
           write(archivo,e);
           leerEmpleado(e);
     end;
     close(archivo);
end;
procedure mostrarArchivo(var archivo:empleados);
var
   reg:emp;
begin
     reset(archivo);
     writeln('nros de empleados');
     while (not eof(archivo)) do begin
           read(archivo,reg);
           writeln(reg.nro);
     end;
     close(archivo);
end;
procedure leer(var arc:empleados;var reg:emp);
begin
     if (not eof(arc)) then
        read(arc,reg)
     else
         reg.dni:= valorAlto;
end;
procedure bajarEmpleado(var arc:empleados);
var
   reg,reg2:emp; dni:integer;  pos:integer;
begin
     reset(arc);
     writeln('ingrese dni a borrar');
     readln(dni);
     leer(arc,reg);
     while (reg.dni <> valorAlto)and(reg.dni <> dni) do begin
           leer(arc,reg);
     end;
     if (reg.dni = dni) then begin
        if (eof(arc)) then begin
           seek(arc,FileSize(arc)-1);
           truncate(arc);
        end
        else begin
             pos:= FilePos(arc)-1;
             seek(arc,FileSize(arc)-1);
             read(arc,reg2);
             seek(arc,pos);
             write(arc,reg2);
             seek(arc,FileSize(arc)-1);
             truncate(arc);
        end;
        writeln('se borro');
     end
     else
         writeln('No se encontro nada');
     readln();
     close(arc);
end;
var
   arc:empleados;
begin
     Assign(arc,'emp');
     generarArchivo(arc);
     mostrarArchivo(arc);
     bajarEmpleado(arc);
     mostrarArchivo(arc);
     readln();
end.
