program prueba;
type
    viajes = record
           identificador: integer;
           codigo: string;
           fecha: integer;
           costo: integer;
    end;
    lista = ^nodo;
    nodo = record
         datos: viajes;
         sig: lista;
    end;
    viajes2 = record
           identificador: integer;
           fecha: integer;
           costo: integer;
    end;
    lista2 = ^nodo2;
    nodo2 = record
          datos: viajes2;
          sig: lista2;
    end;
    arbol = ^nodoA;
    nodoA = record
          hi: arbol;
          hd: arbol;
          codigo: string;
          cant: integer;
    end;
procedure leerViajes(var v: viajes);
begin
     writeln('Ingrese el codigo de localidad: ');
     readln(v.codigo);
     if (v.codigo<>'XXX')then begin
        v.identificador:=random(101);
        v.fecha:=random(2020);
        v.costo:=random(301);
     end;
end;
procedure agregarAdelante(var l: lista2;v: viajes2);
var
   nue:lista2;
begin
     new(nue);
     nue^.datos:=v;
     nue^.sig:=l;
     l:=nue;
end;
procedure agregarOrdenado(var l:lista;v:viajes);
var
   act,ant,nue: lista;
begin
     new(nue);
     nue^.datos:=v;
     act:=l;
     ant:=l;
     while (act<>nil) and (act^.datos.codigo<v.codigo)do begin
           ant:=act;
           act:=act^.sig;
     end;
     if(act=ant)then l:=nue
     else ant^.sig:=nue;
     nue^.sig:=act;
end;
procedure crearLista(var l: lista);
var
   v: viajes;
begin
     leerViajes(v);
     while (v.codigo<>'XXX')do begin
           agregarOrdenado(l,v);
           leerViajes(v);
     end;
end;
procedure insertar(var a: arbol;v: viajes);
var
   nue: arbol;
begin
     if (a=nil)then begin
        new(nue);
        nue^.hi:=nil;
        nue^.hd:=nil;
        a:=nue;
        a^.codigo:=v.codigo;
        a^.cant:=1;
     end
     else begin
          if (a^.codigo>v.codigo)then
             insertar(a^.hi,v)
          else if(a^.codigo<v.codigo)then
               insertar(a^.hd,v)
               else begin
                    a^.cant:=a^.cant+1
               end;
     end;
end;
procedure crearArbol(var a: arbol;l: lista);
begin
     while (l<>nil) do begin
           insertar(a,l^.datos);
           l:=l^.sig;
     end;
end;

//procedure cuantosViajes(a: arbol;valor: string;var cant: integer);
//begin
//     if (a<>nil)and(cant=0) then begin
//        if (valor=a^.codigo)then
//           cant:=a^.cant;
//        cuantosViajes(a^.hi,valor,cant);
//       cuantosViajes(a^.hd,valor,cant);
//    end;
//end;
procedure cuantosViajes(a:arbol; valor: string;var cant: integer);
begin
     if (a <> nil) then begin
        if (a^.codigo >= valor) then begin
           if (a^.codigo <= valor) then begin
              cant:=a^.cant;
              cuantosViajes (a^.HI, valor,cant);
              cuantosViajes (a^.HD, valor,cant);
           end
           else
               cuantosViajes (a^.HI, valor,cant);
        end
        else
            cuantosViajes (a^.HD, valor,cant);
     end;
end;
procedure cantidadViajes(a: arbol;valor: string;var cant: integer);
begin
     if (a<>nil)then begin
           if (a^.codigo<valor)then begin
              cant:=a^.cant+cant;
              cantidadViajes(a^.hi,valor,cant);
              cantidadViajes(a^.hd,valor,cant);
           end
           else
               cantidadViajes(a^.hi,valor,cant);
     end;
end;
procedure enOrden(a: arbol);
var
   aux:lista2;
begin
     if (a<>nil) then begin
        enOrden(a^.hi);
        writeln('-----------------------------------');
        writeln('Codigo de destino: ',a^.codigo);
        writeln('Cantidad de viajes: ',a^.cant);
        enOrden(a^.hd);
     end;
end;
var
   l: lista;
   a: arbol;
   valor: string;
   cant: integer;
begin
     Randomize;
     l:=nil;
     a:=nil;
     crearLista(l);
     crearArbol(a,l);
     enOrden(a); {Esto lo hice para comprobar el arbol}
     writeln('Inserte el codigo del que quiere saber la cantidad de viajes: ');
     readln(valor);
     cant:=0;
     cuantosViajes(a,valor,cant);
     writeln('La cantidad de viajes que realizo el codigo destino es: ',cant);
     writeln('Ingrese el codigo de destino del que quiere saber la cantidad de viajes con codigo menor a este: ');
     readln(valor);
     cant:=0;
     cantidadViajes(a,valor,cant);
     writeln('La cantidad de viajes realizados por codigos de destino menor a ',valor, ' son ',cant);
     readln;
end.
