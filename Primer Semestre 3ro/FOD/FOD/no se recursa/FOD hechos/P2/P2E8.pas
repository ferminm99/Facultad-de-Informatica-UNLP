program a;
const
  valorImposible = 'zzzz';
Type

  empleado = record
    depto: String;
    division: String;
    numero: integer;
    categ: integer;
    cant: integer
    end;

  arch_mae = file of empleado;
  arch_tex = text;

  categorias = array [1..15] of real;

{-----------------------------------------------------------------}
procedure leerMaestro(var mae: arch_mae; var rm: empleado);
begin
  if(not EOF(mae)) then
    read(mae, rm)
  else begin
    rm.depto:= valorImposible;
    rm.division:= valorImposible;
    rm.numero:= 999999;
    end;
end;
{-----------------------------------------------------------------}
procedure cargarVector (var v: categorias);
var
  id: String; tex: arch_tex; cat: integer; monto: real;
begin
  write('Ingrese el nombre del archivo de texto con el que se desea cargar el vector: ');
  readln(id);
  assign(tex, id);
  reset(tex);
  while(not EOF(tex)) do begin
    read(tex, cat);
    read(tex, monto);
    v[cat-1]:= monto;
    end;
  close(tex);
end;
{-----------------------------------------------------------------}
var
  v: categorias; id: String; mae: arch_mae; horasDepto, horasDivision: integer; montoDepto, montoDivision, monto: real; rm: empleado; deptoActual: String; divisionActual: String;
begin
  cargarVector(v);
  write('Ingrese el nombre del archivo maestro: ');
  readln(id);
  assign(mae, id);
  reset(mae);
  leerMaestro(mae, rm);
  while(rm.depto <> valorImposible) do begin
    deptoActual:= rm.depto;
    write('Departamento: ');
    writeln(deptoActual);
    writeln;
    horasDepto:= 0;
    montoDepto:= 0;
    while(rm.depto = deptoActual) do begin
      divisionActual:= rm.division;
      write('Division: ');
      writeln(divisionActual);
      horasDivision:= 0;
      montoDivision:= 0;
      while(rm.division = divisionActual) do begin
        writeln('Número de Empleado    Total de Hs.   Importe a cobrar');
        write(rm.numero);
        write('        ');
        write(rm.cant);
        write('        ');
        monto:= v[rm.categ-1] * rm.cant;
        writeln(monto);
        horasDivision:= horasDivision + rm.cant;
        montoDivision:= montoDivision + monto;
        leerMaestro(mae, rm);
        end;
      writeln('Total de horas por division: ', horasDivision);
      writeln('Monto total por division: ', montoDivision);
      writeln('Division');
      writeln(divisionActual);
      horasDepto:= horasDepto + horasDivision;
      montoDepto:= montoDepto + montoDivision;
      end;
    writeln('Total horas departamento: ', horasDepto);
    writeln('Monto total departamento: ', montoDepto);
    end;
  close(mae);
end.
