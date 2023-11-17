program ejer3;
Const
     valorAlto = 99999;
     df = 4;
Type
    producto = record
             cod:integer;
             precio:integer;
             stockA:integer;
             stockM:integer;
             desc:String;
    end;
    detalle = record
            cod:integer;
            cant:integer;
    end;
    productos = file of producto;
    detalles = file of detalle;
    vArchivos = array [1..df] of detalles;
    vReg = array[1..df]of detalle;

procedure leer (var arc:detalles;var reg: detalle);
begin
     if (not eof(arc)) then
        read(arc,reg)
     else
         reg.cod:= 99999;
end;

procedure leerDetalles(var v:vArchivos;var registros:vReg);
var
   i:integer; reg: detalle;
begin
     for i:= i to df do begin
         leer(v[i],reg);
         registros[i]:= reg;
     end;
end;

procedure minimo (var vArch:vArchivos; var regMin:detalle; var registros: vReg; sucursalMin:integer);
var
   i,min:integer; reg:detalle;
begin
     regMin.cod:= valorAlto;
     min:= 99999;
     for i:= 1 to df do begin
         if (registros[i].cod < min) then begin
            min:= registros[i].cod;
            sucursalMin:= i;
            regMin:= registros[i];
         end;
     end;
     if (regMin.cod <> valorAlto) then begin
        leer(vArch[sucursalMin],reg);
        registros[sucursalMin]:= reg;
     end;
end;

procedure Actualizar (var arc:productos);
var
 i:integer;
 vArch:vArchivos;
 registros:vReg;
 regMin:detalle;
 sucursal:integer;
 reg:producto;
 nombre:string;
begin
     for i:= 1 to df do begin
         writeln('ingrese nombre fisico para sucursal: ',i,' ');
         readln(nombre);
         Assign(vArch[i],nombre);
     end;
     reset(arc);
     for i:= 1 to df do
         reset(vArch[i]);
     leerDetalles(vArch,registros);
     minimo(vArch,regMin,registros,sucursal);
     read(arc,reg);
     while (regMin.cod <> valorAlto) do begin
           while (reg.cod <> regMin.cod) do begin
                 read(arc,reg);
           end;
           if (reg.stockA-regMin.cant >= 0) then begin
              reg.stockA:= reg.stockA-regMin.cant;
              seek(arc,FilePos(arc)-1);
              write (arc,reg);
           end
           else
                writeln('no se pudo enviar el producto a la sucursal: ',sucursal,' por falta de stock del codigo ', reg.cod);
           // Esto lo hice asumiendo que me piden el stock de los productos que se solicitan, luego de tomar la cantidad de productos requerida
           if (reg.stockA < reg.stockM) then
                    writeln('el producto codigo ', reg.cod, ' tiene un stock menor al minimo');
           minimo(vArch,regMin,registros,sucursal);
     end;
     close(arc);
     for i:= 1 to df do
         close(vArch[i]);
end;
var
   arc_p:productos;
begin
     Assign(arc_p,'productos');
     Actualizar(arc_p);
end.
