{
	a. Implemente un módulo recursivo que genere un vector de 20 números enteros “random” mayores a 0 y menores a 100. 

	b. Implemente un módulo recursivo que devuelva el máximo valor del vector. 
	
	c.  Implementar  un  módulo  recursivo  que  devuelva  la  suma  de  los  valores  contenidos  en  el vector
}
program a;
const
	DIM_F = 20;
type
	rango=1..DIM_F;
	vector = array[rango] of integer;

	//inciso a
	procedure generarVector(var v:vector;var dimL:rango);
		procedure cargarElementos(var v:vector; var dimL:rango);
			var aux:integer;
			begin
				aux:=random(100);
				if (aux<>0) and (dimL<DIM_F) then
				begin 
					dimL:=dimL+1;
					v[dimL]:=aux;
					cargarElementos(v,dimL)
					end;
			end;

		begin
			dimL:=0;
			randomize;
			cargarElementos(v,dimL)
		end;

	//inciso b
	function maximo(v:vector; dimL:rango):integer;
		var aux:integer;
		begin
			if(dimL=1) then maximo:=v[diml]

			else 
				begin
					aux:=maximo(v,dimL-1);

					if(aux<v[diml]) then maximo:=v[diml]
					else maximo:= aux
				end
		end;

	//inciso c
	function suma(v:vector; diml:rango):integer;
	begin
		if diml=1 then suma:=v[diml]
		else suma:= suma(v,diml-1)+v[diml];
	end;
var v:vector; var dimL,i:rango;
begin
	generarVector(v,dimL);	
	for i := 1 to dimL do
		writeln(v[i]);
	writeln('---------------------------------------------------------------------------------------', '\n', '\n');
	writeln(maximo(v,diml));
	writeln(suma(v,diml))
end.