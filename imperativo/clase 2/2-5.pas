program aa;
	type 
		vector=array[1..10] of integer;
		indice=integer;

	Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
	begin
		pos:=(ini + fin) div 2;
		if (ini<= fin) then 
			begin
			if(v[pos]>dato) then 
				busquedaDicotomica(v, ini, pos-1, dato, pos)
			else if v[pos]< dato then 
					busquedaDicotomica(v, pos+1, fin, dato, pos);
			end
		else if v[pos]<>dato then pos:=-1;


	end;
	var i:integer; v:vector; pos:integer;
begin
	for i:=1 to 10 do 
		v[i]:=i;
	pos:=1;
	busquedaDicotomica(v, 1, 10, 103, pos);
	writeln(pos)
end.