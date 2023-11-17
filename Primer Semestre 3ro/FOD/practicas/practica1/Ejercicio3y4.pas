program ejer3;
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
procedure mostrarDatosDeterminado(var arch:empleados; nombre:string);
var
   reg:emp;   encontre:boolean;
begin
     reset(arch);
     encontre:= false;
     while (not encontre) do begin
           if (not eof(arch)) then begin
              read(arch,reg);
              if (reg.nombre = nombre) then  begin
                 encontre:= true;
                 writeln('apellido : ',reg.apellido);
                 writeln('nombre : ',reg.nombre);
                 writeln('edad : ',reg.edad);
                 writeln('dni : ',reg.dni);
                 writeln('nro empleado : ',reg.nro);
              end;
           end
           else begin
               encontre:= true;
               writeln('no se encontro');
           end;
     end;
     close(arch);
end;

procedure mostrarJubilados(var archivo:empleados);
var
   reg:emp;
begin
     reset(archivo);
     while (not eof(archivo)) do begin
           read(archivo,reg);
           if (reg.edad > 60) then begin
              writeln('apellido : ',reg.apellido);
              writeln('nombre : ',reg.nombre);
              writeln('edad : ',reg.edad);
              writeln('dni : ',reg.dni);
              writeln('nro empleado : ',reg.nro);
              writeln('---');
           end;
     end;
     close(archivo);
end;
procedure AniadirEmp(var arc: empleados);
var
   reg:emp;
begin
     writeln('agregar empleado ');
     writeln('apellido: ');
     readln(reg.apellido);
     if (reg.apellido <> ' ' ) then begin
        writeln('nro empleado: ');
        readln(reg.nro);
        writeln('nombre: ');
        readln(reg.nombre);
        writeln('dni: ');
        readln(reg.dni);
        writeln('edad: ');
        readln(reg.edad);
        reset(arc);
        seek(arc,FileSize(arc));
        write(arc,reg);
        close(arc);
     end;
end;
procedure modificarEdad(var arc:empleados; apellido: string);
var
   ok: boolean; reg:emp;
begin
     ok:= false;
     reset(arc);
     while(not eof(arc)) do begin
              read(arc,reg);
              if (reg.apellido = apellido) then begin
                 ok:= true;
                 writeln('reescribir edad ');
                 readln(reg.edad);
                 seek(arc,FilePos(arc)-1);
                 write(arc,reg);
              end;
     end;
     if(ok=false) then writeln('no se encontro el apellido' );
     close(arc);
end;
procedure exportarArch(var arc_e:empleados; var arc_t:Text);
var
   reg:emp;
begin
     rewrite(arc_t);
     reset(arc_e);
     while (not eof(arc_e)) do begin
           read(arc_e,reg);
           writeln(arc_t,'nombre: ',reg.nombre,' apellido: ',reg.apellido,' numero empleado: ',reg.nro,' dni: ',reg.dni,' edad: ',reg.edad);
     end;
     close(arc_e);
     close(arc_t);
end;
procedure mostrarTxt(var archivo:Text);
var
   reg:String;
begin
     reset(archivo);
     while (not eof(archivo)) do begin
           writeln('-');
           readln(archivo,reg);
           writeln(reg);
     end;
     close(archivo);
end;
procedure exportarArchSinDni(var arc_e:empleados;var arc_txtDni:Text);
var
   reg:emp;
begin
     reset(arc_e);
     rewrite(arc_txtDni);
     while (not eof(arc_e)) do begin
           read(arc_e,reg);
           if (reg.dni = 00) then begin
              writeln(arc_txtDni, 'nombre: ',reg.nombre,' apellido: ',reg.apellido,' numero empleado: ',reg.nro,' dni: ',reg.dni,' edad: ',reg.edad);
           end;
     end;
     close(arc_e);
     close(arc_txtDni);
end;
var
   arc_emp:empleados;  nombre:string;      arc_txt,arc_txtDni: Text;   num:integer;
begin
     writeln('ingresar opción ');
     writeln('1) Crear Archivo Empleados');
     writeln('2) Abrir Archivo empleados');
     Writeln('3) Salir del programa');
     write ('num : ');
     readln(num);
     if (num = 1) then begin
        writeln('ingrese nombre fisico');
        readln(nombre);
        Assign(arc_emp,nombre);
        generarArchivo(arc_emp);
     end;
     else if (num = 2) then begin
        writeln('Ingrese el nombre del archivo a abrir');
        readln(nombre);
        assign(arc_emp,nombre);
        reset(arc_emp);
        writeln('1) mostrar numeros de empleados');
        writeln('2) buscar empleado determinado');
        writeln('3) mostrar empleados proximos a jubilarse');
        readln(num);
        if (num = 1)then
           mostrarArchivo(arc_emp);
        if (num = 2)then begin
           writeln('nombre a buscar: ');
           readln(nombre);
           mostrarDatosDeterminado(arc_emp,nombre);
        end;
        if (num = 3) then begin
           writeln('empleados proximos a jubilarse: ');
           mostrarJubilados(arc_emp);
        end;
        writeln('1) si quiere añadir empleado');
        writeln('2) modificar edad de un empleado');
        readln(num);
        if (num = 1) then begin
           AniadirEmp(arc_emp);
           mostrarArchivo(arc_emp);
        end;
        if (num = 2) then begin
           writeln('ingrese apellido empleado a modificar edad: ');
           readln(nombre);
           modificarEdad(arc_emp,nombre);
        end;
        Assign(arc_txt,'empleados.txt');
        exportarArch(arc_emp,arc_txt);
        writeln ('texto de empleados: ');
        mostrarTxt(arc_txt);
        Assign(arc_txtDni,'faltaDni.txt');
        exportarArchSinDni(arc_emp,arc_txtDni);
        writeln('empleados sin dni ');
        mostrarTxt(arc_txtDni);
     end
     else if(num=3) then
         writeln('fin de programa');
     readln();
end.
