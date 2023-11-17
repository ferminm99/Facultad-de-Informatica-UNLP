5) Convengamos que las clases anonimas son un tipo concreto de clase anidada. La modificacion pedida se puede 
	hacer de forma relativamente sencilla moviendo la definicion de StackIiterator dentro del metodo iterator.
	Evidentemente quitandole el nombre y devolviendola via un new en su definicion para que cumpla con las 
	caracteristicas de una clase anonima.
	IMPORTANTE: Las clases anonimas SI tienen restricciones respecto a la cantidad de interfaces o extenciones 
	que tienen, a lo mucho 1. Osea elige entre:
		- Implementa 1 interfaz
		- Extiende 1 clase
	Necesariamente una, pero no ambas.
	
	a) En una situacion en la que solo se use en un lugar, ya que se tendria que definir otra vez.
	
	b) Las clases anonimas no admiten el uso de constructores, ya que la clase no tiene nombre y el 
	constructor debe tener el mismo nombre que la clase. Pero en caso de que se requiera realizar algun tipo 
	de inicializacion se puede hacer uso de Bloques de Inicializacion. Los cuales funcionan como un 
	constructor para las clases anonimas. Simplemente es un bloque delimitado por '{' y '}' en medio de 
	su declaracion. 