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
    archivo_texto = text;

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

procedure leerUltimo(var mae: archivo_personas; var r_ult: persona);
begin
  seek(mae, fileSize(mae) - 1);
  read(mae, r_ult);
end;

{------------------------------------------------------------------------}
var
   personas, mae, maeAux: archivo_personas; texto: archivo_texto; nombre, opc, ape, nomb: String; r, r_ult, r_mae: persona; cant, i, pos, eda: integer;  ok: boolean;
{------------------------------------------------------------------------}
begin
     writeln('Ingrese la opcion deseada:');
     writeln('A- Crear archivo de personas');
     writeln('B- Leer archivo de personas');
     writeln('C- Añadir 1 o mas personas al final del archivo');
     writeln('D- Modificar edad a una o mas personas');
     writeln('E- Exportar el contenido del archivo a un archivo llamado "personas.txt"');
     writeln('F- Exportar a un archivo de texto llamado "erroneos.txt" las personas que no tengan cargadas el DNI');
     writeln('G- Borrar un registro por posicion');
     writeln('H- Salir');
     readln(opc);
     writeln;
     {------------------------------------------------------------------------}
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
      {------------------------------------------------------------------------}
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
      {------------------------------------------------------------------------}
      if ((opc = 'c') or (opc = 'C')) then begin
        writeln('Ingrese el nombre del archivo a modificar');
        readln(nombre);
        assign(personas, nombre);
        reset(personas);
        write('Ingrese la cantidad de personas a agregar: ');
        readln(cant);
        writeln;
        pos:= fileSize(personas);
        seek(personas, pos);
        for i:= 0 to (cant - 1) do begin
            leerPersona(r);
            write(personas, r);
            writeln('Persona agregada correctamente!');
            writeln;
            end;
        end;
      {------------------------------------------------------------------------}
      if ((opc = 'd') or (opc = 'D')) then begin
        writeln('Ingrese el nombre del archivo a modificar');
        readln(nombre);
        assign(personas, nombre);
        reset(personas);
        write('Ingrese la cantidad de personas a la que se le quiere modificar la edad: ');
        readln(cant);
        for i:= 0 to (cant - 1) do begin
          ok:= false;
          write('Ingrese el apellido de la persona a modificar: ');
          readln(ape);
          write('Ingrese el nombre de la persona a modificar: ');
          readln(nomb);
          write('Ingrese la nueva edad de la persona a modificar: ');
          readln(eda);
          while((ok = false) and (not EOF(personas))) do begin
            read(personas, r);
            if ((r.apellido = ape) and (r.nombre = nomb)) then begin
              r.edad:= eda;
              pos:= filePos(personas);
              seek(personas, pos - 1);
              write(personas, r);
              writeln('Correccion completa!');
              ok:= true;
              end;
            end;
          if(ok = false) then
            writeln('No se encontro esta persona, lo sentimos');
          end;
        end;
      {------------------------------------------------------------------------}
      if ((opc = 'e') or (opc = 'E')) then begin
        writeln('Ingrese el nombre del archivo a exportar');
        readln(nombre);
        assign(personas, nombre);
        reset(personas);
        writeln('Ingrese el nombre del archivo de texto a crear');
        readln(nombre);
        assign(texto, nombre);
        rewrite(texto);
        while(not EOF(personas)) do begin
          read(personas, r);
          writeln(texto, r.apellido);
          writeln(texto, r.nombre);
          writeln(texto, r.edad);
          writeln(texto, r.dni);
          end;
        close(texto);
        end;
      {------------------------------------------------------------------------}
      if ((opc = 'f') or (opc = 'F')) then begin
        writeln('Ingrese el nombre del archivo a leer');
        readln(nombre);
        assign(personas, nombre);
        reset(personas);
        writeln('Ingrese el nombre del archivo de texto a crear');
        readln(nombre);
        assign(texto, nombre);
        rewrite(texto);
        while(not EOF(personas)) do begin
          read(personas, r);
          if (r.dni = 0) then begin
            writeln(texto, r.apellido);
            writeln(texto, r.nombre);
            end;
          end;
        close(texto);
        end;
      {------------------------------------------------------------------------}
      if ((opc = 'g') or (opc = 'G')) then begin
        writeln('Ingrese el nombre del archivo del que se quiere borrar');
        readln(nombre);
        assign(mae, nombre);
        reset(mae);
        assign(maeAux, 'maeAux');
        rewrite(maeAux);
        writeln('Posicion del archivo a borrar');
        readln(pos);
        if(pos < (fileSize(mae) - 1))then begin
          leerUltimo(mae, r_ult);
          seek(mae, pos);
          write(mae, r_ult);
          reset(mae);
          for i:= 1 to fileSize(mae) - 1 do begin
            read(mae, r_mae);
            write(maeAux, r_mae);
            end;
          rewrite(mae);
          reset(maeAux);
          for i:= 1 to fileSize(maeAux) do begin
            read(maeAux, r_mae);
            write(mae, r_mae);
            end;
          end
        else
          writeln('Posicion no valida');
        close(mae);
        close(maeAux);
        end;
      {------------------------------------------------------------------------}
      close(personas);
      readln;
end.
