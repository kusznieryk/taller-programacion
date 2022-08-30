{5.- Implementar un módulo que realice una búsqueda dicotómica en un vector, utilizando el siguiente encabezado:
   	Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice); 
   	* Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra en el vector. }
   	
program ej5;

type 
	vector = array [1..10] of integer;
	
	indice = -1..10;
	
{procedure busquedaDicotomica(v:vector; ini,fin: indice; dato:integer; var pos: indice); 
	begin
		pos:=(ini + fin) div 2;
		if (v[pos] <> dato) and (ini <= fin) then begin
			if v[pos] > dato then 
				fin:= pos - 1
			else if v[pos] < dato then
				ini:=pos+1;
			
			busquedaDicotomica(v, ini, fin, dato, pos);
			end
		else
			if (v[pos] <> dato) then
				pos:=-1;
	End;}
	
procedure busquedaDicotomica(v:vector; ini,fin: indice; dato:integer; var pos: indice); 
	begin
		pos:=(ini + fin) div 2;
		if (ini <= fin) then begin
			if (v[pos] > dato) then 
				busquedaDicotomica(v, ini, pos - 1, dato, pos)
			else 
				if (v[pos] < dato) then
					busquedaDicotomica(v, pos +1, fin, dato, pos);
			end
		else 
			if v[pos] <> dato then pos:=-1;
	
	end;

procedure cargarV(var v:vector);
	var i:integer;
	begin
		for i:=1 to 10 do 
			v[i]:=i;
	end;
	
var v:vector; ini, fin:indice; dato:integer; pos:indice;
begin
	ini:=1;
	fin:=10;
	dato:=12;
	cargarV(v);
	busquedaDicotomica(v, ini, fin, dato, pos);
	
	writeln('pos: ');
	writeln(pos);
end.

