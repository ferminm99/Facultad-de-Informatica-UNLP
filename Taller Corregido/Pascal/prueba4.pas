program prueba4;
const
     dimf= 5;
type
    producto = record
             codigo: integer;
             cantidad: integer;
             cliente: integer;
             dia: integer;
    end;
    lista = ^nodo;
    nodo = record
         datos: producto;
         sig: lista;
    end;
    vector = array[1..dimf] of lista;
    producto2 = record
              codigo: integer;
              total: integer;
    end;
    lista2 = ^nodo2;
    nodo2 = record
          datos: producto2;
          sig: lista2;
    end;
procedure iniciar(var v: vector);
var
   i: integer;
begin
     for i:= 1 to dimf do
         v[i]:=nil;
end;
procedure agregarOrdenado(var l: lista;p: producto);
var
   act,ant,nue: lista;
begin
     new(nue);nue^.datos:=p;act:=l;ant:=l;
     while (act<>nil) and (act^.datos.codigo<p.codigo) do begin
           ant:=act;act:=act^.sig;
     end;
     if(act=ant)then l:=nue
     else ant^.sig:=nue;
     nue^.sig:=act;
end;
procedure leerProducto(var p: producto);
begin
     p.codigo:= random(21);
     if ((p.codigo-1)<>-1)then begin
        p.cantidad:=random(200);
        p.cliente:=random(100);
        p.dia:=random(5)+1;
     end;
end;
procedure crearVector(var v: vector);
var
   p: producto;
begin
     leerProducto(p);
     while ((p.codigo-1)<>-1)do begin
           agregarOrdenado(v[p.dia],p);
           leerProducto(p);
     end;
end;
procedure determinarMin(var min: producto2;var v: vector);
var
   i,j: integer;
begin
     min.codigo:=21;
     for i:= 1 to dimf do begin
         if (v[i]<>nil) then begin
            if (v[i]^.datos.codigo<min.codigo)then begin
               min.codigo:=v[i]^.datos.codigo;
               min.total:=v[i]^.datos.cantidad;
               j:=i;
             end;
         end;
     end;
     if (min.codigo<>21)then
        v[j]:=v[j]^.sig;
end;
procedure agregarUltimo(var l,ult: lista2;p: producto2);
var
   nue: lista2;
begin
     new(nue);nue^.datos:=p;nue^.sig:=nil;
     if (l<>nil)then
         ult^.sig:=nue
     else
         l:=nue;
     ult:=nue;
end;
procedure nuevaLista(var l: lista2;v: vector);
var
   p2,p: producto2;
   ult: lista2;
begin
     determinarMin(p,v);
     while (p.codigo<>21) do begin
           p2.total:=0;
           p2.codigo:=p.codigo;
           while (p2.codigo=p.codigo)do begin
                 p2.total:=p2.total+p.total;
                 determinarMin(p,v);
           end;
           agregarUltimo(l,ult,p2);
     end;
end;
procedure ImprimirNL (l:lista2);
begin
     writeln();
     writeln('Lista nueva : ');
     writeln();
     while (l <> nil) do begin
           writeln ('codigo : ',l^.datos.codigo, ',cantidad :  ',l^.datos.total);
           l:= l^.sig;
     end;
end;
procedure maximo(l: lista2;var max,i: integer);
begin
     if (l<>nil)then begin
        if (max<l^.datos.total)then begin
           max:=l^.datos.total;
           i:=l^.datos.codigo;
        end;
        l:=l^.sig;
        maximo(l,max,i);
     end;
end;
procedure ImprimirVector (v:vector);
var
   i:integer;
begin
     for i:= 1 to dimf do begin
         writeln();
         writeln('Vector ',i,' : ');
         writeln();
         while (v[i] <> nil) do begin
               writeln ('Codigo de producto : ',v[i]^.datos.codigo,', Codigo de cliente : ',v[i]^.datos.cliente,', cantidad: ',v[i]^.datos.cantidad);
               v[i]:= v[i]^.sig;
         end;
     end;
end;
var
   l: lista2;
   v: vector;
   max,i:integer;
begin
     iniciar(v);
     crearVector(v);
     ImprimirVector(v);
     l:=nil;
     nuevaLista(l,v);
     ImprimirNL(l);
     max:=-1;
     i:=0;
     maximo(l,max,i);
     writeln('El maximo es: ',max, ' del codigo: ' ,i);
     readln;
end.

