program a;
const
  cantidad_de_censos = 2;
  valorImposible = 'zzzz';
Type
  censo = record
    prov: String;
    cantA: integer;
    cantE: integer;
    end;

  censoDet = record
    prov: String;
    codLoc: integer;
    cantA: integer;
    cantE: integer;
    end;

  arch_mae = file of censo;
  arch_det = file of censoDet;

  censos = array [1..cantidad_de_censos] of arch_det;
{-------------------------------------------------------------------------}

procedure leerMaestro(var mae: arch_mae; var rm: censo);
begin
  if(not EOF(mae)) then
    read(mae, rm)
  else
    rm.prov:= valorImposible;
end;

{-------------------------------------------------------------------------}

procedure leerDetalle (var det: arch_det; var rd: censoDet);
begin
  if(not EOF(det)) then
    read(det, rd)
  else
    rd.prov:= valorImposible;
end;

{-------------------------------------------------------------------------}

procedure minimo (var v: censos; var rd: censoDet; var det1, det2: censoDet);
var
  provMin: String; i: integer; censo: integer;
begin
  provMin:= valorImposible;
  for i:= 1 to cantidad_de_censos do begin
    if (v[i].prov < provMin) then begin
      provMin:= v[i].prov;
      censo:= i;
      end;
    end;
  if(provMin <> valorImposible) then begin
    rd:= v[censo];
    case censo of:
      1: begin
        leerDetalle(det1, v[1]);
        end;
      2: begin
        leerDetalle(det2, v[2]);
        end;
      end;
    end
  else
    rd.prov:= valorImposible;
end;

{-------------------------------------------------------------------------}

procedure cargarVectorDeDetalles(var v: censos, var det1, det2: arch_det);

var

begin
  write('Ingrese el nombre del archivo maestro a actualizar: ');
  readln(id);
  assign(mae, id);
  reset(mae);
  cargarVectorDeDetalles(v, det1, det2);
  minimo(v, rd, det1, det2);
  leerMaestro(mae, rm);
  while(rd.prov <> valorImposible) do begin
    while(rm.prov <> rd.prov) do
      leerMaestro(mae, rm);
    provActual:= rd.prov;
    cantAlfa:= 0;
    cantEncues:= 0;
    while(rd.prov = provActual) do begin
      cantAlfa:= cantAlfa + rd.cantA;
      cantEncues:= cantEncues + rd.cantE;
      minimo(v, rd, det1, det2);
      end;
    rm.cantA:= cantAlfa;
    rm.cantE: cantEncues;
    seek(mae, filePos(mae) -1);
    write(mae, r_actualizado);
    end;
end.

