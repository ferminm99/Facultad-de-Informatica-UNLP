Type  
 lista = ^nodo;
 nodo = record
         datos: integer;
       	 sig: lista;
 end;
procedure imprimirEnOrden (l:lista);
begin
     if(l <> nil) then begin
           writeln (l^.datos);
           imprimirEnOrden (l^.sig);
     end;
end;
procedure imprimirInverso (l:lista);
begin
     if(l <> nil) then begin
           imprimirInverso (l^.sig);
           writeln (l^.datos);
     end;
end;
Procedure AgregarAdelante (var L:lista; per:integer);
Var
   nue:Lista;
Begin
   New(nue);
   nue^.datos:=per;
   nue^.sig:=L;
   L:=nue;
End;
procedure generarListaRecursiva (var l:lista);
var
   ale:integer;
begin
     ale:= random(20);
     if (ale <> 0) then begin
        agregarAdelante(l,ale);
        generarListaRecursiva (l);
     end;
end;
procedure generarlista(var l:lista);
var
   ale:integer;
begin
     ale:= random(20);
     while (ale <> 0) do begin
           agregarAdelante(l,ale);
           ale:= random(20);
     end;
end;
procedure maximo (l:lista; var max:integer);
begin
     if (l <> nil) then begin
        if (l^.datos > max) then
           max:= l^.datos;
        maximo (l^.sig,max);
     end;
end;
procedure minimo (l:lista; var min:integer);
begin
     if (l <> nil) then begin
        if (l^.datos < min) then
           min:= l^.datos;
        minimo (l^.sig,min);
     end;
end;
procedure buscar (l:lista;num:integer;var ok:boolean);
begin
     if (l <> nil) and (l^.datos <> num) then
        buscar (l^.sig,num,ok);
     if (l = nil) then
        ok:= false
     else
         if (l^.datos = num) then
            ok:= true;
end;

var
   l:lista; max,min,num:integer; ok:boolean;
begin
     randomize;
     generarLista (l);
     writeln ('lista en orden: ');
     imprimirEnOrden (l);
     writeln ('lista en orden inverso: ');
     imprimirInverso (l);
     max:= -1;
     min:= 99999;
     maximo (l,max);
     writeln ('numero maximo de la lista: ', max);
     minimo (l,min);
     writeln ('numero minimo de la lista: ', min);
     writeln ('se ingresa un numero a buscar: ');
     readln (num);
     buscar (l,num,ok);
     if (ok) then
        writeln ('el numero se encuentra en la lista')
     else
         writeln ('el numero no se encontro');
     readln();
end.

