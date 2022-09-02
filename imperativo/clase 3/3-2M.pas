{2.	Escribir un programa que:
a. Implemente un módulo que lea información de ventas de un comercio. De cada venta se lee código de producto, fecha y cantidad de unidades vendidas. 
* La lectura finaliza con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de producto.
* 
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por código de producto. 
* Cada nodo del árbol debe contener el código de producto y la cantidad total vendida.
               Nota: El módulo debe retornar los dos árboles.
b. Implemente un módulo que reciba el árbol generado en i. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.
c. Implemente un módulo que reciba el árbol generado en ii. y un código de producto y retorne la cantidad total de unidades vendidas de ese producto.
}

program ej3;

type
	venta = record 
		codProd:integer;
		fecha:integer;
		unidadesV:integer;
		end;
	
	venta2 = record
		codProd:integer;
		totalVentas:integer;
		end;
		
	arbol2 = ^nodo2;
	
	nodo2 = record
		dato:venta2;
		HI:arbol2;
		HD:arbol2;
		end;
		
	arbol = ^nodo;
	
	nodo = record
		dato:venta;
		HI:arbol;
		HD:arbol;
		end;
		
procedure crearArbol(var a:arbol; var a2:arbol2);

	procedure leerR(var r:venta);
		begin
		writeln('ingrese codigo de producto');
		readln(r.codProd);
		if r.codProd <> 0 then begin
			{writeln('ingrese fecha');
			readln(r.fecha);}
			r.fecha:=random(20);
			writeln('ingrese cant de unidades vendidas');
			readln(r.unidadesV);
			end;
		end;
	
	{procedure agregarNodo(var a:arbol; r:venta);
		begin
			if (a = nil) then begin
				new(a);
				a^.dato:=r;
				a^.HI:=nil;
				a^.HD:=nil;
				end
			else
				if (r.codProd < a^.dato.codProd) then agregarNodo(a^.HI, r)
				else	
					agregarNodo(a^.HD, r);
		end;}
		
		procedure agregarNodos(var a:arbol; var a2:arbol2; r:venta);
			begin
			
				if ( a2 = nil) then begin
					new(a2);
					a2^.dato.codProd:=r.codProd;
					a2^.dato.totalVentas:=r.unidadesV;
					a2^.HI:=nil;
					a2^.HD:=nil;
					end
					else if (a = nil ) and (a2^.dato.codProd = r.codProd) then
					  a2^.dato.totalVentas:= a2^.dato.totalVentas + r.unidadesV;
					  
				if (a = nil) then begin
					new(a);
					a^.dato:=r;
					a^.HI:=nil;
					a^.HD:=nil;
				end
				else
				if (r.codProd < a^.dato.codProd) and (a2^.dato.codProd <> r.codProd) then 
					agregarNodos(a^.HI, a2^.HI, r)
				else if (r.codProd < a^.dato.codProd) and (a2^.dato.codProd = r.codProd) then 
					agregarNodos(a^.HI, a2, r)
				else	
					if (r.codProd > a^.dato.codProd) then 
						agregarNodos(a^.HD, a2^.HD,r)
					else
						agregarNodos(a^.HD, a2, r);
			End;
		
	{procedure agregarNodo2(var a2:arbol2; cod:integer; cantUnidades:integer);
		begin
			if (a2 = nil) then begin
				new(a2);
				a2^.dato.codProd:=cod;
				a2^.dato.totalVentas:= cantUnidades;
				a2^.HI:=nil;
				a2^.HD:=nil;
				end
			else
				if (cod < a2^.dato.codProd) then agregarNodo2(a2^.HI, cod, cantUnidades)
				else	
					if (cod > a2^.dato.codProd) then agregarNodo2(a2^.HD, cod, cantUnidades)
					else 
						a2^.dato.totalVentas:= a2^.dato.totalVentas + cantUnidades;
		End;}
					
	var r:venta;
	begin
		Randomize;
		a:=nil;
		a2:=nil;
		leerR(r);
		while (r.codProd <> 0) do begin
			{agregarNodo(a, r);
			agregarNodo2(a2, r.codProd, r.unidadesV);}
			agregarNodos(a, a2, r);
			leerR(r);
			end;
	end;

function retornoVentasA1(a:arbol; cod:integer):integer;
	begin
		if (a <> nil) then begin
			if (a^.dato.codProd < cod) then retornoVentasA1:=retornoVentasA1(a^.HD, cod)
			else 
				if (a^.dato.codProd > cod) then retornoVentasA1:=retornoVentasA1(a^.HI, cod)
				else retornoVentasA1:=retornoVentasA1(a^.HD, cod) + a^.dato.unidadesV;
			end
		else
			retornoVentasA1:=0;		
	End;
	
function retornoVentasA2(a2:arbol2; cod:integer):integer;
	begin
		if (a2 <> nil) then begin
			if (a2^.dato.codProd < cod) then retornoVentasA2:=retornoVentasA2(a2^.HD, cod)
			else 
				if (a2^.dato.codProd > cod) then retornoVentasA2:=retornoVentasA2(a2^.HI, cod)
				else retornoVentasA2:=a2^.dato.totalVentas; 
			end
		else
			retornoVentasA2:=0;
	End;
	
var a:arbol; a2:arbol2;
begin
	crearArbol(a, a2);
	writeln(retornoVentasA1(a, 25));
	writeln(retornoVentasA2(a2, 25));
end.