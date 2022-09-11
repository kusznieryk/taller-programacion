{Un teatro tiene funciones los 7 días de la semana. Para cada día se tiene una lista con las entradas vendidas. 
Se desea procesar la información de una semana. Se pide:
a)	Generar 7 listas con las entradas vendidas para cada día. De cada entrada se lee día (de 1 a 7), código de la obra, asiento, monto.
*  La lectura finaliza con el código de obra igual a 0. Las listas deben estar ordenadas por código de obra de forma ascendente.
b)	Generar una nueva lista que totalice la cantidad de entradas vendidas por obra. Esta lista debe estar ordenada por código de obra de forma ascendente.
c)	Realice un módulo recursivo que informe el contenido de la lista generada en b)
}

program ej4;

type
	dias = 1..7;
	
	entrada = record
		codigo:integer;
		asiento:integer;
		monto:integer;
		end;
		
	lista = ^nodo;
	
	nodo = record
		sig:lista;
		dato:entrada;
		end;
		
	vector = array [dias] of lista;
	
	entradaM = record
		cant:integer;
		codigo:integer;
		end;
		
	listaM = ^nodoM;
	
	nodoM = record
		sig:listaM;
		dato:entradaM;
		end;
	
procedure generarV(var v:vector);
	procedure initV(var v:vector);
		var i:dias;
		begin
			for i:=1 to 7 do 
				v[i]:=nil;
				
		end;
		
	procedure leerR(var r:entrada);
		begin
			r.codigo:=random(10);
			if r.codigo <> -1 then begin
				r.asiento:=random(20);
				r.monto:=random(50);
			end;
		end;
		
	procedure insertarAsc(var l:lista; r:entrada);
		var aux, act, ant:lista;
		begin
			new(aux); aux^.dato:=r;
			act:=l;
			ant:=l;
			while (act <> nil) and (act^.dato.codigo < r.codigo) do begin
				ant:=act;
				act:=act^.sig;
			end;
			
			if (l= act) then
				l:=aux
			else
				ant^.sig:=aux;
			aux^.sig:=act;
		end;
			
	var r:entrada; dia:dias;
	begin
		Randomize;
		initV(v);
		leerR(r);
		while (r.codigo <> 0) do begin
			dia:=random(7)+1;
			insertarAsc(v[dia], r);
			leerR(r);
		end;
	end;
	
procedure escribirv(v:vector);
	procedure escribirl(l:lista);
		begin
			while (l<> nil) do begin
				writeln('codigo: ', l^.dato.codigo, ' asiento ', l^.dato.asiento, ' monto ', l^.dato.monto);
				l:=l^.sig;
			end;
		end;
	var i:dias;
	begin
		writeln('--------------');
		for i:=1 to 7 do begin
			writeln('dia: ', i);
			escribirl(v[i]);
		end;
	end;
	
	
procedure merge(var l:listaM; v:vector);

	procedure minimo(var v:vector; var min:integer);
		var i, minIndice:dias;
		begin
			min:=999;
			for i:=1 to 7 do begin
				if v[i] <> nil then 
					if v[i]^.dato.codigo < min then begin
						min:=v[i]^.dato.codigo;
						minIndice:=i;
					end;
			end;
			
			if (min <> 999) then begin
				v[minIndice]:=v[minIndice]^.sig;
			end;
		end;
		
	procedure agregarM(var l, ult:listaM; min, cant:integer);
		var aux:listaM;
		begin
			writeln('debug');
			new(aux); aux^.dato.codigo:=min; aux^.dato.cant:=cant; aux^.sig:=nil;
			if (l = nil) then begin
				l:=aux;
				aux^.sig:=l;
			end
			else
				ult^.sig:=aux;
			ult:=aux;
		end;
		
	var min, cant, actual:integer; ult:listaM;
	begin
		l:=nil;
		minimo(v, min);
		while (min <> 999) do begin
			actual:=min;
			cant:=0;
			while (min <> 999) and (min = actual) do begin
				cant:=cant+1;
				minimo(v, min);
			end;
			
			agregarM(l, ult, actual, cant);
		end;
	end;
			
	
procedure escribirlm(l:listaM);
		begin
			writeln('------------');
			while (l<> nil) do begin
				writeln('codigo: ', l^.dato.codigo, ' cant: ', l^.dato.cant);
				l:=l^.sig;
			end;
		end;
		
var v:vector; lm:listaM;
begin
generarV(v);
escribirv(v);
merge(lm, v);
escribirlm(lm);
end.
			
			
