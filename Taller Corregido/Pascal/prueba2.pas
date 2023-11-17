program prueba2;
type
    recitales1 = record
               nombre: string;
               ano: integer;
               duracion: integer;
               entradas: integer;
    end;
    lista = ^nodo;
    nodo = record
         datos: recitales1;
         sig:lista;
    end;
    recitales2 = record
               nombre: string;
               duracion: integer;
               entradas: integer;
    end;
    lista2 = ^nodo2;
    nodo2 = record
           datos: recitales2;
           sig:lista2;
    end;
    arbol = ^nodoA;
    nodoA = record
          datos: lista2;
          ano: integer;
          hi: arbol;
          hd: arbol;
    end;
    lista3 = ^nodo3;
    nodo3 = record
          datos: recitales2;
          sig: lista3;
    end;

procedure leerRecital(var r: recitales1);
begin
     r.ano:=1979+random(41);
     writeln(r.ano);
     if ((r.ano-1979)<>0)then begin
        writeln('Ingrese el nombre de la banda: ');
        readln(r.nombre);
        r.duracion:= random(1000);
        r.entradas:= random(99999);
     end;
end;
procedure agregarAdelante(var l:lista;r: recitales1);
var
   nue:lista;
begin
     new(nue);nue^.datos:=r;nue^.sig:=l;l:=nue;
end;

procedure agregarOrdenado2(var l: lista2;r: recitales2);
var
   nue,act,ant: lista2;
begin
     new(nue);nue^.datos:=r;act:=l;ant:=l;
     while (act<>nil) and (act^.datos.nombre<r.nombre)do begin
           ant:=act;act:=act^.sig;
     end;
     if(act=ant)then l:=nue
     else ant^.sig:=nue;
     nue^.sig:=act;
end;

procedure agregarOrdenado(var l: lista3;r: recitales2);
var
   nue,act,ant: lista3;
begin
     new(nue);nue^.datos:=r;act:=l;ant:=l;
     while (act<>nil) and (act^.datos.nombre<r.nombre)do begin
           ant:=act;act:=act^.sig;
     end;
     if(act=ant)then l:=nue
     else ant^.sig:=nue;
     nue^.sig:=act;
end;

procedure crearLista(var l: lista);
var
   r: recitales1;
begin
     leerRecital(r);
     while ((r.ano-1979)<>0)do begin
           agregarAdelante(l,r);
           leerRecital(r);
     end;
end;
procedure insertar(var a: arbol;r: recitales1);
var
   nue: arbol;
   r2: recitales2;
begin
     if (a=nil)then begin
        new(nue);
        nue^.datos:=nil;
        nue^.hd:=nil;
        nue^.hi:=nil;
        a:=nue;
        r2.nombre:=r.nombre;
        r2.duracion:=r.duracion;
        r2.entradas:=r.entradas;
        a^.ano:=r.ano;
        agregarOrdenado2(a^.datos,r2);
     end
     else begin
          if (a^.ano>r.ano)then
             insertar(a^.hi,r)
          else begin
               if (a^.ano<r.ano)then
                 insertar(a^.hd,r)
               else begin
                    r2.nombre:=r.nombre;
                    r2.duracion:=r.duracion;
                    r2.entradas:=r.entradas;
                    agregarOrdenado2(a^.datos,r2);
               end;
          end;
     end;
end;
procedure crearArbol(var a: arbol;l: lista);
begin
     a:=nil;
     while (l<>nil)do begin
           insertar(a,l^.datos);
           l:=l^.sig;
     end;
end;
procedure agregarAdelante(var l: lista3;r: recitales2);
var
   nue: lista3;
begin
     new(nue);nue^.datos:=r;nue^.sig:=l;l:=nue;
end;
procedure verValorEntreRangos(a: arbol;inf,sup: integer;var l: lista3);
var
   aux: lista2;
begin
     if (a<>nil)then begin
        if (a^.ano>=inf)then begin
           if (a^.ano<=sup)then begin
              writeln('Ano: ',a^.ano);
              aux:=a^.datos;
              agregarOrdenado(l,aux^.datos);
              while (aux<>nil) do begin
                    writeln('El nombre de la banda es: ',aux^.datos.nombre);
                    writeln('La cantidad de entradas vendidas es: ',aux^.datos.entradas);
                    writeln('La duracion del recital fue: ',aux^.datos.duracion, ' minutos');
                    aux:=aux^.sig;
              end;
              verValorEntreRangos(a^.hi,inf,sup,l);
              verValorEntreRangos(a^.hd,inf,sup,l);
           end
           else
               verValorEntreRangos(a^.hi,inf,sup,l);
        end
        else
            verValorEntreRangos(a^.hd,inf,sup,l);

     end;
end;
procedure recorrer(l: lista3);
var
   cantR,cantE,cantD: integer;
begin
     cantR:=0;
     cantE:=0;
     cantD:=0;
     while (l<>nil) do begin
           cantR:=cantR+1;
           cantE:=cantE+l^.datos.entradas;
           cantD:=cantD+l^.datos.duracion;
           writeln('El nombre de la banda es: ',l^.datos.nombre);
           writeln('La duracion es: ',l^.datos.duracion);
           writeln('Las entradas vendidas fueron: ',l^.datos.entradas);
           l:=l^.sig;
     end;
     writeln('La cantidad de recitales es: ',cantR);
     writeln('La cantidad total de entradas vendidas es: ',cantE);
     writeln('La cantidad promedio de duracion de los recitales es: ',(cantD div cantR),' minutos');
end;
procedure enOrden(a: arbol);
var
   aux:lista2;
begin
     if (a<>nil)then begin
        enOrden(a^.hi);
        writeln('Ano: ',a^.ano);
        aux:=a^.datos;
        while (aux<>nil) do begin
              writeln('El nombre de la banda es: ',aux^.datos.nombre);
              writeln('La cantidad de entradas vendidas es: ',aux^.datos.entradas);
              writeln('La duracion del recital fue: ',aux^.datos.duracion, ' minutos');
              aux:=aux^.sig;
        end;
        enOrden(a^.hd);
     end;
end;
var
   l: lista;
   l3: lista3;
   a: arbol;
   inf,sup: integer;
begin
     randomize;
     l:=nil;
     l3:=nil;
     crearLista(l);
     crearArbol(a,l);
     enOrden(a);
     inf:=1980;
     sup:=1989;
     writeln('-----------------------------------------------------------');
     readln;
     readln;
     readln;
     readln;
     readln;
     writeln('La cantidad de valores entre los anos 1980 y 1989 son: ');
     verValorEntreRangos(a,inf,sup,l3);
     readln;
     readln;
     readln;
     recorrer(l3);
     readln;
     readln;
     readln;
     readln;
end.
