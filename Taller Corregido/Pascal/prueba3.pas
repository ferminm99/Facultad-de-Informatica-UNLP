program prueba3;
const
     maxA= 100;
type
    alumno = record
           legajo: integer;
           asistencias: integer;
           nota: integer;
    end;
    vector = array[1..maxA]of alumno;
    lista = ^nodo;
    nodo = record
         legajo: integer;
         sig: lista;
    end;
procedure leerAlumno(var a: alumno);
begin
     a.legajo:=random(20);
     if (a.legajo<>0)then begin
        a.asistencias:=random(41);
        a.nota:=random(11);
     end;
end;
procedure crearVector(var v: vector;var diml: integer);
var
   a: alumno;
begin
     leerAlumno(a);
     while (a.legajo<>0)do begin
           diml:=diml+1;
           v[diml]:=a;
           leerAlumno(a);
     end;
end;
procedure ordenar(var v: vector;diml: integer);
var
   i,j,num: integer;
begin
     for i:= 2 to diml do begin
         num:=v[i].legajo;
         j:=i-1;
         while (j>0) and (v[j].legajo>num) do begin
               v[j+1]:=v[j];
               j:=j-1
         end;
         v[j+1].legajo:=num;
     end;
end;
procedure busquedaDicotomica(v: vector;ini,fin: integer;legajo: integer);
var
   pos: integer;
begin
     if (ini>fin)then
        writeln('El legajo no esta')
     else begin
          pos:=(ini+fin) div 2;
          if (legajo<v[pos].legajo)then begin
             fin:=pos-1;
             busquedaDicotomica(v,ini,fin,legajo);
          end
          else
          if (legajo>v[pos].legajo)then begin
             ini:=pos+1;
             busquedaDicotomica(v,ini,fin,legajo);
          end
             else
                  writeln('El numero ingresado se encuentra en la posicion ', pos, ' del vector.', ' La nota de su examen es: ',v[pos].nota)
      end;
end;
procedure agregarAdelante(var l: lista;legajo: integer);
var
   nue: lista;
begin
     new(nue);nue^.legajo:=legajo;nue^.sig:=l;l:=nue;
end;
procedure crearLista(var l:lista;v: vector;asis,i,diml: integer);
begin
     i:=i+1;
     if (i<diml)then begin
        if (v[i].asistencias<asis)then
           agregarAdelante(l,v[i].legajo);
        crearLista(l,v,asis,i,diml);
     end;
end;
procedure imprimirV(v: vector;diml: integer);
var
   i: integer;
begin
     for i:= 1 to diml do begin
         writeln('-----------------------------');
         writeln('El i es: ',i);
         writeln('Legajo: ',v[i].legajo);
         writeln('Asistencias: ',v[i].asistencias);
         writeln('Nota: ',v[i].nota);
     end;
end;
procedure imprimirL(l: lista);
begin
     while (l<>nil)do begin
           writeln('Legajo: ',l^.legajo);
           l:=l^.sig;
     end;
end;
var
   l: lista;
   v: vector;
   diml,i,legajo,asis,ini,fin: integer;
begin
     Randomize;
     l:=nil;
     i:=0;
     diml:=0;
     crearVector(v,diml);
     ordenar(v,diml);
     imprimirV(v,diml);
     writeln('Ingrese el legajo del alumno para saber su nota: ');
     readln(legajo);
     ini:=1;
     fin:=diml;
     busquedaDicotomica(v,ini,fin,legajo);
     writeln('Ingrese la cantidad de asistencias que quiere establecer como maxima para la creacion de la lista');
     readln(asis);
     crearLista(l,v,asis,i,diml);
     imprimirL(l);
     readln;
end.

