program asd;
type
    banda = record
          nombre: string;
          ano: integer;
          duracion: integer;
          cantidad: integer;
    end;
    lista = ^nodo;
    nodo = record
         elem: banda;
         sig: lista;
    end;
    recital = record
            cantidad: integer;
            promedio: integer;
            entradas: integer;
    end;
    lista2 = ^nodo2;
    nodo2 =  record
          elem: string;
          sig: lista2;
    end;
    arbol = ^nodoA;
    nodoA = record
          hi: arbol;
          hd: arbol;
          lista: lista2;
          ano: integer;
          cosas: recital;
    end;
procedure leerBanda(var b: banda);
begin
     b.ano:= 1950 + random(70);
     if ((b.ano - 1950)<>0)then begin
        readln(b.nombre);
        b.duracion:= random(200);
        b.cantidad:= random(10000);
     end;
end;
procedure agregarOrdenado(var l: lista;b: banda);
var
   nue,ant,act: lista;
begin
     new(nue);nue^.elem:=b;act:=l;ant:=l;
     while (act<>nil) and (act^.elem.nombre<b.nombre)do begin
           ant:=act;act:=act^.sig;
     end;
     if (act=ant)then
        l:=nue
     else
         ant^.sig:=nue;
     nue^.sig:=act;
end;
procedure agregarUltimo(var l,ult: lista2;r: string);
var
   nue: lista2;
begin
     new(nue);nue^.elem:=r;nue^.sig:=nil;
     if(l=nil)then l:=nue
     else ult^.sig:=nue;
     ult:=nue;
end;
procedure crearLista(var l: lista);
var
   b: banda;
begin
     leerBanda(b);
     while ((b.ano - 1950)<>0) do begin
           agregarOrdenado(l,b);
           leerBanda(b);
     end;
end;
procedure insertar(var a: arbol;b: banda);
var
   ult: lista2;
   nue: arbol;
begin
     if (a=nil)then begin
        new(nue);
        nue^.hi:=nil;
        nue^.hd:=nil;
        nue^.lista:=nil;
        a:=nue;
        a^.ano:=b.ano;
        a^.cosas.cantidad:=1;
        a^.cosas.entradas:=b.cantidad;
        a^.cosas.promedio:=b.duracion;
        agregarUltimo(a^.lista,ult,b.nombre);
     end
     else begin
          if (b.ano<a^.ano)then
             insertar(a^.hi,b)
          else begin
               if (b.ano>a^.ano) then
                  insertar(a^.hd,b)
               else begin
                   a^.cosas.cantidad:=a^.cosas.cantidad + 1;
                   a^.cosas.entradas:=b.cantidad;
                   a^.cosas.promedio:=b.duracion + a^.cosas.promedio;
                   a^.cosas.promedio:= a^.cosas.promedio div a^.cosas.cantidad;
                   agregarUltimo(a^.lista,ult,b.nombre);
               end;
          end;
     end;
end;


procedure recorrerLista(l: lista);
begin
     while (l<>nil) do begin
           writeln(l^.elem.ano);
           writeln(l^.elem.cantidad);
           writeln(l^.elem.duracion);
           l:=l^.sig;
     end;
end;


procedure crearArbol(var a : arbol);
var
   l: lista;
begin
     l:=nil;
     crearLista(l);
     while (l<>nil) do begin
           insertar(a,l^.elem);
           l:=l^.sig;
     end;
end;
procedure imprimirEntre(a: arbol;inf,sup: integer);
var
   aux: lista2;
begin
     if (a<>nil)then begin
        if (a^.ano>=inf)then begin
           if (a^.ano<=sup)then begin
              writeln('Ano: ',a^.ano);
              aux:=a^.lista;
              while (aux<>nil) do begin
                    writeln(aux^.elem, ' - ');
                    aux:=aux^.sig;
              end;
              imprimirEntre(a^.hi,inf,sup);
              imprimirEntre(a^.hd,inf,sup);
           end
           else
               imprimirEntre(a^.hi,inf,sup);
        end
        else
            imprimirEntre(a^.hd,inf,sup);
     end;
end;
procedure imprimirEntre(a: arbol);
var
   aux: lista2;
begin
     if (a<>nil)then begin
        if (a^.ano>=1980)then begin
           if (a^.ano<=1989)then begin
              writeln('Ano: ',a^.ano);
              writeln('Cantidad de recitales: ',a^.cosas.cantidad);
              writeln('Cantidad de entradas totales vendidas: ',a^.cosas.entradas);
              writeln('Duracion promedio de los recitales: ',a^.cosas.promedio);
              aux:=a^.lista;
              while (aux<>nil) do begin
                    write(aux^.elem, ' - ');
                    aux:=aux^.sig;
              end;
              imprimirEntre(a^.hi);
              imprimirEntre(a^.hd);
           end
           else
               imprimirEntre(a^.hi);
        end
        else
            imprimirEntre(a^.hd);
     end;
end;
procedure recorrer(a: arbol);
var
   aux: lista2;
begin
     if (a<>nil) then begin
        recorrer(a^.hi);
        writeln('Ano: ',a^.ano);
        writeln('Cantidad de recitales: ',a^.cosas.cantidad);
        writeln('Cantidad de entradas totales vendidas: ',a^.cosas.entradas);
        writeln('Duracion promedio de los recitales: ',a^.cosas.promedio);
        aux:=a^.lista;
        while (aux<>nil) do begin
              write(aux^.elem, ' - ');
              aux:=aux^.sig;
        end;
        recorrer(a^.hd);
     end;
end;
var
   a: arbol;
   inf,sup: integer;
begin
     a:=nil;
     crearArbol(a);
     recorrer(a);
     writeln('Ingrese el ano inferior: ');
     readln;
     readln;
     readln;
     readln;
     readln;
     writeln('Ingrese el ano inferior: ');
     readln(inf);
     writeln('Ingrese el ano superior: ');
     readln(sup);
     imprimirEntre(a,inf,sup);
     imprimirEntre(a);
     readln;
     readln;
     readln;
     readln;
     readln;
     readln;
     readln;
     readln;
end.
