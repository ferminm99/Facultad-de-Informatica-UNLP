program a;
{------------------------------------------------------------------------------------}
const
  valorImposible= -1;
Type
  comision = record
    cod: integer;
    nombre: String[100];
    monto: real;
    end;

  empleado = record
    cod: integer;
    nombre: String[100];
    end;

  arch_bin = file of comision;
{------------------------------------------------------------------------------------}
procedure leer (var arch: arch_bin; var r: comision);
begin
  if (not EOF(arch)) then
    read(arch, r)
  else
    r.cod:= valorImposible;
end;
{------------------------------------------------------------------------------------}
procedure compactarArchivo(var arch: arch_bin; var arch_compactado: arch_bin);
var
  empleadoActual: empleado; montoTotal: real; r_comision: comision; r_compacto: comision;
begin
  leer(arch, r_comision);
  while(r_comision.cod <> valorImposible) do begin
    montoTotal:= 0;
    empleadoActual.cod:= r_comision.cod;
    empleadoActual.nombre:= r_comision.nombre;
    while (empleadoActual.cod = r_comision.cod) do begin
      montoTotal:= montoTotal + r_comision.monto;
      leer(arch, r_comision);
      end;
    r_compacto.cod:= empleadoActual.cod;
    r_compacto.nombre:= empleadoActual.nombre;
    r_compacto.monto:= montoTotal;
    write(arch_compactado, r_compacto);
    end;
end;
{------------------------------------------------------------------------------------}
var
  arch: arch_bin; arch_compactado: arch_bin; aux_str: String;
begin
  write('Ingrese el nombre del archivo con los registros: ');
  readln(aux_str);
  assign(arch, aux_str);
  reset(arch);
  write('Ingrese el nombre del archivo a crear con los registros compactados: ');
  readln(aux_str);
  assign(arch_compactado, aux_str);
  rewrite(arch_compactado);
  compactarArchivo(arch, arch_compactado);
  close(arch);
  close(arch_compactado);
  readln;
end.
