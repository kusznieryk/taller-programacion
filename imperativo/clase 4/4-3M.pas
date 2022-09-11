{3.	Implementar un programa que procese la información de las ventas de productos de una librería que tiene 4 sucursales.
 De cada venta se lee fecha de venta, código del producto vendido, código de sucursal y cantidad vendida. 
 El ingreso de las ventas finaliza cuando se lee el código de sucursal 0. Implementar un programa que:
a.	Almacene las ventas ordenadas por código de producto y agrupados por sucursal, en una estructura de datos adecuada.
b.	Contenga un módulo que reciba la estructura generada en el punto a
 y retorne una estructura donde esté acumulada la cantidad total vendida para cada código de producto.
}

program ej3;

type
	rango = 0..4;
	venta = record
		fecha: integer;
		codProd:integer;
		cant:integer;
		end;
		
	lista = ^nodo;
	
	nodo = record
		dato:venta;
		sig:lista;
		end;
		
	vector = array [rango] of lista;
	
	ventaM = record
		codProd:integer;
		totalVentas:integer;
		end;
		
	listaM = ^nodoM;
	
	nodoM = record
	sig:listaM;
	dato:ventaM;
	end;
	
procedure  generarV( var v:vector);
	procedure initV(var v:vector);
		var i:rango;
		begin
			for i:=1 to 4 do 
				v[i]:=nil;
		end;
		
	procedure insertarOrdenado(var l:lista; r:venta);
		var aux, act, ant:lista;
		begin
			new(aux);
			aux^.dato:=r;
			act:=l;
			ant:=l;
			while (act<> nil) and (act^.dato.codProd < r.codProd) do begin
				ant:=act;
				act:=act^.sig;
			end;
			
			if (l = act) then 
				l:=aux
			else
				ant^.sig:=aux;
			aux^.sig:=act;
		end;
		
	procedure leerR(var r:venta; var sucur:rango);
		begin
			//sucur:=random(5);
			writeln('ingresar sucursal');
			readln(sucur);
		if sucur <> 0 then begin
			r.codProd:=random(10);
			r.cant:=random(10);
			//writeln('sucursal: ', sucur, ' codProd: ', r.codProd, ' cantidad ', r.cant);
			r.fecha:=random(1900);
		end;
		end;
		
	var r:venta; sucur:rango;
	begin
	Randomize;
	initV(v);
	leerR(r, sucur);
	while (sucur <> 0) do begin
		insertarOrdenado(v[sucur], r);
		leerR(r, sucur);
	end;
	end;
	
procedure merge(v:vector; var lm:listaM);

	procedure agregarAdelante (var lm:listaM; actual, cant:integer);
		var aux:listaM;
		begin
		new(aux);
		aux^.dato.codProd:=actual;
		aux^.dato.totalVentas:=cant;
		
		aux^.sig:=lm;
		lm:=aux;
	end;
	
	procedure minimo(var v:vector; var min:integer; var cant:integer);
		var indiceMin, i:rango;
		begin
			min:=999;
			for i:=1 to 4 do 
				if v[i] <> nil then
					if v[i]^.dato.codProd < min then begin
						indiceMin:=i;
						min:=v[i]^.dato.codProd;
						end;
					
			if min <> 999 then begin
				cant:=v[indiceMin]^.dato.cant;
				v[indiceMin]:=v[indiceMin]^.sig;
			end;
				
		end;
		
	var minCod, actual, cant, contador:integer;
	begin
	lm:=nil;
	minimo(v, minCod, contador);
	while (minCod <> 999) do begin
		actual:=minCod;
		cant:=0;
		while (minCod <> 999) and (actual = minCod) do begin
			cant:=cant + contador;
			minimo(v, minCod, contador);
		end;
		agregarAdelante(lm, actual, cant);
	end;
	end;
	
procedure escribirv(v:vector);
	procedure escribirl1(l:lista);
		begin
		while (l <> nil) do begin
		writeln('codigo: ', l^.dato.codProd, ' cant: ', l^.dato.cant);
		l:=l^.sig;
		end;
	end;
	
	var i:rango;
	begin
	for i:=1 to 4 do begin
		writeln('sucursal nro: ', i);
		escribirl1(v[i]);
		end;
	end;
	
	
procedure escribirl(lm:listaM);
	begin
	writeln('--------'); 
	while (lm <> nil) do begin
		writeln('codigo: ', lm^.dato.codProd, ' total ventas: ', lm^.dato.totalVentas);
		lm:=lm^.sig;
		end;
	end;
	
var v:vector; lm:listaM;
begin
generarV(v);
merge(v, lm);
escribirv(v);
escribirl(lm);
end.
	
