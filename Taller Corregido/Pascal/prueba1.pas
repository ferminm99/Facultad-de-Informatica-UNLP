program prueba1;
type
    venta = record
          codigoC: integer;
          codigoP: integer;
          monto: integer;
    end;
    lista1 = ^nodo1;
    nodo1 = record
          datos: venta;
          sig: lista1;
    end;
    lista2 = ^nodo2;
    nodo2 = record
          codigoP: integer;
          sig:lista2;
    end;
    arbol = ^nodoA;
    nodoA = record
          totalA: integer;
          codC: integer;
          datos: lista2;
          hi: arbol;
          hd: arbol;
    end;

procedure agregarAdelante(var l:lista1;v: venta);
var
   nue: lista1;
begin
     new(nue);nue^.datos:=v;nue^.sig:=l;l:=nue;
end;
procedure agregarAdelante2(var l:lista2;cp: integer);
var
   nue: lista2;
begin
     new(nue);nue^.codigoP:=cp;nue^.sig:=l;l:=nue;
end;
{
procedure agregarOrdenado(var l: lista1;v: venta);
var
   nue,act,ant: lista1;
begin
     new(nue);nue^.datos:=v;
     act:=l;ant:=l;
     while (act<>nil) and (act^.datos.codigoC<v.codigoC) do begin
           ant:=act;act:=act^.sig;
     end;
     if (act=ant)then l:=nue
     else ant^.sig:=nue;
     nue^.sig:=act;
end;
procedure agregarOrdenado2(var l: lista2;codP: integer);
var
   nue,act,ant: lista2;
begin
     new(nue);nue^.codigoP:=codP;
     act:=l;ant:=l;
     while (act<>nil) and (act^.codigoP<codP) do begin
           ant:=act;act:=act^.sig;
     end;
     if (act=ant)then l:=nue
     else ant^.sig:=nue;
     nue^.sig:=act;
end;
}
procedure leerVentas(var v: venta);
begin
     v.monto:= random(200);
     if (v.monto<>0)then begin
        v.codigoC:= random(301);
        v.codigoP:= random(11);
     end;
end;
procedure crearLista(var l: lista1);
var
   v: venta;
begin
     randomize;
     leerVentas(v);
     while (v.monto<>0) do begin
           agregarAdelante(l,v);
           leerVentas(v);
     end;
end;
procedure mostrarLista(l: lista1);
begin
     while (l<>nil) do begin
           writeln('Codigo de cliente: ',l^.datos.codigoC);
           writeln('Codigo de pizza: ',l^.datos.codigoP);
           writeln('Monto: ',l^.datos.monto);
           l:=l^.sig;
     end;
end;

function buscar(l:lista2;c: integer):boolean;
var
   ok: boolean;
begin
     ok:=false;
     while (l<>nil)and(ok=false)do begin
           if (c=l^.codigoP)then
              ok:=true
           else
               l:=l^.sig;
     end;
     buscar:=ok;
end;

procedure insertar (var a:arbol; v:venta);
var
   nue: arbol;
begin
     if (a = nil) then begin
        new (nue);
        nue^.hi:= nil;
        nue^.hd:= nil;
        nue^.datos:= nil;
        a:= nue;
        a^.codC:= v.codigoC;
        a^.totalA:= v.monto;
        agregarAdelante2(a^.datos,v.codigoP);
     end
     else begin
         if (a^.codC > v.codigoC) then
            insertar (a^.hi,v)
         else begin
             if (a^.codC < v.codigoC) then
                insertar (a^.hd,v)
             else begin
                  a^.totalA:= a^.totalA + v.monto;
                  if ((buscar(a^.datos,v.codigoP))=false)then
                     agregarAdelante2(a^.datos,v.codigoP);
             end;
         end;
     end;
end;
procedure generarArbol (var a:arbol; l:lista1);
begin
     a:= nil;
     while (l <> nil) do begin
           insertar (a,l^.datos);
           l:=l^.sig;
     end;
end;
procedure enOrden(a: arbol);
var
   aux:lista2;
begin
     if (a<>nil) then begin
           enOrden(a^.hi);
           writeln('---------------------');
           writeln('Codigo cliente: ',a^.codC);
           writeln('Total abonado: ',a^.totalA);
           aux:=a^.datos;
           while (aux<>nil) do begin
                 writeln('Codigo de pizza: ',aux^.codigoP);
                 aux:=aux^.sig;
           end;
           enOrden(a^.hd);
     end;
end;
procedure verValoresEnRango(a: arbol;inf,sup: integer);
var
   aux: lista2;
begin
     if (a <> nil) then begin
        if (a^.codC>=inf)then begin
           if (a^.codC<=sup)then begin
              aux:=a^.datos;
              while (aux<>nil)do begin
                    writeln('El codigo de pizza es: ',aux^.codigoP);
                    aux:=aux^.sig;
              end;
              verValoresEnRango(a^.hi,inf,sup);
              verValoresEnRango(a^.hd,inf,sup);
           end
           else
               verValoresEnRango(a^.hi,inf,sup);
        end
        else
            verValoresEnRango(a^.hd,inf,sup);
     end;
end;
procedure verCantClientes(a: arbol;inf,sup: integer;var cant: integer);
begin
     if (a<>nil) then begin
        if (a^.totalA>=600) and (a^.totalA<=1100)then begin
           cant:=cant+1;
        end;
        verCantClientes(a^.hi,inf,sup,cant);
        verCantClientes(a^.hd,inf,sup,cant);
     end;
end;

var
   l1: lista1;
   a: arbol;
   cant,inf,sup: integer;
begin
     l1:=nil;
     crearLista(l1);
     mostrarLista(l1);
     generarArbol(a,l1);
     writeln('Arbol: ');
     enOrden(a);
     writeln('Valores de codigo de pizza entre 170 y 300: ');
     inf:=170;
     sup:=300;
     verValoresEnRango(a,inf,sup);
     cant:=0;
     inf:=600;
     sup:=1100;
     verCantClientes(a,inf,sup,cant);
     writeln('La cantidad de clientes que abonaron entre 600 y 1100 son: ',cant);
     readln;
end.
