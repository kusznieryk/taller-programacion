{2.	Un cine posee la lista de películas que proyectará durante el mes de octubre. 
De cada película se conoce: código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror)
 y puntaje promedio otorgado por las críticas. Implementar un programa que contenga:
a.	Un módulo que lea los datos de películas y los almacene ordenados por código de película y agrupados por código de género, en una estructura de datos adecuada.
 La lectura finaliza cuando se lee el código de película -1. 
b.	Un módulo que reciba la estructura generada en el punto a y retorne una estructura de datos donde estén todas las películas almacenadas ordenadas por código de película.
}
program ej2;
const
	generos = 8;
type
	rango = 1..generos;
	pelicula = record 
		codPeli:integer;
		puntajeProm:real;
		end;
	
	lista = ^nodo;
	nodo = record
		dato:pelicula;
		sig:lista;
		end;
		
	vector = array [1..generos] of lista;
	
	lista2 = ^nodo2;
	
	nodo2 = record
		dato:pelicula;
		sig:lista2;
		end;
	
	arbol =^nodoA;
	nodoA = record
		HI:arbol;
		HD:arbol;
		dato:pelicula;
		end;
		
procedure cargarV(var v:vector);

	procedure leerR(var r:pelicula);
		begin
			r.codPeli:=random(7) - 1;
			if r.codPeli <> -1 then
				r.puntajeProm:=random(11);
		end;
		
	procedure inicializarV(var v:vector);
		var i:rango;
		begin
			for i:=1 to generos do 
				v[i]:=nil;
		end;
		
	procedure insertarOrdenado(var l:lista; r:pelicula);
		var act, ant, aux:lista;
		begin
			new(aux);
			aux^.dato:=r;
			act:=l;
			ant:=l;
			while ( act <> nil) and (act^.dato.codPeli < r.codPeli) do begin
				ant:=act;
				act:=act^.sig;
				end;
			
			if (l = act) then 
				l:=aux
			else
				ant^.sig:=aux;
			aux^.sig:=act;
		end;
		
	var r:pelicula; genero:rango;
	begin
		Randomize;
		inicializarV(v);
		leerR(r);
		while (r.codPeli <> -1) do begin
			genero:=random(8) +1;
			insertarOrdenado(v[genero], r);
			leerR(r);
			end;
	End;
	
procedure escribirV(v:vector);
	var i:rango;
	begin
	for i:=1 to generos do begin
		if v[i] = nil then writeln('el genero: ', i, ' esta vacio');
		while (v[i] <> nil) do begin
			writeln('genero: ', i);
			writeln('codigoPeli: ', v[i]^.dato.codPeli);
			writeln('puntaje promedio: ', v[i]^.dato.puntajeProm);
			v[i]:=v[i]^.sig;
			end;
		end;
end;
		
	
procedure merge(var l2:lista2; v:vector);

	procedure minimo(var v:vector; var minPeli:pelicula);
		var i, indiceMin:rango;
		begin
			minPeli.codPeli:=999;
			for i:=1 to generos do
				if (v[i] <> nil) and (v[i]^.dato.codPeli <= minPeli.codPeli) then begin
					indiceMin:=i;
					minPeli:=v[i]^.dato;
					end;
			
			if (minPeli.codPeli <> 999) then 
				v[indiceMin]:= v[indiceMin]^.sig;
				
		end;
		
	procedure insertarOrdenado2(var l:lista2; r:pelicula);
		var act, ant, aux:lista2;
		begin
			new(aux);
			aux^.dato:=r;
			act:=l;
			ant:=l;
			while ( act <> nil) and (act^.dato.codPeli < r.codPeli) do begin
				ant:=act;
				act:=act^.sig;
				end;
			
			if (l = act) then 
				l:=aux
			else
				ant^.sig:=aux;
			aux^.sig:=act;
		end;
		
	var minPeli:pelicula;
	begin
		l2:=nil;
		minimo(v, minPeli);
			while (minPeli.codPeli <> 999) do begin
				insertarOrdenado2(l2, minPeli);
				minimo(v, minPeli);
				end;
	end;
	
procedure escribirL(l:lista2);
	begin
		while (l <> nil) do begin
			writeln('codigo: ', l^.dato.codPeli);
			l:=l^.sig;
			end;
	end;
	
	
var v:vector; l2:lista2;
begin
	cargarV(v);
	escribirV(v);
	merge(l2, v);
	writeln('--------------------------------------');
	escribirL(l2);
	
end.
