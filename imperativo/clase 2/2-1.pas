{
	a. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada  en punto y los almacene en un vector con dimensión física igual a 10.

	b. Implementar un módulo que imprima el contenido del vector.

	c. Implementar un módulo recursivo que imprima el contenido del vector.

	d. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne la cantidad de caracteres leídos. El programa debe informar el valor retornado.

	e. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne una lista con los caracteres leídos.

	f. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en el mismo orden que están almacenados.

	g. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en orden inverso al que están almacenados.

}

program aaa;
const DIM_F=10;
type
	lista=^nodoLista;
	nodoLista= record 
		elem:char;
		sig:lista;
	end;
	rango = 0..DIM_F;
	vector=array[rango] of char;

	//inciso a
	procedure cargarVector(var v:vector; var dimL:rango);

		procedure leerRecursivo(var v:vector; var dimL:rango);
			var aux:char;
			begin
				write('ingrese un caracter: ');
				readln(aux);
				if(aux<>'.')and (dimL<DIM_F) then begin
					dimL:=dimL+1;
					v[dimL]:=aux;
					leerRecursivo(v,diml);
					end
			end;
		
		begin
			diml:=0;
			leerRecursivo(v,diml);
		end;	

	//inciso b 
	procedure imprimirVector(v:vector; diml:rango);
	var i:rango;
	begin
		for i:=1 to dimL do 
			writeln(v[i])
	end;
	//inciso c
	procedure imprimirvectorr(v:vector; diml:rango);
		begin
			if (diml > 0) then begin
			  imprimirvectorr(v, (diml-1));
			  writeln(V[diml]);
			end
		end;

	//inciso d
	function leerCar(): Integer;
		var aux:char;
		begin
		readln(aux);
		if(aux<>'.') then 
			leerCar:= leerCar()+1
		else leerCar:=0;
		end;

  //inciso e
  function leerYcrearLista():lista;
	  var nodo:lista;aux:char;
	  begin
		  writeln('ingrese un caracter: ');
	  	readln(aux);
	  	if aux<>'.'then begin
	  		new(nodo);
	  		nodo^.elem:=aux;
	  		nodo^.sig:= leerYcrearLista();
	  		leerYcrearLista:=nodo;
	  	end else leerYcrearLista:=nil;
	  end;

	 //inciso f 
	 procedure escribirEnOrden(l:lista);
	 begin
	 	if l<>nil then begin
	 		writeln(l^.elem);
	 		escribirEnOrden(l^.sig)
	 	end
	 end;
	 //inciso g 
	 procedure escribirInverso(l:lista);
	 begin
	 	if l<>nil then begin
	 		escribirInverso(l^.sig);
	 		writeln(l^.elem);
	 	end
	 end;
var 
v:vector; diml:rango; l:lista;
begin
	//cargarVector(v,diml);  //INCISO A
	//imprimirVector(v,diml); //INCISO B
	//imprimirVectorR(v,diml); // INCISO C	
	//writeLn( leerCar()); //INCISO D
	//l:= leerYcrearLista(); // INCISO E
	//escribirEnOrden(l); // INCISO F
	//escribirInverso(l); //INCISO G
end.