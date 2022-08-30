Programa arboles;

Type
  arbol = ^nodo;

  nodo = record
   dato: integer;
   HI: arbol;
   HD: arbol;
  end;

Procedure crear (var A:árbol; num:integer); 
	//crear un arbol e inserta ordenado el nuevo elemento
	Begin
	  if (A = nil) then
	   begin
	      new(A);
	      A^.dato:= num; A^.HI:= nil; A^.HD:= nil;
	   end
	   else
	    if (num < A^.dato) then crear(A^HI,num)
	    else crear(A^.HD,num)   
	End;

Procedure enOrden ( a : arbol );
	//imprime los daos en oren. Creciente o decreciente segun en que oja agamos la isercion
	begin
	   if ( a<> nil ) then begin
		  enOrden (a^.HI);
		  write (a^.dato);
		  enOrden (a^.HD);
		 end;
	end;

Procedure preOrden ( a : arbol );
	//imprime primero el valor del nodo y luego, en orden, el valor de sus hijos
  begin
     if ( a<> nil ) then begin
      write (a^.dato);   
      preOrden (a^.HI);
      preOrden (a^.HD);
     end;
  end;

Procedure posOrden ( a : arbol );
	//imprime primero el valor de sus hijos, en orden, y despues el valor del nodo
	begin
	 if ( a<> nil ) then begin
	  posOrden (a^.HI);
	  posOrden (a^.HD);
	  write (a^.dato);
	   end;
	end;

Function Buscar (a:arbol; x:elemento): arbol; 
	//devuelve el nodo del elemento que buscamos
	 begin
	  if (a=nil) then 
	    Buscar:=nil
	  else if (x = a^.dato) then Buscar:=a
       else 

        if (x < a^.dato) then 
          Buscar:= Buscar(a^.hi ,x)
        else  
          Buscar:=Buscar(a^.hd ,x)
	end;
begin
	
end.