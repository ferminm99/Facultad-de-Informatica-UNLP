program ex;
uses Sysutils;
const
  cant_detalles = 4;
  valorImposible = 999999;
Type
  semanario = record
    fecha: integer;
    cod: integer;
    nombre: string;
    desc: string;
    precio: real;
    stock: integer;
    vendidos: integer;
    end;

  venta = record
    fecha: integer;
    cod: integer;
    vendidos: integer;
    end;

  arch_mae = file of semanario;
  arch_det = file of venta;

  vector_det = array [1..cant_detalles] of arch_det;
  vector_ven = array [1..cant_detalles] of venta;

{-------------------------------------------------------------------------------}
procedure leerMaestro(var arch: arch_mae; var r_mae: semanario);
begin
  if (not EOF(arch)) then
    read(arch, r_mae)
  else
    r_mae.cod:= valorImposible;
end;
{-------------------------------------------------------------------------------}
procedure leerDetalle(var arch: arch_det; var r_det: venta);
begin
  if (not EOF(arch)) then
    read(arch, r_det)
  else
    r_det.cod:= valorImposible;
end;
{-------------------------------------------------------------------------------}
procedure minimo(var v_det: vector_det; var v_ven: vector_ven; var r_min: venta);
var
  i: integer; menor: integer;
begin
  r_min:= v_ven[1];
  menor:= 1;
  for i:= 2 to cant_detalles do begin
    if ((v_ven[i].fecha < r_min.fecha) or ((v_ven[i].fecha = r_min.fecha) and (v_ven[i].cod < r_min.cod))) then begin
      r_min:= v_ven[i];
      menor:= i;
      end
  end;
  leerDetalle(v_det[menor], v_ven[menor]);
end;
{-------------------------------------------------------------------------------}

procedure procesarMaestro(var arch: arch_mae; var v_det: vector_det; var v_ven: vector_ven; var semMax: semanario);
var
  r_mae: semanario; r_min: venta; 
begin
  leerMaestro(arch, r_mae);
  minimo(v_det, v_ven, r_min);
  while(r_mae.cod <> valorImposible) do begin
    while (r_mae.cod = r_min.cod) do begin
      r_mae.vendidos:= r_mae.vendidos + r_min.vendidos;
      r_mae.stock := r_mae.stock - r_min.vendidos;
      minimo(v_det, v_ven, r_min);
    end;
    if(r_mae.vendidos > semMax.vendidos) then
      semMax:= r_mae;
    leerMaestro(arch, r_mae);
  end;
end;
{-------------------------------------------------------------------------------}

var
  nombre: string; arch: arch_mae; i: integer; v_det: vector_det; v_ven: vector_ven; semMax: semanario;
begin
  write('Ingrese el nombre o ruta del archivo maestro: ');
  readln(nombre);
  assign(arch, nombre);
  reset(arch);

  for i:= 1 to cant_detalles do begin
    assign(v_det[i], 'det' + IntToStr(i));
    reset(v_det[i]);
  end;

  for i:= 1 to cant_detalles do
    leerDetalle(v_det[i], v_ven[i]);

  semMax.vendidos:= -1;

  procesarMaestro(arch, v_det, v_ven, semMax);

  writeln('Datos de semMax:');
  writeln(semMax.cod);
  writeln(semMax.fecha);
  writeln(semMax.vendidos);

  readln;

end.
