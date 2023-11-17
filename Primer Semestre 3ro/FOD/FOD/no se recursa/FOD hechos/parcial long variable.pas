program x;
uses Sysutils;
const
  separa_reg: char = '&';
  separa_cam: char = '$';

Type
  cliente = record
    nombre: string;
    apellido: string;
    domicilio: string;
    telefono: integer;
    end;

  archivo = file;

procedure leerRegistro(var r: cliente);
begin
  writeln('Ingrese el telefono');
  readln(r.telefono);
  if(r.telefono <> 0) then begin
    writeln('Ingrese el nombre');
    readln(r.nombre);
    writeln('Ingrese el apellido');
    readln(r.apellido);
    writeln('Ingrese el domicilio');
    readln(r.domicilio);
  end;
end;

procedure cargarClientes (var arch: archivo);
var
  r: cliente; strAux: string;
begin
  rewrite(arch, 1);
  leerRegistro(r);
  while(r.telefono <> 0) do begin
    blockwrite(arch, r.nombre[1], length(r.nombre));
    blockwrite(arch, separa_cam, length(separa_cam));
    blockwrite(arch, r.apellido[1], length(r.apellido));
    blockwrite(arch, separa_cam, length(separa_cam));
    blockwrite(arch, r.domicilio[1], length(r.domicilio));
    blockwrite(arch, separa_cam, length(separa_cam));
    str(r.telefono, strAux);
    blockwrite(arch, strAux[1], length(strAux));
    blockwrite(arch, separa_cam, length(separa_cam));
    blockwrite(arch, separa_reg, length(separa_reg));
    leerRegistro(r);
  end;
  close(arch);
end;

procedure devolverDir(var arch: archivo; num: integer);
var
  encontrado: boolean; car: char; r: cliente; num_campo: integer; campo: string;
begin
  encontrado:= false;
  reset(arch, 1);
  while (not EOF(arch) and (encontrado = false)) do begin
    blockread(arch, car, 1);
    num_campo:= 1;
    while((not EOF(arch)) and (car <> separa_reg)) do begin
      campo:= '';
      while((not EOF(arch)) and (car <> separa_reg) and (car <> separa_cam)) do begin
        campo:= campo + car;
        blockread(arch, car, 1);
      end;
      case num_campo of
        1: r.nombre:= campo;
        2: r.apellido:= campo;
        3: r.domicilio:= campo;
        4: r.telefono:= StrToInt(campo);
      end;
      if ((car = separa_cam) and (not EOF(arch))) then begin
        blockread(arch, car, 1);
        num_campo:= num_campo + 1;
      end;
    end;
    if (r.telefono = num) then begin
      writeln('El telefono ', num, ' tiene como direccion ', r.domicilio);
      encontrado:= true;
    end;
  end;
  close(arch);
end;

var
  arch: archivo;
begin
  assign(arch, 'textoparcial.txt');
  devolverDir(arch, 1);
  readln;
end.
