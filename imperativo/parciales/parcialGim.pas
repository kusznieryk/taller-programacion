{Una cadena de gimnasios que tiene 5 sucursales necesita procesar las asistencias de los clientes.
Implementar un programa en Pascal con:
a) Un módulo que lea la información de las asistencias realizadas en cada sucursal y que genere
un árbol ordenado por dni de cliente, donde cada nodo contenga dni de cliente, còdigo y la
cantidad total de minutos asistidos en todas las sucursales. De cada asistencia se lee: código
de sucursal (1..5), dni del cliente, código del cliente, fecha y cantidad de minutos que asistió. La
lectura finaliza con el dni de cliente -1, el cual no se procesa.
b) Un módulo que reciba el árbol generado en a) y un dni de cliente y devuelva una lista con los
dni de los clientes cuyo dni es mayor al dni ingresado y el total de minutos es impar}

program parcialG;

const sucursales = 5;

type
	rango = 1..sucursales;
	
	asistencias = record
		dni:integer;
		codigo:integer;
		totalMinutos:integer;
		end;
		
	arbol = ^nodo;
	
	nodo = record
		HI:arbol;
		HD:arbol;
		dato:asistencias;
		end;
	
	vector = array [rango] of arbol;
	
	lista = ^nodoL;
	
	nodoL = record
	sig:lista;
	dato:integer;
	end;
	
	
procedure generarV(var v:vector);
	procedure leerR(var r:asistencias);
		begin
			r.dni:=random(9) - 1;
			if r.dni <> -1 then begin
				r.codigo:=random(15);
				r.totalMinutos:=random(60);
				writeln('dni: ', r.dni, ' codigo: ', r.codigo, ' total minutos: ', r.totalMinutos);
			end;
		end;
		
	procedure initV(var v:vector);
		var i:rango;
		begin
			for i:=1 to sucursales do 
				v[i]:=nil;
		end;
		
	procedure agregarHoja(var a:arbol;  r:asistencias; var yahabia:boolean);
		begin
			if (a = nil) then begin
				new(a);
				a^.HI:=nil;
				a^.HD:=nil;
				a^.dato:=r;
			end
			else
				if (r.dni < a^.dato.dni) then agregarHoja(a^.HI, r, yahabia)
				else
					if (r.dni > a^.dato.dni) then agregarHoja(a^.HD, r, yahabia)
					else begin
						a^.dato.totalMinutos:= a^.dato.totalMinutos + r.totalMinutos;
						yahabia:=true;
						writeln('qsys ', a^.dato.totalMinutos);
						end;
		end;
		
	procedure buscar(a:arbol; r:asistencias; var minutosFaltantes:integer); 
		begin
			if a <> nil then 
				if a^.dato.dni > r.dni then buscar(a^.HI, r, minutosFaltantes)
				else	
					if a^.dato.dni < r.dni then buscar(a^.HD, r, minutosFaltantes)
					else
						begin
						minutosFaltantes:= a^.dato.totalMinutos;
						writeln('al nodo que contiene ', a^.dato.totalMinutos, ' le sumamos: ', r.totalMinutos);
						a^.dato.totalMinutos:= a^.dato.totalMinutos + r.totalMinutos;
						end;
		end;
		
		
	procedure actualizarMinutos (v:vector; r:asistencias; sucur:rango; yahabia:boolean);  
		var i:rango; minutosFaltantes:integer;
		begin
			minutosFaltantes:=0;
			for i:=1 to sucursales do 
				if i <> sucur then
					buscar(v[i], r, minutosFaltantes);
					
			if (minutosFaltantes > 0) and (yahabia = false) then begin
				writeln('debug ', minutosFaltantes); 
				r.totalMinutos:=minutosFaltantes;
				
			    buscar(v[sucur], r, minutosFaltantes);
			end;
			
		end;
		
	//esta solucion me parece mala pero no se me ocurre una mejor
	var r:asistencias; {fecha:integer;} sucur:rango; yahabia:boolean;
	begin
		initV(v);
		Randomize;
		leerR(r);
		while (r.dni <> -1) do begin
			yahabia:=false;
		    //fecha:=random(50) + 1973; no se porque dice que se lee si despues no se usa 
			sucur:=random(5) +1;
			writeln('sucursal', sucur);
			agregarHoja(v[sucur], r, yahabia);
			writeln(yahabia);
			actualizarMinutos(v, r, sucur, yahabia);
			leerR(r);
		end;
	end;
	
	
procedure escribirV(v:vector);
	procedure escribirA(a:arbol);
		begin
			if a <> nil then begin
				writeln('dni: ', a^.dato.dni, ' codigo: ', a^.dato.codigo, ' total minutos: ', a^.dato.totalMinutos);
				escribirA(a^.HI);
				escribirA(a^.HD);
			end;
		end;
		
	var i:rango;
	begin
		writeln('------------------');
		for i:=1 to sucursales do begin
			writeln('sucusal nro: ', i);
			escribirA(v[i]);
		end;
	end;
	
procedure generoL(v:vector; var l:lista);

	procedure agregarAdelante(var l:lista; r:integer);
		var aux:lista;
		begin
		new(aux);
		aux^.dato:=r;
		aux^.sig:=l;
		l:=aux;
		end;
		
	procedure requisitos(a:arbol; dni:integer; var l:lista);
		begin
			if (a <> nil) then
				if a^.dato.dni <= dni then requisitos(a^.HD, dni, l)
				else begin
					if (a^.dato.dni mod 2 = 1) then agregarAdelante(l, a^.dato.dni);
					requisitos(a^.HD, dni, l);
				end;
		end;
		
	var i:rango; dni:integer;
	begin
		l:=nil;
		readln(dni);
		for i:=1 to 5 do 
			requisitos(v[i], dni, l)
	end;
	
procedure escribirl(l:lista);
	begin
	writeln('--------------');
	while (l <> nil) do begin
		writeln('dni: ', l^.dato);
		l:=l^.sig;
	end;
	end;
	
var v:vector; l:lista;
begin
	generarV(v);
	escribirV(v);
	generoL(v, l);
	escribirl(l);
end.
