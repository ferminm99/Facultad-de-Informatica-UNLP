Const
     df = 15;
     valorAlto = 99999;
type
    emp = record
        departamento:integer;
        division:integer;
        nroE:integer;
        categoria:integer;
        horasE:integer;
    end;
    regis = record
        categoria:integer;
        valorHora:integer;
    end;
    vector = array[1..df]of integer;
    empleados = file of emp;
procedure generarVectorHoras(var v:vector; var txt:Text);
var
   reg:regis;
begin
     reset(txt);
     while (not eof(txt)) do begin
           readln(txt,reg.categoria,reg.valorHora);
           v[reg.categoria]:= reg.valorHora;
     end;
     close(txt);
end;
procedure leer (var arc:empleados; var reg:emp);
begin
     if (not eof(arc)) then
        read(arc,reg)
     else
         reg.departamento:= valorAlto;
end;
procedure informar(var arc:empleados; v:vector);
var
   reg:emp;
   totalHorasD,totalMontoD,totalHorasDiv,totalMontoDiv,dep,divi,totalHorasEmp,totalMontoEmp,nroE:integer;
begin
     reset(arc);
     leer(arc,reg);
     while (reg.departamento <> valorAlto) do begin
           totalHorasD:= 0;
           totalMontoD:= 0;
           dep:= reg.departamento;
           writeln('departamento: ',dep);
           while (reg.departamento = dep) do begin
                 totalHorasDiv:= 0;
                 totalMontoDiv:= 0;
                 divi:= reg.division;
                 writeln ('division : ',divi);
                 while (reg.departamento = dep) and (reg.division = divi) do begin
                       totalHorasEmp:= 0;
                       totalMontoEmp:= 0;
                       nroE:= reg.nroE;
                       write ('numero empleado: ',nroE);
                       //para este while si asumieramos que el empleado solo puede pertenecer a una division y depto en especifico podría quedar solo con "reg.nroE = nroE"
                       while (reg.departamento = dep) and (reg.division = divi) and (reg.nroE = nroE) do begin
                             totalHorasEmp:= reg.horasE+ totalHorasEmp;
                             totalMontoEmp:= totalMontoEmp + (v[reg.categoria]*reg.horasE);
                             leer(arc,reg);
                       end;
                       write ('total horas: ',totalHorasEmp);
                       writeln ('importe a cobrar: ',totalMontoEmp);
                       totalHorasDiv:= totalHorasDiv + totalHorasEmp;
                       totalMontoDiv:= totalMontoDiv+ totalMontoEmp;
                 end;
                 writeln ('total horas division: ',totalHorasDiv);
                 writeln ('total monto division: ',totalMontoDiv);
                 totalHorasD:= totalHorasD + totalHorasDiv;
                 totalMontoD:= totalMontoD + totalMontoDiv;
           end;
           writeln('total horas departamento: ',totalHorasD);
           writeln('total monto departamento: ', totalMontoD);
     end;
end;
var
   v:vector;   arc:empleados;  txt: Text;
begin
     Assign(arc,'empleados');
     Assign(txt,'textoHoras');
     generarVectorHoras(v,txt);
     informar(arc,v);
end.
