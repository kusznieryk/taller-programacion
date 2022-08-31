{
	a. Un módulo que lea información de alumnos de Taller de Programación y almacene en una estructura de 
			datos sólo a aquellos alumnos que posean año de ingreso posterior al 2010. De cada alumno se lee legajo, 
			DNI y año de ingreso. La estructura generada debe ser eficiente para la búsqueda por número de legajo. 

	b. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos
	   cuyo legajo sea inferior a un valor ingresado como parámetro. 

	c. Un módulo que reciba la estructura generada en a. e informe el DNI y año de ingreso de aquellos alumnos
		 cuyo legajo esté comprendido entre dos valores que se reciben como parámetro. 

	d. Un módulo que reciba la estructura generada en a. y retorne el DNI más grande.

	e. Un módulo que reciba la estructura generada en a. y retorne la cantidad de alumnos con legajo impar.
}
 program xd;
 const ANIO_ING_MINIMO=2010;
 type 
 	alumno= record
 		legajo : Integer;
 		dni:integer;
 		anioIngr:Integer;
 	end;
 	abb=^nodoArbol;
 	nodoArbol= record
 		dato : alumno;
 		HI:abb;
 		HD:abb
 	end;


 //inciso a 	
 	procedure cargarArbol(var A:abb);
	  procedure leerAl (var al:alumno);
		  begin
		  	//write('Ingrese el numero de legajo: ');
		  	//readln(al.legajo);
		  	al.legajo:=Random(11)-1;
		  	if(al.legajo<>-1) then begin
		  		//write('Ingrese el tal y el talp: ');
		  		al.dni:=Random(1000);
		  		//readLn(al.dni);
		  		//readLn(al.anioIngr);
		  		al.anioIngr:=random(100)+2000;
		  	end
		  end;
	  procedure agregar(var A:abb; aux:alumno);
		 begin
			  if (A = nil) then
				   begin
				      new(A);
				      A^.dato:= aux; A^.HI:= nil; A^.HD:= nil;
				   end
				   else
				    if (aux.legajo< A^.dato.legajo) then agregar(A^.HI,aux)
				    else agregar(A^.HD,aux)   
			  end; 
	  var aux:alumno;
	  begin
	  Randomize;
  	a:=nil;
  	leerAl(aux);
  	while(aux.legajo<>-1) do
  	begin
  		if aux.anioIngr>= ANIO_ING_MINIMO then agregar(A, aux);
			leerAl(aux);
  	end;
 		end;

	procedure impDniIng(al:alumno);
		begin
				  writeln (al.dni);
				  writeln (al.anioIngr);
				  writeln('--------------------------------------------------------------');
		end;
	Procedure enOrden ( a : abb );
		//imprime los daos en oren. Creciente o decreciente segun en que hoja agamos la isercion
		begin
		   if ( a<> nil ) then begin
			  enOrden (a^.HI);
			  impDniIng(a^.dato);
			  enOrden (a^.HD);
			 end;
		end;

	//inciso b
	procedure informarMenorQue(a:abb; num:integer);
		begin
			if(a<>nil) then begin
				if a^.dato.legajo <= num then
				begin 
					enOrden(a^.HI);
					impDniIng(a^.dato);
					informarMenorQue(a^.HD, num);
				end else informarMenorQue(a^.HI,num);
			end
		end;

	//inciso c
	procedure informarEntre(a:abb; min:integer;max:integer);
		begin
			if(a<>nil) then begin
				if a^.dato.legajo > min then
					informarEntre(a^.HI, min,max);
				if (a^.dato.legajo <= max) then 
					begin
						if(a^.dato.legajo>= min )then 
							impDniIng(a^.dato);
						informarEntre(a^.HD,min,max);
						end;
			end
		end;
  
  //inciso d
	function maximoDni(a:abb): integer;
		var maxI,maxD,aux:integer;
		begin
		if a<>nil then
			begin
				maxI:=maximoDni(a^.HI);
				maxD:=maximoDni(a^.HD);
				if maxI>maxD then aux:= maxI
				else aux:= maxD;
				if aux>a^.dato.dni then 
					maximoDni:=aux 
				else maximoDni:=a^.dato.dni;
			end
		else maximoDni:=-1;
		end;

	//inciso e
	function cantLegajoImp(a:abb): Integer;
		begin
			if(a<>nil) then cantLegajoImp:=((cantLegajoImp(a^.HI)+ cantLegajoImp(a^.HD)) +(a^.dato.legajo mod 2))
			else cantLegajoImp:=0
		end;

var a:abb; num:integer; num2:integer;
 begin
 	//cargarArbol(a); //inciso a
 	//enOrden(a); //imprimo el arbol
 	//write('Desde que legajo escribir: ');
 	//readln(num);
 	//write('hasta que legajo escribir: ');
 	//readln(num2);
 	//informarMenorQue(a,num); //inciso b
 	//informarEntre(a,num, num2); //inciso c
 	//writeLn('El maximo dni es: ',maximoDni(a)); //inciso d
 	//writeln(cantLegajoImp(a)); //inciso e
 end.