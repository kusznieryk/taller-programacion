{Una agencia dedicada a la venta de autos ha organizado su stock y, dispone en papel de la información de los autos en venta.
Implementar un programa que:
a)	Genere un árbol binario de búsqueda ordenado por patente identificatoria del auto en venta.
*  Cada nodo del árbol debe contener patente, año de fabricación (2010..2018), la marca y el modelo.
b)	Invoque a un módulo que reciba el árbol generado en a) y una marca y retorne la cantidad de autos de dicha marca que posee la agencia. Mostrar el resultado. 
c)	Invoque a un módulo que reciba el árbol generado en a) y retorne una estructura con la información de los autos agrupados por año de fabricación.
d)	Contenga un módulo que reciba el árbol generado en a) y una patente y devuelva el año de fabricación del auto con dicha patente. Mostrar el resultado. 

}

program ej2;

type
	rango = 2010..2018;
	
	auto = record
		patente:integer;
		anio:rango;
		marca:string;
		modelo:string;
		end;
		
	arbol = ^nodo;

	nodo = record
		HI:arbol;
		HD:arbol;
		dato:auto;
		end;
		
	vector = array [rango] of arbol;
	
procedure agregarHoja(var a:arbol; r:auto);
		begin
			if (a =nil) then begin	
				new(a);
				a^.HI:=nil;
				a^.HD:=nil;
				a^.dato:=r;
			end
			else
				if a^.dato.patente > r.patente then agregarHoja(a^.HI, r)
				else agregarHoja(a^.HD, r);
		end;
		
procedure generarA(var a:arbol);
	procedure leerR(var r:auto);
		begin
			r.patente:=random(10);
			if r.patente <> 0 then begin
				r.anio:=random(9) + 2010;
				writeln('patente: ', r.patente, ' anio: ', r.anio);
				writeln('ingresar marca y modelo: ');
				readln(r.marca);
				readln(r.modelo);
			end;
		end;
		
	{procedure agregarHoja(var a:arbol; r:auto);
		begin
			if (a =nil) then begin	
				new(a);
				a^.HI:=nil;
				a^.HD:=nil;
				a^.dato:=r;
			end
			else
				if a^.dato.patente > r.patente then agregarHoja(a^.HI, r)
				else agregarHoja(a^.HD, r);
		end;}
		
	var r:auto;
	begin
		Randomize;
		a:=nil;
		leerR(r);
		while (r.patente <> 0) do begin
			agregarHoja(a, r);
			leerR(r);
		end;
	end;
	
function cantMarca(a:arbol; marca:string):integer;
	begin
		if (a <> nil) then begin
			if a^.dato.marca = marca then 
				cantMarca:=cantMarca(a^.HI, marca) + cantMarca(a^.HD,marca) + 1
			else
				cantMarca:=cantMarca(a^.HI, marca) + cantMarca(a^.HD,marca)
		end
		else
			cantMarca:=0;
	end;
	
procedure generarV(var v:vector; a:arbol);
	procedure initV(var v:vector);
		var i:rango;
		begin
			for i:=2010 to 2018 do
				v[i]:=nil;
		end;
	
	procedure buscoYagrego (var v:vector; a:arbol);
		begin
			if (a <> nil) then begin
				//deberia agregar a un vector de listas porque no pide especificamente por uno eficiente para la busqueda
				//agregarAdelante(v[a^.dato.anio], a^.dato);
				agregarHoja(v[a^.dato.anio], a^.dato);
				buscoYagrego(v, a^.HD);
				buscoYagrego(v, a^.HI);
			end;
		end;
		
	begin
		initV(v);
		buscoYagrego(v, a);
	end;
	
procedure escribirV(v:vector);
	procedure escribirA(a:arbol);
		begin
			if a <> nil then begin
				escribirA(a^.HI);
				writeln('patente: ', a^.dato.patente, ' marca: ', a^.dato.marca);
				escribirA(a^.HD);
			end;
		end;
		
	var i:rango;
	begin
	for i:=2010 to 2018 do begin
		writeln('anio: ', i);
		escribirA(v[i]);
		end;
	end;
	
	
procedure reciboPdevuelvoAnio(a:arbol; patente:integer; var anio:integer);
	begin
		if (a <> nil) then begin
			if patente < a^.dato.patente then reciboPdevuelvoAnio(a^.HI,  patente, anio)
			else
				if patente > a^.dato.patente then reciboPdevuelvoAnio(a^.HD, patente, anio) 
				else
					anio:=a^.dato.anio;
		end
		else
			anio:=-1;
	end;
	
var a:arbol; v:vector; anio:integer;
begin
generarA(a);
writeln(cantMarca(a, 'hola'));
generarV(v,a);
escribirV(v);
reciboPdevuelvoAnio(a, 6, anio);
writeln(anio);
end.
		
