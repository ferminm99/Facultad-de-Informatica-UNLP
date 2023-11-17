{Suponga que usted es administrador de un servidor de correo electrónico. En los logs del mismo (información guardada acerca de los movimientos
  que ocurren en el server) que se encuentra en la siguiente ruta: /var/log/logmail.dat se guarda la siguiente información:
   nro_usuario, nombreUsuario, nombre, apellido, cantidadMailEnviados.
   Diariamente el servidor de correo genera un archivo con la siguiente información:
    nro_usuario, cuentaDestino, cuerpoMensaje. Este archivo representa todos los correos enviados por los usuarios en un día determinado.
    Ambos archivos están ordenados por nro_usuario y se sabe que un usuario puede enviar cero, uno o más mails por día.
    a- Realice el procedimiento necesario para actualizar la información del log en un día particular.
    Defina las estructuras de datos que utilice su procedimiento.
    b- Genere un archivo de texto que contenga el siguiente informe dado un archivo detalle de un día determinado:

    nro_usuarioX…………..cantidadMensajesEnviados
     …………. nro_usuarioX+n………..cantidadMensajesEnviados
 Nota: tener en cuenta que en el listado deberán aparecer todos los usuarios que existen en el sistema. }
program x;
const
  valorImposible= 999999;
Type
  usuario = record
    codUsuario: integer;
    nombreUsuario: String;
    nombre: String;
    apellido: String;
    cantEnviados: integer;
    end;

  envio = record
    codOrigen: integer;
    codDestino: integer;
    cuerpo: String;
    end;

  arch_mae = file of usuario;
  arch_det = file of envio;
  arch_tex = text;

{---------------------------------------------------------------------------------}
procedure leerMaestro(var mae: arch_mae; var rm: usuario);
begin
  if(not EOF(mae)) then
    read(mae, rm)
  else
    rm.codUsuario:= valorImposible;
end;
{---------------------------------------------------------------------------------}
procedure leerDetalle(var det: arch_det; var rd: envio);
begin
  if(not EOF(det)) then
    read(det, rd)
  else
    rd.codOrigen:= valorImposible;
end;
{---------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------}
{---------------------------------------------------------------------------------}
var
  cantUsuario: integer; mae: arch_mae; det: arch_det; rm: usuario; rd: envio; tex: arch_tex; nomb: String;
begin
  assign(mae, 'logmail.dat');
  reset(mae);
  write('Ingrese el nombre del archivo detalle con el que se desea actualizar el maestro: ');
  readln(nomb);
  assign(det, nomb);
  reset(det);
  write('Ingrese el nombre del archivo de texto en donde mostrar la actualizacion: ');
  readln(nomb);
  assign(tex, nomb);
  rewrite(tex);
  leerMaestro(mae, rm);
  leerDetalle(det, rd);
  while(rm.codUsuario <> valorImposible) do begin
    if (rm.codUsuario = rd.codOrigen) then begin
      cantUsuario:= 0;
      while(rd.codOrigen = rm.codUsuario) do begin
        cantUsuario:= cantUsuario + 1;
        leerDetalle(det, rd);
        end;
      rm.cantEnviados:=  rm.cantEnviados + cantUsuario;
      seek(mae, filePos(mae)-1);
      write(mae, rm);
      end;
    write(tex, 'Numero de usuario: ', rm.codUsuario, ', cantidad de mensajes enviados: ', rm.cantEnviados);
    end;
  close(tex);
  close(det);
  close(mae);
end.



