program ejercicio6;
const
     anioActual = 2020;
     valorAlto = 99999;
type
    cliente = record
            cod: integer;
            nombre: string;
            apellido: string;
            mes: integer;
            ano: integer;
            fecha: string;
            monto: real;
    end;
    archivo_cliente = file of cliente;

var
   mae: archivo_cliente;
   nombre: string;
begin
     writeln('Ingrese el nombre del archivo maestro: ');
     readln(nombre);
     assign(mae,df);
     reset(mae);
     readln;
     readln;
     readln;
end.


