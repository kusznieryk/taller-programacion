{3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre de 2022. 
* De cada película se conoce: código de película, código de género (1: acción, 2: aventura, 3: drama, 4: suspenso, 5: comedia, 6: bélica, 7: documental y 8: terror)
*  y puntaje promedio otorgado por las críticas. 
Implementar un programa modularizado que:
a. Lea los datos de películas y los almacene por orden de llegada y agrupados por código de género, en una estructura de datos adecuada. La lectura finaliza 
* cuando se lee el código de la película -1. Asumo que no se procesa 
* es un vector de listas!
b. Una vez almacenada la información, genere un vector que guarde, para cada género, el código de película con mayor puntaje obtenido entre todas las críticas.
c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos métodos vistos en la teoría. 
d. Luego de ordenar el vector, muestre el código de película con mayor puntaje y el código de película con menor puntaje.
}
program ej3;
type 
	rango = 1..8;
	pelicula = record
		codPeli:integer;
		genero:rango;
		puntaje:real;
		end;
	vectorC = array [rango] of pelicula;
	
	lista = ^nodo;
	
	nodo = record 
		dato:pelicula;
		sig:lista;
		end;
	vector = array [rango] of lista;
	
	
procedure GeneroVectorDeListas (var v:vector);	

	procedure LeoRegistro(var r:pelicula);
		begin
			writeln('ingrese codigo de pelicula' );
			readln(r.codPeli);
			if r.codPeli <> -1 then begin
				readln(r.genero);{:=random(8) +1;}
				(r.puntaje):=random(11);
				end;
		end;
	
	procedure AgregarAtras(var v:vector; r:pelicula); {como tengo 8 listas tendria que tener 8 ultimos, vamos a hacer que el ult recorra la lista entera}
		var aux, ult:lista; i:integer;
		begin
			i:=r.genero;
			new(aux); aux^.dato:=r; aux^.sig:=nil; 
			if v[i]=nil then
				v[i]:=aux
		    else 
				begin
					ult:=v[i];
					while (ult^.sig <> nil) do ult:=ult^.sig; 
					ult^.sig:=aux;
				end;
		end;
		
	procedure IniciarVectorDeListas (var v:vector);
	    var i:integer;
		begin
			for i:=1 to 8 do 
				v[i]:=nil;
		end;
		
	procedure escribirV(v:vector);
		var i:integer;
		begin
			for i:=1 to 8 do
				while (v[i] <> nil ) do begin
				writeln('');
					writeln(v[i]^.dato.puntaje:2:2);
					writeln(v[i]^.dato.codPeli);
					writeln(v[i]^.dato.genero);
					v[i]:=v[i]^.sig;
					end;
		End;
		
	var r:pelicula;
	begin
		IniciarVectorDeListas(v);
		LeoRegistro(r);
		while (r.codPeli <> -1) do begin
			AgregarAtras(v, r);
			LeoRegistro(r);
		    end;
		escribirV(v);
	end;

procedure GeneroVectorC(var vc:vectorC; v:vector);

	procedure ObtenerMaxRegistro(var r:pelicula; v:vector; var i:integer); {quizas se podria retornar una variable booleana}
		{var  max:integer; no es necesario un max si usas r.puntaje, pero queda mas claro}
		begin
			r.puntaje:=-1;
			while (v[i] <> nil) do begin
			    if (v[i]^.dato.puntaje > r.puntaje) then 
					r:=v[i]^.dato;
			    v[i]:=v[i]^.sig;
			    end;
		end;
		
	procedure ArmarVectorC(var vc:vectorC; r:pelicula; v:vector; var dimL:integer);
		var i,j:integer;
		begin
			dimL:=0;
			for i:=1 to 8 do begin
				j:=i;
				ObtenerMaxRegistro(r, v, j);
				vc[i]:=r;
				if (vc[i].puntaje <> -1) then
					dimL:=dimL+1;
				end;
		end;
		
	{procedure OrdenarVc(var vc:vectorC);
			var i,j :integer; actual:real;
			begin
				for i:=2 to 8 do begin
				  actual:=vc[i].puntaje; 
				  j:=i-1;
				  while (j > 0) and (vc[j].puntaje > actual) do begin
					vc[j+1].puntaje:=vc[j].puntaje;
					j:=j-1;
					end;
				  vc[j+1].puntaje:=actual;
				end;
			end;}
			
	procedure OrdenarVc(var vc:vectorC; dimL:integer);
		var i,j,p:integer; item:pelicula;
		begin
			for i:=1 to 7 do begin
				p:=i;
				for j:=i+1 to 8 do
					if (vc[j].puntaje > vc[i].puntaje) then p:=j;
					
				item:=vc[p];
				vc[p]:=vc[i];
				vc[i]:=item;
				end;
			for i:=1 to dimL do
				writeln(vc[i].puntaje);
		End;
			
	procedure ImprimirVector(vc:vectorC; dimL:integer);
		begin
			{i:=1;
			for i:=1 to 8 do begin
				if (vc[i].puntaje <> -1) then 
					dimL:=dimL+1;
				writeln('puntajes en vc:');
				writeln(vc[i].puntaje:2:2);
				end;
				* Esto tenia propositos de debugging}
			if dimL > 0 then begin
				writeln('codigo de pelicula con mejor puntaje:');
				writeln(vc[1].codPeli);
				writeln('codigo de pelicula con peor puntaje (entre las que entraron al top 8):');
				writeln(vc[dimL].codPeli);
				{writeln(dimL);}
				end
			else 
				writeln('el vector esta  vacio, no se puede mostrar informacion');
		End;
		
	var i, dimL:integer; r:pelicula;
	begin
		ArmarVectorC(vc,r,v, dimL);
		OrdenarVc(vc, dimL);
		ImprimirVector(vc, dimL);
	end;
var v:vector; vc:vectorC; 
begin
GeneroVectorDeListas(v);
GeneroVectorC(vc, v);
end.