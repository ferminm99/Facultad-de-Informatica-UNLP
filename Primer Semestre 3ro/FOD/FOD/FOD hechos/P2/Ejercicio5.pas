program ejercicio5;
const
     valorAlto = 9999;
Type
    producto = record
             cod: integer;
             precio: integer;
             stockM: integer;
             stockA: integer;
             nombre: string;
    end;
    venta = record
          cod:integer;
          cant:integer;
    end;
    ventas = file of venta;
    productos = file of producto;

procedure generarMaestro( var arc_p:productos; var arc_t:text);
var
   reg:producto;
begin
   reset(arc_t);
   rewrite(arc_p);
   while (not eof(arc_t)) do begin
         readln(arc_t,reg.cod,reg.precio,reg.stockA,reg.stockM,reg.nombre);
         write(arc_p,reg);
   end;
   close(arc_t);
   close(arc_p);
end;
procedure generarReporte(var arc_p:productos; var arc_reporte:text);
var
   reg:producto;
begin
     reset(arc_p);
     rewrite(arc_reporte);
     while (not eof(arc_p)) do begin
           read(arc_p,reg);
           writeln(arc_reporte,reg.cod,' ',reg.precio,' ',reg.stockA,' ',reg.stockM,' ',reg.nombre);
     end;
     close(arc_p);
     close(arc_reporte);
end;
procedure generarVentas(var txt:Text; var arc:ventas);
var
   reg:venta;
begin
     reset(txt);
     rewrite(arc);
     while (not eof(arc)) do begin
           read(txt,reg.cod,reg.cant);
           write(arc,reg);
     end;
     close(txt);
     close(arc);
end;
procedure mostrarVentas(var arc:ventas);
var
   reg:venta;
begin
     reset(arc);
     while (not eof(arc)) do begin
           read(arc,reg);
           writeln('cod producto: ',reg.cod, ' cantidad vendida: ',reg.cant);
     end;
end;
procedure leer(var arc:ventas; var reg:venta);
begin
     if (not eof (arc)) then
        read(arc,reg)
     else
         reg.cod:= valorAlto;
end;
procedure actualizarMaestro(var arc_p: productos; var arc_v:ventas);
var
   regP:producto; regV:venta;   aux,total:integer;
begin
     reset(arc_p);
     reset(arc_v);
     leer(arc_v,regV);
     while (regV.cod <> valorAlto) do begin
           aux:= regV.cod;
           total:= 0;
           while (regV.cod = aux) do begin
                 total:= total + regV.cant;
                 leer(arc_v,regV);
           end;
           read(arc_p,regP);
           while (regP.cod <> aux) do begin
                 read(arc_p,regP);
           end;
           regP.stockA:= regP.stockA - total;
           seek(arc_p,FilePos(arc_p)-1);
           write(arc_p,regP);
     end;
     close(arc_p);
     close(arc_v);
end;
procedure listarProductosSinStock(var arc:productos;var txt: text);
var
   reg:producto;
begin
     reset(arc);
     rewrite(txt);
     while (not eof(arc)) do begin
           read(arc,reg);
           write(txt,reg.cod,reg.precio,reg.stockA,reg.stockM,reg.nombre);
     end;
end;
var
   arc_t,arc_reporte,txt_ventas,txtSinStocks:text; arc_v:ventas; arc_p:productos;
begin
     Assign(arc_t,'productos.txt');
     Assign(arc_p,'productos');
     generarMaestro(arc_p,arc_t);  //inciso a
     Assign(arc_reporte,'reporte.txt');
     generarReporte(arc_p,arc_reporte);  //inciso b
     Assign(txt_ventas,'ventas.txt');
     Assign(arc_v,'ventas');
     generarVentas(txt_ventas,arc_v); //inciso c
     mostrarVentas(arc_v);  //inciso d
     actualizarMaestro(arc_p,arc_v); //inciso e
     Assign(txtSinStocks,'sinStocks.txt');
     listarProductosSinStock(arc_p,txtSinStocks); //inciso f
end.
