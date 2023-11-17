program ejer3;
Const
     valorAlto = 99999;
     df = 3;
Type
    producto = record
             cod:integer;
             nombre: string;
             codigoBarra: integer;
             categoria:integer;
             stockA:integer;
             stockM:integer;
             desc:String;
    end;
    detalle = record
            cod:integer;
            cant:integer;
            desc: string;
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
 sucursal,codigo:integer;
 reg:producto;
 nombre:string;
begin
     for i:= 1 to df do begin
         writeln('ingrese nombre fisico para sucursal: ',i,' ');
         readln(nombre);
         Assign(vArch[i],nombre);
         reset(vArch[i]);
     end;
     reset(arc);
     leerDetalles(vArch,registros);
     minimo(vArch,regMin,registros,sucursal);
     while (regMin.cod <> valorAlto) do begin
           codigo:= regMin.codigo;
           while (codigo = regMin.codigo) do begin
                 read(arc,reg);
                 writeln('El nombre del producto es: ',reg.nombre,' el codigo es: ',reg.codigo,' la categoria es: ',reg.categoria);
                 while (reg.cod <> regMin.cod) do begin
                       read(arc,reg);
                       writeln('El nombre del producto es: ',reg.nombre,' el codigo es: ',reg.codigo,' la categoria es: ',reg.categoria);
                 end;
                 if (reg.stockA-regMin.cant >= 0) then
                    reg.stockA:= reg.stockA-regMin.cant;
                 else
                     reg.stockA:= reg.stockA-reg.stockA;
                 seek(arc,FilePos(arc)-1);
                 write (arc,reg);
                 //Esto no lo pide explicitamente pero lo informo porque me parece lo mas logico para saber si quedo o no stock suficiente despues del pedido
                 if (reg.stockA < reg.stockM) then
                    writeln('el producto codigo ', reg.cod, ' tiene un stock menor al minimo');
                 minimo(vArch,regMin,registros,sucursal);
           end;
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
