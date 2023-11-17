program x;
uses Sysutils;
const
  cantArchivos = 3;
Type

  producto = record
    cod: integer;
    numero: integer;
    desc: string;
    end;

  arch_txt = text;

procedure cargarRegistro (var txt: arch_txt; var r: producto);
begin
  r.cod:= -1;
  r.numero:= -1;
  r.desc:= '';
  writeln('Entra 0');
  readln;

  while(not EOF(txt)) do begin
    writeln('Entra 1');
    readln;
    readln(txt, r.cod, r.numero, r.desc);
    r.desc:= copy(r.desc, 2, length(r.desc))
    end;
end;


procedure leerRegistro(var r: producto);
begin
  write('Ingrese el codigo: ');
  readln(r.cod);
  if (r.cod <> -1) then begin
    write('Ingrese el numero: ');
    readln(r.numero);
    write('Ingrese la desc: ');
    readln(r.desc);
  end;
  writeln('Entra 0');
  readln;
end;

procedure escribirRegistro(var txt: arch_txt; r: producto);
begin
  writeln('Entra 1');
  readln;
  writeln(txt, r.cod, ' ', r.numero, ' ', r.desc);
end;

var
  txt: arch_txt;  r: producto; opc: string;
begin
  assign(txt, 'texto.txt');
  reset(txt);
  writeln('Ingrese una opc, 1 = cargarRegistro, 2 = escribirRegistro: ');
  readln(opc);

  if (opc = '1') then begin
    cargarRegistro(txt, r);
    writeln(r.cod);
    writeln(r.numero);
    writeln(r.desc);
    end;

  if (opc = '2') then begin
    leerRegistro(r);
    escribirRegistro(txt, r);
    end;

  close(txt);
  readln;
end.

