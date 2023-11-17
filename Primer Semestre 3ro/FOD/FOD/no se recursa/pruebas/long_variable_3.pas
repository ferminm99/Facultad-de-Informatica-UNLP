procedure escribirRegistro(var aPer: file; var r:rPersona);
	var
		tam:integer;
	begin
	    tam:= length(r.apellido)+ 1;  // Guarda la longitud del string luego el campo completo
	    BlockWrite(aPer,tam,sizeOf(tam)); // Guarda tantos bytes como ocupa el tipo de dato integer usado para tam
	    BlockWrite(aPer,r.apellido,tam);
	    
	    tam:= length(r.nombre)+ 1;
	    BlockWrite(aPer,tam,sizeOf(tam));
	    BlockWrite(aPer,r.nombre,tam);
	    
	    BlockWrite(aPer,r.fnac,sizeOf(r.fnac)); // Guarda tantos bytes como ocupa el tipo de dato longint (fnac)

	end;

procedure leerRegistro (var aPer:file; var r:rPersona);
	var
		tam:integer;
	begin
	    BlockRead(aPer,tam,sizeOf(tam));   // lee la longitud del String apellido
	    BlockRead(aPer,r.apellido,tam);   // lee el contenido
	    
	    BlockRead(aPer,tam,sizeOf(tam));   // lee longitud del String nombre
	    BlockRead(aPer,r.nombre,tam); // lee el contenido
	    
	    BlockRead(aPer,r.fnac,sizeOf(r.fnac));     // lee la fecha de nacimiento

	end;

