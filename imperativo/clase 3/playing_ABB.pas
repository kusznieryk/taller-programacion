program aa;
Type
  arbol = ^nodo;
	nodo = record
   dato: integer;
   HI: arbol;
   HD: arbol;
  end;

  procedure agregar(var a:arbol; dato:integer);
  begin
  	if a=nil then begin
  		new(a);
  		a^.HD:=nil;
  		a^.HI:=nil;
  		a^.dato:=dato;
  	end
	  	else
	  		if dato<a^.dato then
	  			agregar(a^.Hi, dato)
	  			else agregar(a^.HD, dato);
  end;

  procedure impOrdenado(a:arbol);
  begin
  	if a<>nil then
  	begin
  		impOrdenado(a^.HI);
  		writeln(a^.dato);
  		impOrdenado(a^.HD);
  	end
  end;

  procedure cargarArbol(var a:arbol);
  var dato:integer;
  begin
  	randomize;
		a:=nil;
		dato:=random(100);
		while(dato<>0) do 
		begin
			agregar(a,dato);
			dato:=random(100);
		end;
  end;

  var a:arbol;
begin
	cargarArbol(a);
	impOrdenado(a);
end.