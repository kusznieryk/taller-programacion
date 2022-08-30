{ 4.- Una librería requiere el procesamiento de la información de sus productos. 
* De cada producto se conoce el código del producto, código de rubro (del 1 al 8) y precio. 
Implementar un programa modularizado que:
a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados por rubro, en una estructura de datos adecuada.
*  El ingreso de los productos finaliza cuando se lee el precio 0. 
* no lo proceso
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. 
* Considerar que puede haber más o menos de 30 productos del rubro 3. 
* Si la cantidad de productos del rubro 3 es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto.
*  
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos métodos vistos en la teoría. 
e. Muestre los precios del vector ordenado.}
program ej14;

type
	rango = 1..8;
	
	producto = record
		codProd:integer;
		rubro:rango;
		precio:real;
		end;
	
	lista = ^nodo;
	
	nodo = record
		dato:producto;
		sig:lista;
		end;
		
	vector1 = array [rango] of lista;
	
	vector2 = array [1..30] of producto;
	
procedure GeneroVectorDeListasEInformo(var v1:vector1);
	
	procedure LeerRegistro(var r:producto);
		begin
			writeln('ingresar codigo de prodducto y rubro');
			readln(r.codProd);
			if (r.codProd) <> 0 then begin
				readln(r.rubro);
				(r.precio):=random(11);
				end;
		End;
	
	procedure InicializarListas(var v1:vector1);
		var i:integer;
		begin
			for i:=1 to 8 do 
				v1[i]:=nil;
		End;
		
	procedure InsertarOrdenado(var v1:vector1; r:producto);
		var aux, ant, act:lista;
		begin
			new(aux); aux^.dato:=r; aux^.sig:=nil;
			act:=v1[r.rubro];
			ant:=act;
			while (act <> nil) and (act^.dato.codProd < aux^.dato.codProd) do begin
				ant:=act;
				act:=act^.sig;
				end;
			
			if (act = v1[r.rubro]) then begin
				aux^.sig:=v1[r.rubro];
				v1[r.rubro]:=aux;
				{writeln(aux^.dato)implementar debugging}
				end
			else begin
				ant^.sig:=aux;
				aux^.sig:=act;
				end;
			
		End;
	
	procedure ArmarVector(var v1:vector1);
		var r:producto;
		begin
			InicializarListas(v1);
			LeerRegistro(r);
			while (r.codProd <> 0) do begin
				InsertarOrdenado(v1, r);
				LeerRegistro(r);
				end;
		End;
		
	procedure MuestroCodigos(v1:vector1);
		var i:integer;
		begin
			for i:=1 to 8 do begin
				if (v1[i]=nil) then 
					writeln('para este rubro no hay elementos')
				else begin
					writeln('pertenecientes al rubro numero: ');
					writeln(i);
					while (v1[i] <> nil) do begin
						writeln('');
						writeln(v1[i]^.dato.codProd);
						v1[i]:=v1[i]^.sig;
						end;
					end;
				end;
		End;
		
	begin
		ArmarVector(v1);
		MuestroCodigos(v1);
	End;
	
procedure GeneroVector2EInformo(var v2:vector2; dimL:integer; v1:vector1);
	
	procedure ArmarVector(var v2:vector2; var dimL:integer; v1:vector1);
		begin
			dimL:=0;
			while (v1[3] <> nil) do begin
				dimL:=dimL+1;
				v2[dimL]:=v1[3]^.dato;
				v1[3]:=v1[3]^.sig;
				end;
		End;
		
	procedure OrdenarInsercion(var v2:vector2; dimL:integer);
		var i,j:integer; actual:producto;
		begin
			
			for i:=2 to dimL do begin
				actual:=v2[i];
				j:=i-1;
				while (j > 0) and (v2[j].precio < actual.precio) do begin
					v2[j+1]:=v2[j];
					j:=j-1;
					end;
				v2[j+1]:=actual
				end;
		End;
		
	procedure MostrarPrecios(v2:vector2; dimL:integer); 
		var i:integer;
		begin
			for i:=1 to dimL do begin
				writeln('precios del rubro 3:');
				writeln(v2[i].precio);
				end;
		End;
		
	begin
		ArmarVector(v2, dimL, v1);
		OrdenarInsercion(v2, dimL);
		MostrarPrecios(v2, dimL);
	End;
	
var v1: vector1; v2:vector2; dimL:integer;
begin
	GeneroVectorDeListasEInformo(v1);
	GeneroVector2EInformo(v2, dimL, v1);
end.