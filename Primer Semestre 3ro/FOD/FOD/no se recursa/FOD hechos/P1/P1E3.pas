program archivos;
{------------------------------------------------------------------------}
type
    persona = record
      apellido: string;
      nombre:string;
      edad: integer;
      dni: integer;
      end;

    archivo_personas = file of persona;

{------------------------------------------------------------------------}

procedure imprimirPersona(r: persona);
begin
     with r do begin
          writeln(apellido);
          writeln(nombre);
          writeln(edad);
          writeln(dni);
          end;
end;

procedure leerPersona(var r: persona);
begin
     write('Ingrese el apellido de la persona: ');
     readln(r.apellido);
     if (r.apellido <> '') then begin
       write('Ingrese el nombre de la persona: ');
       readln(r.nombre);
       write('Ingrese la edad de la persona: ');
       readln(r.edad);
       write('Ingrese el dni de la persona: ');
       readln(r.dni);
       end;
end;
{------------------------------------------------------------------------}
var
   personas: archivo_personas; nombre, opc, ape: String; r: persona;
begin
     writeln('Ingrese la opcion deseada:');
     writeln('A- Crear archivo de personas');
     writeln('B- Leer archivo de personas');
     writeln('C- Cancelar');
     readln(opc);
     writeln;

     if ((opc = 'a') or (opc = 'A')) then begin
        writeln('Ingrese el nombre del archivo a crear');
        readln(nombre);
        assign(personas, nombre);
        rewrite(personas);
        leerPersona(r);
        while (r.apellido <> '') do begin
          write(personas, r);
          writeln('Persona cargada correctamente!');
          writeln;
          leerPersona(r);
          end;
        end;

      if ((opc = 'b') or (opc = 'B')) then begin
         writeln('Ingrese el nombre del archivo a leer');
         readln(nombre);
         writeln;
         assign(personas, nombre);
         reset(personas);
         writeln('Ingrese la opcion deseada:');
         writeln('1- Listar en pantalla los datos de personas con un apellido determinado.');
         writeln('2- Listar en pantalla las personas una por una');
         writeln('3- Listar en pantalla las personas mayores de 18 años');
         readln(opc);
         writeln;

         if (opc = '1') then begin
           write('Ingrese apellido a buscar: ');
           readln(ape);
           writeln;
           while(not EOF(personas)) do begin
             read(personas, r);
             if(r.apellido = ape) then begin
               imprimirPersona(r);
               writeln;
               end;
             end;
           end;

         if (opc = '2') then
           while(not EOF(personas)) do begin
             read(personas, r);
             imprimirPersona(r);
             writeln;
             end;

         if (opc = '3') then begin
           while(not EOF(personas)) do begin
             read(personas, r);
             if(r.edad > 18) then begin
               imprimirPersona(r);
               writeln;
               end;
             end;
           end;
         end;
      close(personas);
      readln;
end.
