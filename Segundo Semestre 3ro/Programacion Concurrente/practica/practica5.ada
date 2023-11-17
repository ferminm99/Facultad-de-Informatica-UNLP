// 1. Se requiere modelar un puente de un solo sentido, el puente solo soporta el peso de 5
// unidades de peso. Cada auto pesa 1 unidad, cada camioneta pesa 2 unidades y cada camión
// 3 unidades. Suponga que hay una cantidad innumerable de vehículos (A autos, B
// camionetas y C camiones).
// a. Realice la solución suponiendo que todos los vehículos tienen la misma prioridad.
// b. Modifique la solución para que tengan mayor prioridad los camiones que el resto de los
// vehículos.

//a)

Procedure program is

TASK TYPE Vehiculo is
    Entry pasar();
End Vehiculo;
TASK Puente is
    Entry asignarPesoID(peso: OUT integer, id: OUT integer);
    Entry solicitarEntrada(id: IN integer, peso: IN integer);
    Entry notificarSalida(peso: IN integer);
End puente;

arrayAutos: array (1..A) of Vehiculo;
arrayCamionetas: array (1..B) of Vehiculo;
arrayCamiones: array (1..C) of Vehiculo;

TASK BODY Vehiculo is
    peso: integer;
    ID: integer;
Begin
    puente.asignarPesoID(peso, ID)
    puente.solicitarEntrada(peso, id);
    accept pasar();
    //pasa el puente
    puente.notificarSalida();
End Vehiculo

TASK BODY Puente is
    idAutos: integer:= 0;
    idCamiones: integer:= 0;
    idCamionetas: integer:= 0;
    pesoRestante: integer := 5;
    colaVehiculos: queue;
    auxID: integer;
    auxPeso: integer;
Begin
    for i in 1..(A+B+C)*3 loop
        select
            accept asignarPesoID(peso: OUT integer, ID: OUT integer) do
                peso := asignarPeso(); //random entre 1, 2 y 3, con cantidad máxima de 1 = A, 2 = B y 3 = C
                case peso is
                    when 1 => id = idAutos; idAutos++; 
                    when 2 => id = idCamionetas; idCamionetas++;
                    when 3 => id = idCamiones; idCamiones++;
                end case;               
            end asignarPesoID;
        or
            accept solicitarEntrada(peso: IN integer, id: IN integer) do
                if pesoRestante >= peso then
                    pesoRestante := pesoRestante - peso;
                    case peso is
                        when 1 => arrayAutos[id].pasar();
                        when 2 => arrayCamionetas[id].pasar();
                        when 3 => arrayCamiones[id].pasar();
                    end case;  
                else
                    push(colaVehiculos, (id, peso));
                end if
            end solicitarEntrada;
        or
            accept notificarSalida(peso: IN integer) do
                pesoRestante := pesoRestante + peso;
                top(colaVehiculos(auxID, auxPeso)); //top copia el primer elemento de la cola pero no lo saca
                while(auxPeso < pesoRestante) loop
                    case auxPeso is
                        when 1 => arrayAutos[auxID].pasar();
                        when 2 => arrayCamionetas[auxID].pasar();
                        when 3 => arrayCamiones[auxID].pasar();
                    end case;
                    pop(colaVehiculos, (auxID, auxPeso));
                    top(colaVehiculos, (auxID, auxPeso));
                end loop;
            end notificarSalida;
        end select;
    end loop;
End Puente 
Begin
End program;


// b) jajaxd


// 2. Se quiere modelar la cola de un banco que atiende un solo empleado, los clientes llegan y si
// esperan más de 10 minutos se retiran.


Procedure program is

TASK TYPE Cliente;
TASK Empleado is
    Entry solicitarAtencion();
End Empleado;

arrayClientes:= array (1..N) of Clientes;

TASK BODY Cliente is
    id: integer;
Begin
    select
        empleado.solicitarAtencion();
    OR DELAY 10min
        null
End Cliente;


TASK BODY Empleado is
Begin
    for i in 1..N loop
        accept solicitarAtencion();
    end loop;
End Empleado;

Begin
End program;


3. Se debe modelar un buscador para contar la cantidad de veces que aparece un número
dentro de un vector distribuido entre las N tareas contador. Además existe un
administrador que decide el número que se desea buscar y se lo envía a los N contadores
para que lo busquen en la parte del vector que poseen.

Procedure programa is

TASK TYPE Contador is
end Contador;

TASK Administrador is
    Entry asignarNumero(num: OUT integer);
    Entry informarCantidad(num: IN integer);
end Administrador;

arrayContadores := array (1..N) of Contador;

TASK BODY Contador is
    vectorNumeros: array (1..V) of integer := inicializarVector;
    cant: integer := 0;
    num: integer;
Begin
    Administrador.asignarNumero(num);
    for i in 1..V loop
        if arrayNumeros(i) = num then
            cant++;
        end if;
    end loop
    Administrador.informarCantidad(cant);
end Contador;

TASK BODY Administrador is
    numeroElegido: integer := elegirNumero;
    cantTotal: integer := 0;
Begin
    for i in 1..N*2 loop
        select
            accept asignarNumero(num: OUT integer) do
                num := numeroElegido;
            end asignarNumero;
        or
            accept informarCantidad (num: IN integer) do
                cantTotal := cantTotal + num;
            end informarCantidad;
        end select;
    end loop;
end Administrador;

Begin
    Null
End programa;

4. Se dispone de un sistema compuesto por 1 central y 2 procesos. Los procesos envían
señales a la central. La central comienza su ejecución tomando una señal del proceso 1,
luego toma aleatoriamente señales de cualquiera de los dos indefinidamente. Al recibir una
señal de proceso 2, recibe señales del mismo proceso durante 3 minutos.
El proceso 1 envía una señal que es considerada vieja (se deshecha) si en 2 minutos no fue
recibida.
El proceso 2 envía una señal, si no es recibida en ese instante espera 1 minuto y vuelve a
mandarla (no se deshecha).

Procedure programa is

TASK Central is
    Entry enviarSeñal1 (señal: IN Señal);
    Entry enviarSeñal2 (señal: IN Señal);
    Entry terminoTiempo;
end Central; 

TASK Proceso1;
TASK Proceso2;

TASK Clock is
    Entry iniciar;
end Clock; 

TASK BODY Central is
    termino: boolean;
Begin
    accept enviarSeñal1(señal: IN Señal) do
        procesar(Señal);
    end enviarSeñal1
    loop
        select
            accept enviarSeñal1 (señal: IN Señal) do
                //procesa la señal
            end enviarSeñal1
        or
            accept enviarSeñal2 (señal: IN Señal) do
                //procesa la señal
            end enviarSeñal2;
            termino := false;
            clock.iniciar();
            while (!termino) loop
                select
                    accept terminoTiempo() do
                        termino := true;
                    end terminoTiempo;
                or
                    when (terminoTiempo'count = 0) => accept enviarSeñal2 (señal: IN Señal) do
                        //procesa la señal
                    end enviarSeñal2
                end select;
            end loop;
        end select;
    end loop;
End Central;

TASK BODY Proceso1 is
    señal: Señal;
Begin
    loop
        señal := generarSeñal;
        select
            Central.enviarSeñal1(Señal);
        or delay 2min
            null
        end select;
    end loop;
End Proceso1;

TASK BODY Proceso2 is
    señal: Señal;
    enviada: boolean := false
Begin
    loop
        señal := generarSeñal;
        enviada := false;
        while !enviada loop
            select
                Central.enviarSeñal2(Señal);
                enviada := true;
            else
                delay 1min
            end select;
        end loop;
    end loop;
End Proceso2;

TASK BODY Clock is
    loop
        accept iniciar();
        delay 3min
        Administrador.terminoTiempo();
    end loop;
end Clock;

Begin
    Null
End programa;


5. En una clínica existe un médico de guardia que recibe continuamente peticiones de
atención de las E enfermeras que trabajan en su piso y de las P personas que llegan a la
clínica ser atendidos.

Cuando una persona necesita que la atiendan espera a lo sumo 5 minutos a que el médico lo
haga, si pasado ese tiempo no lo hace, espera 10 minutos y vuelve a requerir la atención del
médico. Si no es atendida tres veces, se enoja y se retira de la clínica.

Cuando una enfermera requiere la atención del médico, si este no lo atiende inmediatamente
le hace una nota y se la deja en el consultorio para que esta resuelva su pedido en el
momento que pueda. Cuando la petición ha sido recibida por el médico o la nota 
ha sido dejada en el escritorio, continúa trabajando y haciendo más peticiones.

El médico atiende los pedidos teniendo dándoles prioridad a los enfermos que llegan para ser
atendidos. Cuando atiende un pedido, recibe la solicitud y la procesa durante un cierto
tiempo. Cuando está libre aprovecha a procesar las notas dejadas por las enfermeras.

Process programa is

TASK Medico is
    Entry atencionEnfermos;
    Entry atencionEnfermeras;
end Medico;

TASK TYPE Enfermera;

TASK TYPE Persona;

TASK Escritorio is
    Entry entregarNota;
    Entry almacenarNota;
end Escritorio;

arrayEnfermeras := array (1..E) of Enfermera;
arrayPersonas := array (1..P) of Persona;

TASK BODY Medico is
Begin
    loop
        select
            accept atencionEnfermos do
                //atiende el enfermo
            end atencion; 
        or
            when (atencionEnfermos'size = 0) => accept atencionEnfermeras do
                //atiende la enfermera
            end atencion;
        or
            when (atencionEnfermos'size = 0) and (atencionEnfermeras'size = 0) => Escritorio.entregarNota(nota);
            //procesa la nota
    end loop;
end Medico;

TASK BODY Enfermera is
Begin
    loop
        //trabaja
        select
            medico.atencionEnfermeras;
        else:
            nota := hacerNota;
            Escritorio.almacenarNota(nota);
    end loop;
end Enfermera;


TASK BODY Persona is
    atendido: boolean := false;
    cant: integer := 0;
Begin
    while (!atendido or cant < 3) loop
        select
            medico.atencionEnfermos;
            atendido := true;
        or delay 5
            select 
                medico.atencionEnfermos;
                atendido := true;
            or delay 10
                cant++;
        end select
    end loop;
end Persona;

TASK BODY Escritorio is
    cola: queue;
Begin
    select
        accept almacenarNota(nota: IN Nota) do
            push(cola, nota);
        end almacenarNota;
    or
        when (cola'size > 0) => accept entregarNota(nota: OUT Nota) do 
            pop(cola, nota);
        end entregarNota;
end Escritorio;

Begin
    null
End programa;


6. En una empresa hay 5 controladores de temperatura y una Central. Cada controlador toma
la temperatura del ambiente cada 10 minutos y se la envía a una central para que analice el
dato y le indique que hacer. Cuando la central recibe una temperatura que es mayor de 40
grados, detiene a ese controlador durante 1 hora.

Process program is

TASK Central is
    Entry analizarDato(dato: IN Dato, respuesta: OUT string);
End Central;

TASK TYPE Controlador;

arrayControladores: array (1..5) of Controlador;

TASK BODY Central is
Begin
    loop
        accept analizarDato(dato: IN Dato, respuesta: OUT string) do
            if (dato'temperatura > 40) then
                respuesta = "emergencia";
            else
                respuesta = analizar(dato); 
            end if;
        end analizarDato;
    end loop;
End Central;

TASK BODY Controlador is
    dato: Dato;
    respuesta: texto;
Begin
    loop
        dato = tomarTemperatura;
        Central.analizarDato(dato, respuesta);
        if (respuesta = "emergencia") then
            delay 60min
        else
            hacerRespuesta
            delay 10min
        end if;
    end loop;
End Controlador;

Begin
    Null
End program;

7. En un sistema para acreditar carreras universitarias, hay UN Servidor que atiende pedidos
de U Usuarios de a uno a la vez y de acuerdo al orden en que se hacen los pedidos.
Cada usuario trabaja en el documento a presentar, y luego lo envía al servidor; espera la
respuesta del mismo que le indica si está todo bien o hay algún error. Mientras haya algún
error, vuelve a trabajar con el documento y a enviarlo al servidor. Cuando el servidor le
responde que está todo bien, el usuario se retira. Cuando un usuario envía un pedido espera
a lo sumo 2 minutos a que sea recibido por el servidor, pasado ese tiempo espera un minuto
y vuelve a intentarlo (usando el mismo documento).


Process program is

TASK Servidor is
    Entry procesarDocumento(documento: IN Documento, respuesta: OUT texto);
End Servidor;

TASK TYPE Usuario;

arrayUsuario: array (1..U) of Usuario;

TASK BODY Servidor is
Begin
    loop
        accept procesarDocumento(documento: IN Documento, respuesta: OUT texto) do
            respuesta = procesar(documento);
        end procesarDocumento;
    end loop;
End Servidor;

TASK BODY Usuario is
    respuesta: texto := "error";
    documento: Documento;
Begin
    while (respuesta = "error") loop
        documento := trabajarDocumento; //trabaja el documento   
        select
            Servidor.procesarDocumento(documento, respuesta);
        or delay 2min
            delay 1min
            Servidor.procesarDocumento(documento, respuesta);      
    end loop;
End Usuario;

Begin
    Null
End program;

8. Hay una empresa de servicios que tiene un Recepcionista, N Clientes que hacen reclamos y
E Empleados que los resuelven. 
Cada vez que un cliente debe hacer un reclamo, espera a que el Recepcionista lo atienda y le dé un Número de Reclamo, 
y luego continúa trabajando.
Los empleados cuando están libres le piden un reclamo para resolver al Recepcionista y lo
resuelven. 
El Recepcionista recibe los reclamos de los clientes y les entrega el Número de
Reclamo, o bien atiende los pedidos de más trabajo de los Empleados (cuando hay reclamos
sin resolver le entrega uno al empleado para que trabaje); siempre le debe dar prioridad a los
pedidos de los Empleados. 
Nota: los clientes, empleados y recepcionista trabajan infinitamente.

Process program is

TASK Recepcionista is
    Entry pedirProblema(problema: OUT Problema)
    Entry darNumero(problema: IN Problema, numeroReclamo: OUT integer)
End Recepcionista;

TASK TYPE Cliente;

TASK TYPE Empleado;

arrayClientes: array (1..N) of Cliente;
arrayEmpleados: array (1..E) of Empleado;

TASK BODY Recepcionista is
    cola: queue;
Begin
    loop
        select
            when (cola'size > 0) => accept pedirProblema(problema: OUT Problema) do
                problema:= pop(cola, problema);
            end pedirProblema;
        or
            when (pedirProblema'count = 0) or (cola'size = 0) => accept darNumero(problema: IN Problema, numeroReclamo: OUT integer) do
                push(cola, problema);
                numeroReclamo:= generarNumeroReclamo;
            end darNumero;
        end select;
    end loop;
End Recepcionista;

TASK BODY Cliente is
    problema: Problema;
    numeroReclamo: integer;
Begin
    loop
        trabajar
        Recepcionista.darNumero(problema, numeroReclamo);
        trabajar
    end loop;
End Cliente; 

TASK BODY Empleado is
    problema: Problema;
Begin
    loop
        Recepcionista.pedirProblema(problema);
        resolverProblema(problema);
    end loop;
End Empleado;

Begin
    Null
End program;