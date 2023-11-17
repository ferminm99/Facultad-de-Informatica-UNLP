program a;
const
  valorImposible = 999999;
  ano = 2019;
Type
  cliente = record
    cod: integer;
    nombre: String;
    apellido: String;
    end;

  fechaF = record
    dia: integer;
    mes: integer;
    ano: integer;
    end;

  venta = record
    clie: cliente;
    fecha: fechaF;
    monto: real;
    end;

    arch_det = file of venta;
{-----------------------------------------------------------------------------------------}
procedure leerDetalle(var det: arch_det; var rd: venta);
begin
  if(not EOF(det))then
    read(det, rd)
  else begin
    rd.clie.cod:= valorImposible;
    rd.fecha.ano:= ano + 1;
    rd.fecha.mes:= 13;
    end;
end;
{-----------------------------------------------------------------------------------------}

var
  id: String; det: arch_det; totalEmpresa, totalCliente, montoAnual, montoMensual: real; codActual, mesActual, anoActual: integer; rd: venta;
begin
  write('Ingrese el nombre del archivo maestro a utilizar: ');
  readln(id);
  assign(det, id);
  reset(det);
  leerDetalle(det, rd);
  totalEmpresa:= 0;
  while (rd.clie.cod <> valorImposible) do begin
    writeln('Usuario nuevo');
    writeln('Codigo: ', rd.clie.cod);
    writeln('Nombre: ', rd.clie.nombre);
    writeln('Apellido: ', rd.clie.apellido);
    codActual:= rd.clie.cod;
    totalCliente:= 0;
    while ((rd.clie.cod <> valorImposible) and(rd.clie.cod = codActual)) do begin;
      anoActual:= rd.fecha.ano;
      montoAnual:= 0;
      while ((rd.clie.cod <> valorImposible) and(rd.clie.cod = codActual) and (rd.fecha.ano = anoActual)) do begin
        mesActual:= rd.fecha.mes;
        montoMensual:= 0;
        while(rd.clie.cod <> valorImposible) and(rd.clie.cod = codActual) and (rd.fecha.ano = anoActual)and (rd.fecha.mes = mesActual) do begin
          montoMensual:= montoMensual + rd.monto;
          leerDetalle(det, rd);
          end;
        writeln('El monto del mes numero ', mesActual, ' es: ', montoMensual:0:2);
        montoAnual:= montoAnual + montoMensual;
        end;
      writeln('El monto del año ', anoActual, ' es: ', montoAnual:0:2);
      totalCliente:= totalCliente + montoAnual;
      end;
    totalEmpresa:= totalEmpresa + totalCliente;
    end;
  writeln;
  writeln('El total recaudado por la empresa es de: ', totalEmpresa:0:2);
  close(det);
  readln;
end.
