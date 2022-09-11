{Una aerolínea dispone de un árbol binario de búsqueda con la información de sus empleados. De cada
empleado se conoce: Número de legajo, Dni, Categoría (1..20) y año de ingreso a la empresa. El árbol se
encuentra ordenado por número de dni. Se solicita:
a. Implementar un módulo que reciba el árbol de empleados, número de DNI “A”, número de DNI “B” y un
número de categoría, y retorne un vector ordenado por número de DNI. El vector debe contener el
número de DNI y número de legajo de aquellos empleados cuyo número de DNI se encuentra
comprendido entre los números de DNI recibidos (“A” y “B”, siendo “A” menor que “B”) y la categoría se
corresponda con la recibida por parámetro. Por norma de la empresa, cada categoría puede contar con
a lo sumo 250 empleados.
b. Implementar un módulo recursivo que reciba la información generada en “a” y retorne el promedio de
los números de legajo}

program parcialAerolinea;
const categorias = 20;
type
	rango = 1..categorias;
	empleado = record
		legajo:integer;
		dni:integer;
		categoria:rango;
		anioIngreso:integer;
		end;
		
	arbol = ^nodo;
	
	nodo = record
		HI:arbol;
		HD:arbol;
		dato:empleado;
		end;
		
	incisoA = record
		dni:integer;
		legajo:integer;
		end;
		
	vector = array [1..250] of incisoA;
	
procedure generarA(var a:arbol);
	procedure leerR(var r:empleado);
		begin
		r.dni:=random(30);
		if r.dni <> 0 then begin
			r.legajo:=random(15);
			r.categoria:=random(20) +1;
			r.anioIngreso:=random(50) +1950;
			end;
		end;
		
	procedure agregarHoja(var a:arbol; r:empleado);
		begin
			if (a = nil) then begin
				new(a);
				a^.HI:=nil;
				a^.HD:=nil;
				a^.dato:=r;
			end
			else
				if r.dni >=a^.dato.dni then agregarHoja(a^.HD, r)
				else agregarHoja(a^.HI, r);
		end;
		
	var r:empleado;
	begin
		Randomize;
		a:=nil;
		leerR(r);
		while r.dni <> 0 do begin
			agregarHoja(a, r);
			leerR(r);
		end;
	end;
	
procedure escribirA(a:arbol);
	begin
		if (a <> nil) then begin
			writeln('dni: ', a^.dato.dni,' legajo: ', a^.dato.legajo, ' categoria: ', a^.dato.categoria, ' anio ingreso: ', a^.dato.anioIngreso);
			escribirA(a^.HI);
			escribirA(a^.HD);
		end;
	end;
	
procedure escribirV(v:vector; diml:integer);
	var i:integer;
	begin
		for i:=1 to diml do
			writeln('dni: ', v[i].dni,' legajo: ', v[i].legajo);
	end;
	
procedure generarV(a:arbol; var v:vector; var diml:integer; dni1, dni2, numCategoria:integer);

	function fueEncontrado(v:vector; diml, dniComparacion:integer):boolean;
		var i:integer; aux:boolean;
		begin
			aux:=False;
			i:=1;
			while (i<= diml) and (aux = False) do begin
				aux:= (v[i].dni = dniComparacion);
				i:=i+1;
			end;
			fueEncontrado:=aux;
		end;
		
	procedure buscar(a:arbol; dni1, dni2, numCategoria:integer; var dni:integer; var v:vector);
		begin
			if a<> nil then 
				if dni1 > a^.dato.dni then buscar(a^.HD, dni1, dni2, numCategoria, dni,v)
				else 
					if dni2 < a^.dato.dni then buscar(a^.HI, dni1, dni2, numCategoria, dni,v)
					else 
						if (numCategoria = a^.dato.categoria) then begin
							if fueEncontrado(v,diml,a^.dato.dni) then begin
								buscar(a^.HI, dni1, dni2, numCategoria, dni,  v);
								if dni = -1 then 
									buscar(a^.HD, dni1, dni2, numCategoria, dni, v);
							end
							else begin
								diml:=diml+1;
								v[diml].dni:=a^.dato.dni;
								v[diml].legajo:=a^.dato.legajo;
								dni:=a^.dato.dni;
							end;
						end
						else
							if (numCategoria <> a^.dato.categoria) then begin
								buscar(a^.HI, dni1, dni2, numCategoria, dni, v);
								if dni = -1 then
									buscar(a^.HD , dni1, dni2, numCategoria, dni, v);
							end;	
	 
		end;
		
	var  dni:integer;
	begin
		diml:=0;
		dni:=-1;
		buscar(a, dni1, dni2, numCategoria, dni,  v);
		//creo que no es necesario hacer el diml <=250 porque ya el arbol no deberia traer mas de 250 empleados por categoria
		while (diml <250) and (dni <> -1) do begin
			dni:=-1;
			buscar(a, dni1, dni2, numCategoria, dni, v);
		end;
	end;
	

	
function promedioLegajo(v:vector; diml:integer):real;
		function sumatoriaLegajo (v:vector; diml:integer):integer;
			begin
				if diml > 0 then 
					sumatoriaLegajo:= v[diml].legajo + sumatoriaLegajo(v,diml-1)
				else
					sumatoriaLegajo:=0;
			end;
	
		begin
			if diml = 0 then promedioLegajo:=0
			else
				promedioLegajo:=sumatoriaLegajo (v,diml)/diml;
		end;
		
		
var a:arbol; v:vector; diml:integer; 
begin
	generarA(a);
	escribirA(a);
	writeln('---------------------');
	generarV(a, v,diml, 10, 40, 5);
	writeln('diml ', diml);
	escribirV(v, diml);
	writeln('------------');
	writeln(promedioLegajo(v,diml));

end.
