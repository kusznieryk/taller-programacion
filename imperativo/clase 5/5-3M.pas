{.- Un supermercado requiere el procesamiento de sus productos. De cada producto se conoce código, rubro (1..10), stock y precio unitario. Se pide:
a)	Generar una estructura adecuada que permita agrupar los productos por rubro.
 A su vez, para cada rubro, se requiere que la búsqueda de un producto por código sea lo más eficiente posible.
  La lectura finaliza con el código de producto igual a -1..
b)	Implementar un módulo que reciba la estructura generada en a), un rubro y un código de producto y retorne si dicho código existe o no para ese rubro.
c)	Implementar un módulo que reciba la estructura generada en a), y retorne, para cada rubro, el código y stock del producto con mayor código.
d)	Implementar un módulo que reciba la estructura generada en a),
 dos códigos y retorne, para cada rubro, la cantidad de productos con códigos entre los dos valores ingresados
}

program ej2;
const 
	rubros = 10;
	
type
	rango = 1..rubros;

	producto = record
		codigo:integer;
		stock:integer;
		precio:integer;
		end;

	arbol = ^nodo;

	nodo = record 
		HI:arbol;
		HD: arbol;
		dato:producto;
		end;
		
	vector = array [1..rubros] of arbol;

	incisoB = record 
		codigo:integer;
		stock:integer;
		end;
		
	vectorC = array [rango] of incisoB;

procedure generarV(var v:vector);
	procedure initV(var v:vector);
		var i:rango;
		begin
			for i:=1 to rubros do 
				v[i]:=nil;
		end;
		
	procedure leerR(var r:producto);
		begin
			r.codigo:=random(8) - 1;
			if r.codigo <> -1 then begin
				r.stock:=random(30);
				r.precio:=random(100);
				writeln('codigo: ', r.codigo, ' stock: ', r.stock, ' precio: ', r.precio);
			end;
		end;
		
	procedure cargarA(var a:arbol; r:producto);
		begin
			if (a <> nil) then 
				if r.codigo >= a^.dato.codigo then cargarA(a^.HD, r)
				else cargarA(a^.HI, r)
			else begin
				new(a);
				a^.HI:=nil;
				a^.HD:=nil;
				a^.dato:=r;
			end;
		end;
		
	var r:producto; rubro:rango;
	begin
		Randomize;
		initV(v);
		leerR(r);
		while (r.codigo <> -1) do begin
			rubro:=random(10) +1;
			cargarA(v[rubro], r);
			leerR(r);
		end;
	end;
	
procedure escribirV(v:vector);
	procedure escribirA(a:arbol);
		begin
			if a <> nil then begin
				escribirA(a^.HI);
				writeln('codigo: ', a^.dato.codigo, ' stock: ', a^.dato.stock, ' precio: ', a^.dato.precio);
				escribirA(a^.HD);
			end;
		end;
		
	var i:rango;
	begin
		writeln('--------------------');
		for i:=1 to rubros do
			if v[i] <> nil then begin
				writeln('rubro: ', i);
				escribirA(v[i]);
			end;
	end;
	
function existeCodigo(v:vector; cod:integer; rubro:rango):boolean;

	function buscar(a:arbol; cod:integer):boolean;
		begin
			if (a <> nil) then begin
				if a^.dato.codigo > cod then buscar:=buscar(a^.HI, cod)
				else 
					if a^.dato.codigo > cod then buscar:=buscar(a^.HD, cod)
					else
						buscar:=True;
			end
			else
				buscar:=false;
		end;
		
	
	begin
	existeCodigo:=buscar(v[rubro], cod);
	end;
	
//código y stock del producto con mayor código.
procedure retornoMax(v:vector; var vc:vectorC);
	procedure initVC(var vc:vectorC);
		var i:rango;
		begin
			for i:=1 to rubros do begin
				vc[i].codigo:=-1;
				vc[i].stock:=-1;
			end;
		end;
		
	procedure sacoMax(a:arbol; var r:incisoB);
		begin
			if (a^.HD <> nil) then 
				sacoMax(a^.HD, r)
			else
				begin
					r.codigo:=a^.dato.codigo;
					r.stock:=a^.dato.stock;
				end;
		end;
		
	var i:rango;
	begin
		initVC(vc);
		for i:=1 to rubros do
			if (v[i] <> nil) then
				sacoMax(v[i], vc[i]);
	end;
	
procedure escribirVC(vc:vectorC);	
	var i:rango;
	begin
		writeln('--------------------');
		for i:=1 to rubros do begin
			writeln('rubro: ', i);
			writeln('maxcod: ', vc[i].codigo, ' max stock: ', vc[i].stock);
		end;
		writeln('----------');
	end;
	
//para cada rubro, habria que hacer un vector, me muero de la paja
function entreDos(v:vector; cod1, cod2:integer):integer;
	function buscarRango(a:arbol; cod1, cod2:integer):integer;
		begin
			if (a <> nil) then begin
				if (a^.dato.codigo < cod1) then buscarRango:=buscarRango(a^.HD, cod1, cod2)
				else
					if a^.dato.codigo > cod2 then buscarRango:=buscarRango(a^.HI,cod1,cod2)
					else
						buscarRango:=buscarRango(a^.HD, cod1, cod2) + buscarRango(a^.HI, cod1, cod2) + 1;
			end
			else
				buscarRango:=0;
		end;
					
	var i:rango; aux:integer;
	begin
		aux:=0;
		for i:=1 to rubros do
			if (v[i] <> nil) then
				aux:=aux+ buscarRango(v[i], cod1, cod2);
		entreDos:=aux;
	end;

var v:vector; vc:vectorC;
begin
	generarV(v);
	escribirV(v);
	writeln(existeCodigo(v, 5, 5));
	retornoMax(v, vc);
	escribirVC(vc);
	writeln(entreDos(v, 2, 7));
	
end.
					
			
