program P3E6parcialST;
const
  valorImposible = 999999;
Type
  prenda = record
    cod: integer;
    desc: string;
    stock: integer;
    end;


  arch_mae = file of prenda;
  arch_det = file of integer;

{----------------------------------------------------}
{----------------------------------------------------}
{----------------------------------------------------}
{----------------------------------------------------}
{----------------------------------------------------}
procedure imprimirArchivo(var mae: arch_mae);
var
  r: prenda;
begin
  while(not EOF(mae)) do begin
    read(mae, r);
    writeln(r.cod);
    writeln(r.desc);
    writeln(r.stock);
    writeln;
  end;
  reset(mae);
end;
{----------------------------------------------------}
procedure truncadoFisico (var mae: arch_mae);
var
  r, aux: prenda; posActual, tam: integer;
begin
  tam:= fileSize(mae);
  while(filePos(mae) < tam) do begin
    read(mae, r);
    if (r.stock <= 0) then begin

      posActual:= filePos(mae) - 1;

      seek(mae, tam - 1);
      read(mae, aux);

      seek(mae, filePos(mae) - 1);
      write(mae, r);

      seek(mae, posActual);
      write(mae, aux);

      tam:= tam - 1;

      seek(mae, posActual);
    end; 
  end;
  seek(mae, tam);
  truncate(mae);
end;
{----------------------------------------------------}
procedure actualizarPrendas (var mae: arch_mae; var det: arch_det);
var
  r: prenda; codEliminar: integer;
begin
  while(not EOF(det)) do begin
    read(det, codEliminar);
    r.cod:= valorImposible;
    while ((not EOF(mae)) and (r.cod <> codEliminar)) do
      read(mae, r);

    //modifica la prenda, si no lo encontró lo informa
    if (r.cod <> codEliminar) then
      writeln('La prenda de codigo ', codEliminar, ' no se encuentra en el archivo.')
    else begin
      r.stock:= r.stock * -1;
      seek (mae, filePos(mae) - 1);
      write (mae, r);
    end;

    //vuelve a dejar el maestro en 0, ya que no está ordenado
    seek(mae, 0);
  end;
end;
{----------------------------------------------------}

var
  nombre: string; mae: arch_mae; det: arch_det;
begin
  writeln('Ingrese el nombre del archivo con todas las prendas: ');
  readln(nombre); writeln;
  assign(mae, nombre);
  reset(mae);
  write('Que desea hacer? ');
  readln(nombre); writeln;
  if(nombre = 'imprimir')then begin
    imprimirArchivo(mae);
    end
  else begin
    writeln('Ingrese el nombre del archivo con las prendas a retirar: ');
    readln(nombre);
    assign(det, nombre);
    reset(det);
    actualizarPrendas(mae, det);
    truncadoFisico(mae);
    writeln('Borrado exitoso!');
    close(det);
  end;
  close(mae);
  readln;
end.
