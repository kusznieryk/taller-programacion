{4.	Un teatro tiene funciones los 7 días de la semana. Para cada día se tiene una lista con las entradas vendidas. 
* Se desea procesar la información de una semana. Implementar un programa que:
a.	Genere 7 listas con las entradas vendidas para cada día. De cada entrada se lee día (de 1 a 7), código de la obra, asiento y monto. 
La lectura finaliza con el código de obra igual a 0. Las listas deben estar ordenadas por código de obra de forma ascendente. 
b.	Genere una nueva lista que totalice la cantidad de entradas vendidas por obra. Esta lista debe estar ordenada por código de obra de forma ascendente.}
program ej4;
const 
  dias = 7;
type
  cantdias = 1..dias;
  funciones = record
    codigo : integer;
    asiento : integer;
    monto : real;
  end;
  lista = ^nodo;
  nodo = record
    sig : lista;
    dato : funciones;
  end;
  vector = array [cantdias] of lista;
  
  funcionM = record
	cod:integer;
	cantV:integer;
	end;
	
	listaM = ^nodoM;
	
	nodoM = record 
		dato:funcionM;
		sig:listaM;
		end;
  
procedure generarvector(var v: vector);
	procedure leerfuncion(var f: funciones);
	begin
	  f.codigo:=random(15);
	  writeln ('el codigo de obra es: ', f.codigo);
	  if f.codigo <> 0 then begin
		f.asiento:=random(50);
		writeln ('el asiento es: ', f.asiento);
		f.monto:=random(100);
		writeln ('el monto es: ', f.monto);
		end;
	end;
	
	procedure insertarOrdenado(var l:lista; f:funciones);
	var act, ant, aux:lista;
	begin
		new(aux); aux^.dato:=f;
		act:=l;
		ant:=l;
		while (act <> nil) and (act^.dato.codigo < f.codigo) do begin
			ant:=act;
			act:=act^.sig;
		end;
		
		if (act = l) then
			l:=aux
		else
			ant^.sig:=aux;
		aux^.sig:=act;
		
	End;
	
	procedure incializarListas(var v:vector);
		var i:integer;
		begin
			for i:= 1 to dias do
				v[i]:=nil
		end;
	
	var f:funciones; dia:cantdias;
	begin
		Randomize;
		incializarListas(v);
		leerfuncion(f);
		while (f.codigo <> 0) do begin
			writeln('elegir dia de la semana');
			readln(dia);
			insertarOrdenado(v[dia], f);
			leerfuncion(f);
		end;
	end;

procedure imprimirv (v:vector);
		var i:integer;
		begin
			for i:= 1 to dias do
			    while (v[i]<> nil) do begin
					writeln('dia:' , i);
					writeln('codigo de funcion ', v[i]^.dato.codigo);
					writeln ('el asiento es: ' , v[i]^.dato.asiento);
					writeln ('el monto es: ' , v[i]^.dato.monto);
					v[i]:= v[i]^.sig
				end;
		end;
		

{procedure imprimirv (v:vector);
		var i:integer;
		begin
			for i:= 1 to dias do
			    with ('f' as v[i]^.dato) do 
					while (v[i]<> nil) do begin
						writeln('dia:' , i);
						writeln('codigo de funcion ', f.codigo);
						writeln ('el asiento es: ' , f.asiento);
						writeln ('el monto es: ' , f.monto);
						v[i]:= v[i]^.sig
					end;
		end; 
		* no corre}

procedure merge(var lM:listaM; v:vector);
	procedure minimo(var v:vector; var minCod:integer);
		var i:cantdias; indiceMin:cantdias;
		begin
			minCod:=999;
			for i:= 1 to dias do 
				if (v[i] <> nil) and (v[i]^.dato.codigo <= minCod) then begin
					minCod:= v[i]^.dato.codigo;
					indiceMin:=i;
					end;
			
			if minCod <> 999 then begin
				v[indiceMin]:= v[indiceMin]^.sig;
				end;
					
		End;
		
	procedure agregarMerge(var l:listaM; minCod, cantVentas:integer);
		var act, ant, aux:listaM;
		begin
			new(aux); aux^.dato.cod:=minCod; aux^.dato.cantV:= cantVentas;
			act:=l;
			ant:=l;
			while (act <> nil) and (act^.dato.cod < minCod) do begin
				ant:=act;
				act:=act^.sig;
			end;
			
			if (act = l) then
				l:=aux
			else
				ant^.sig:=aux;
			aux^.sig:=act;
		End;

	var minCod, actual, cantV:integer; 
		begin
			cantV:=0;
			lM:=nil;
			minimo(v, minCod);
			while (minCod <> 999)  do begin
				actual:= minCod;
				cantV:=0;
				while (minCod <> 999) and (actual = minCod) do begin
					cantV:= cantV+1;
					minimo(v, minCod);
				end;
				agregarMerge(lM, actual, cantV);
			end;
		End;
	
procedure imprimirLM(lM:listaM);
	begin
		while (lM <> nil) do begin
			writeln('codigo es: ', lM^.dato.cod);
			writeln('cant de ventas es: ', lM^.dato.cantV);
			lM:=lM^.sig;
		end;
	end;
		
var v: vector; lM:listaM;
begin
	generarvector(v);
	writeln('----------------------------------------------');
	imprimirv(v);
	writeln('----------------------------------------------');
	merge(lM, v);
	imprimirLM(lM);
	
end.
