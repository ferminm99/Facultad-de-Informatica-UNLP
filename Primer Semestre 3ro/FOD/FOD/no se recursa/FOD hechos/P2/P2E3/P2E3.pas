program P2E3;
const
  cant_detalles = 4;
  valorImposible = 999999;
Type
  producto = record
    cod: integer;
    desc: String;
    precio: real;
    SA: integer;
    SM: integer;
    end;

  pedido = record
    cod: integer;
    cant: integer;
    end;

  arch_mae = file of producto;
  arch_det = file of pedido;

  pedidos = array [1..cant_detalles] of pedido;

{------------------------------------------------------------------------------------}
procedure leerMaestro (var mae: arch_mae; var r_maestro: producto);
begin
  if (not EOF(mae)) then
    read(mae, r_maestro)
  else
    r_maestro.cod:= valorImposible;
end;

procedure leerDetalle (var det: arch_det; var r_detalle: pedido);
begin
  if (not EOF(det)) then
    read(det, r_detalle)
  else
    r_detalle.cod:= valorImposible;
end;
{------------------------------------------------------------------------------------}
procedure minimo (var v: pedidos; var min: pedido; var sucursal: integer; var det1, det2, det3, det4: arch_det);
var
  i: integer; codMin: integer;
begin
  codMin:= valorImposible;
  for i:= 1 to cant_detalles do
    if (v[i].cod < codMin) then begin
      codMin:= v[i].cod;
      sucursal:= i;
      end;
  min:= v[sucursal];
  case sucursal of
    1: leerDetalle(det1, v[1]);
    2: leerDetalle(det2, v[2]);
    3: leerDetalle(det3, v[3]);
    4: leerDetalle(det4, v[4]);
    end;
end;
{------------------------------------------------------------------------------------}
var
  v: pedidos; nombre: String; sucursal: integer; mae: arch_mae; det1: arch_det; det2: arch_det; det3: arch_det; det4: arch_det; r_maestro: producto; min: pedido;
begin
  write('Ingrese el nombre del archivo maestro: ');
  readln(nombre);
  assign(mae, nombre);
  reset(mae);
{  for i:= 1 to cant_detalles do begin
    write('Ingrese el nombre del archivo detalle de la ', i, '° sucursal');
    readln(nombre);
    assign('det' + IntToStr(i), nombre);
    reset('det' + IntToStr(i));
    leerDetalle('det' + IntToStr(i), r_detalle);
    v[i]:= r_detalle;
    end;}
  write('Ingrese el nombre del archivo detalle de la 1° sucursal: ');
  readln(nombre);
  assign(det1, nombre);
  reset(det1);
  write('Ingrese el nombre del archivo detalle de la 2° sucursal: ');
  readln(nombre);
  assign(det2, nombre);
  reset(det2);
  write('Ingrese el nombre del archivo detalle de la 3° sucursal: ');
  readln(nombre);
  assign(det3, nombre);
  reset(det3);
  write('Ingrese el nombre del archivo detalle de la 4° sucursal: ');
  readln(nombre);
  assign(det4, nombre);
  reset(det4);
  leerDetalle(det1, v[1]); {inicializo el vector}
  leerDetalle(det2, v[2]);
  leerDetalle(det3, v[3]);
  leerDetalle(det4, v[4]);
  leerMaestro(mae, r_maestro);
  minimo(v, min, sucursal, det1, det2, det3, det4); {devuelve un registro del detalle y tambien la sucursal, es decir cual archivo detalle tenia ese minimo}
  writeln(min.cod);
  writeln(min.cant);
  while (min.cod <> valorImposible) do begin   {mientras no se terminen los archivos detalle hacer este while}
    while(min.cod <> r_maestro.cod) do begin   {mientras el archivo maestro no sea igual al detalle leer el siguiente e informar el actual}
      if (r_maestro.SA < r_maestro.SM) then
        writeln('El producto ', r_maestro.cod, ' tiene un stock menor al minimo.');
      leerMaestro(mae, r_maestro);
      end;
    r_maestro.SA:= r_maestro.SA - min.cant; {actualizo registro maestro}
    if (r_maestro.SA < 0) then begin        {informo si no alcanzo el stock}
      writeln('A la ', sucursal, '° sucursal no se le pudo enviar ', (r_maestro.SA * -1), ' elementos del producto ', r_maestro.cod);
      r_maestro.SA:= 0;
      end;
    seek(mae, filePos(mae) - 1);
    write(mae, r_maestro);                  {escribo registro maestro actualizado}
    minimo(v, min, sucursal, det1, det2, det3, det4);  {leo siguiente reg maestro}
    end;
  close(mae);
  close(det1);
  close(det2);
  close(det3);
  close(det4);
  readln;
end.

