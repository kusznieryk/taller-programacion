{1.	Escribir un programa que:
a. Implemente un módulo que lea información de socios de un club y las almacene en un árbol binario de búsqueda.
*  De cada socio se lee número de socio, nombre y edad. La lectura finaliza con el número de socio 0 y el árbol debe quedar ordenado por número de socio.
b. Una vez generado el árbol, realice módulos independientes que reciban el árbol como parámetro y que : 
i. Informe el número de socio más grande. Debe invocar a un módulo recursivo que retorne dicho valor.
ii. Informe los datos del socio con el número de socio más chico. Debe invocar a un módulo recursivo que retorne dicho socio.
iii. Informe el número de socio con mayor edad. Debe invocar a un módulo recursivo que retorne dicho valor.
iv. Aumente en 1 la edad de todos los socios.
v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un módulo recursivo que reciba el valor leído y retorne verdadero o falso.
vi. Lea un nombre e informe si existe o no existe un socio con ese nombre. Debe invocar a un módulo recursivo que reciba el nombre leído y retorne verdadero o falso.
vii. Informe la cantidad de socios. Debe invocar a un módulo recursivo que retorne dicha cantidad.
viii. Informe el promedio de edad de los socios. Debe invocar a un módulo recursivo que retorne dicho promedio.
ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el árbol cuyo número de socio se encuentra entre los dos valores ingresados.
*  Debe invocar a un módulo recursivo que reciba los dos valores leídos y retorne dicha cantidad.
x. Informe los números de socio en orden creciente. 
xi. Informe los números de socio pares en orden decreciente. 
}

program ej1;

type
	rango = -1..120;
	socio = record
		numSocio:integer;
		nombre:string;
		edad:rango
		end;
		
	arbol = ^nodo;
	
	nodo = record
		dato:socio;
		HI:arbol;
		HD:arbol;
		end;
	
procedure crearArbol(var a:arbol);

	procedure leerR(var r:socio);
		begin
			//r.numSocio:=random(14);
			readln(r.numSocio);
			//writeln(r.numSocio);
			if r.numSocio <> 0 then begin
				//writeln('escribir nombre');
				//readln(r.nombre);
				r.nombre:='hola';
				r.edad:=random(10);
				writeln(r.edad);
			end;
		end;
		
	procedure generarNodos(var a:arbol; r:socio);
		begin
			if (a = nil) then begin
				new(a);
				a^.dato:=r;
				a^.HI:=nil;
				a^.HD:=nil;
				end
			else
				if (r.numSocio < a^.dato.numSocio) then generarNodos(a^.HI, r)
				else 
					generarNodos(a^.HD, r);
		end;
		
		var r:socio;
		begin
			Randomize;
			a:=nil;
			leerR(r);
			while (r.numSocio <> 0) do begin
				generarNodos(a,r);
				leerR(r);
				end;
		end;
		
function informoMaxNum(a:arbol):integer;
	begin
		if (a <> nil) then
			if (a^.HD <> nil) then
				informoMaxNum:=informoMaxNum(a^.HD)
			else
				informoMaxNum:=a^.dato.numSocio
		else
			informoMaxNum:=-1;
	end;
	

procedure informoInciso2(a:arbol);

function informoMinDatos(a:arbol):socio;
	begin
		if (a <> nil) then
			if (a^.HI <> nil) then
				informoMinDatos:=informoMinDatos(a^.HI)
			else
				informoMinDatos:=a^.dato
	end;
	
	var r:socio;
	begin
		if (a = nil) then writeln('arbol vacio')
		else begin
			r:=informoMinDatos(a);
			writeln(r.numSocio);
			writeln(r.edad);
			writeln(r.nombre);
		end;
	end;
	

{
function retornoMaxEdad(a:arbol):rango;
	var maxI, maxD, aux:integer;
	begin
		if (a <> nil) then begin
			maxD:=retornoMaxEdad(a^.HD);
			maxI:=retornoMaxEdad(a^.HI);
			
			if maxI > maxD then
				aux:=maxI
			else 
				aux:=maxD;
				
			if a^.dato.edad > aux then
				retornoMaxEdad:=a^.dato.edad
			else 
				retornoMaxEdad:=aux;
			end
		else
			retornoMaxEdad:=-1;
	End;}
	
//mismo tiempo de ejecucion que la funcion anterior y uso una variable menos. Problema:estoy retornando la max edad y no el numSocios
{function retornoMaxEdad(a:arbol):rango;
	var maxI, maxD:integer;
	begin
		if (a <> nil) then begin	
			maxD:=retornoMaxEdad(a^.HD);
			maxI:=retornoMaxEdad(a^.HI);
			
			if (a^.dato.edad > maxD) and (a^.dato.edad > maxI) then
				retornoMaxEdad:=a^.dato.edad
			else 
				if maxD > a^.dato.edad then retornoMaxEdad:= maxD
				else retornoMaxEdad:=maxI;
		end
		else
			retornoMaxEdad:=-1;
	End;}
	
//problema: devuelve el registro entero no el numSocio
function retornoMaxEdad(a:arbol):socio;
	var maxI, maxD:socio;
	begin
		if (a <> nil) then begin	
			maxD:=retornoMaxEdad(a^.HD);
			maxI:=retornoMaxEdad(a^.HI);
			
			if (a^.dato.edad > maxD.edad) and (a^.dato.edad > maxI.edad) then
				retornoMaxEdad:=a^.dato
			else 
				if maxD.edad > a^.dato.edad then retornoMaxEdad:= maxD
				else retornoMaxEdad:=maxI;
		end
		else begin
			//opcion 1
			maxI.numSocio:=-1;
			retornoMaxEdad:=maxI;
		    end
	End;
	
procedure aumentoEdad(a:arbol);
	begin
		if (a <> nil) then begin
			aumentoEdad(a^.HD);
			a^.dato.edad:=a^.dato.edad + 1;
			aumentoEdad(a^.HI);
		end
	end;
	
function existeSocio(a:arbol; num:integer):boolean;
	begin
		if (a <> nil) then begin
			if (a^.dato.numSocio = num) then existeSocio:=True
			else 
				if (a^.dato.numSocio < num) then existeSocio:=existeSocio(a^.HD, num)
				else existeSocio:=existeSocio(a^.HI, num);
			end
		else
			existeSocio:=False;
	End;
	
function existeNombre(a:arbol; nomb:string):boolean;
	begin
		if (a <> nil) then begin
			if (a^.dato.nombre = nomb) then existeNombre:=True
			else begin
				existeNombre:=existeNombre(a^.HD, nomb);
				if existeNombre = False then
			    {este if es necesario porque pascal no sale de la funcion si ve que tiene otra instruccion ejecutando el nombre de la funcion}
					existeNombre:=existeNombre(a^.HI, nomb);
				end;
			end
		else
			existeNombre:=False;
	End;
	
{function cantSocios(a:arbol):integer; este da el valor correcto pero usamos el nombre de la funcion 3 veces y deberia ser una al final nomas
	begin
		if (a <> nil) then begin
			cantSocios:=cantSocios(a^.HI);
			cantSocios:=cantSocios + cantSocios(a^.HD);
			cantSocios:=cantSocios+1;
			end
		else 
			cantSocios:=0;
	End;}

{menos eficaz y usa variables
function cantSocios(a:arbol):integer;
		var cantI, cantD:integer;
		begin
			if (a <> nil) then begin
				cantI:=cantSocios(a^.HI);
				cantD:=cantSocios(a^.HD);
				
				cantSocios:= (cantI + cantD) + 1;
				//aux:= cantI + cantD;
				//cantSocios:= aux + 1;
				end
			else
				cantSocios:=0;
		End;}
		
//manera mas eficaz sin usar variables
function cantSocios(a:arbol):integer;
		begin
			if (a <> nil) then
				cantSocios:= (cantSocios(a^.HI) + cantSocios(a^.HD) ) + 1
			else
				cantSocios:=0;
		End;

{procedure cantSocios(a:arbol; var cant:integer);
		begin
			if (a <> nil) then begin
				cantSocios(a^.HI, cant);
				cantSocios(a^.HD, cant);
				cant:= cant +1;
				end;
		End;
		* para hacer funcionar este procedimiento hay que inicializar cant en 0 por fuera del procedimiento}
		

//creo que no cumple lo que pide el enunciado, pero anda	
function prom(a:arbol):real; 
	
	{Da bien, pero usamos mucho el nombre
	function sumatoriaEdad(a:arbol):integer;
		begin
			if (a <> nil) then begin
				sumatoriaEdad:=sumatoriaEdad(a^.HI);
				sumatoriaEdad:= sumatoriaEdad + sumatoriaEdad(a^.HD);
				sumatoriaEdad:= sumatoriaEdad + a^.dato.edad;
			end
			else
				sumatoriaEdad:=0;
		End;}
		
	function sumatoriaEdad(a:arbol):integer;
		begin
		if (a <> nil) then 
			sumatoriaEdad:= (sumatoriaEdad(a^.HI) + sumatoriaEdad(a^.HD) ) + a^.dato.edad
		else
			sumatoriaEdad:=0;
		end;
	
	
	var cant:integer;
	begin
		cant:=cantSocios(a);
		if cant > 0 then
		prom:=(sumatoriaEdad(a) / cant)
		else
			prom:=0;
	end;
	
function promedioEdad(a:arbol; k:integer):real; 
{esta manera hace muchos calculos y se necesita saber el numero de socios de antemano, pero la solucion me parece original. 
* Funciona porque la sumatoria de n elementos de i hasta k, dividido por k, es lo mismo que la sumatoria de cada elemento dividido por k, 
* k en este caso es el numero de socios. ventaja:todo en una funcion, cumple lo que pide el enunciado}
		begin
			if (a <> nil) then 
				promedioEdad:=  (promedioEdad(a^.HI, k) + promedioEdad(a^.HD, k)) + ( a^.dato.edad / k)
			else
				promedioEdad:=0;
		End;
		

function informoSocioEnRango(a:arbol; v1, v2:integer):integer;
	begin
		if (a <> nil) then begin
		
			if (a^.dato.numSocio >= v1) and ( a^.dato.numSocio <= v2) then 
				informoSocioEnRango:= informoSocioEnRango(a^.HI, v1, v2) + informoSocioEnRango(a^.HD, v1, v2) + 1
			else 
				if (a^.dato.numSocio < v1) then informoSocioEnRango:=informoSocioEnRango(a^.HD, v1, v2)
				else informoSocioEnRango:=informoSocioEnRango(a^.HI, v1, v2);
				
			end
		else
			informoSocioEnRango:=0;
	End;
	
	
procedure informoNumSocioCreciente(a:arbol);
	begin
		if (a <> nil) then begin
			informoNumSocioCreciente(a^.HI);
			writeln(a^.dato.numSocio);
			informoNumSocioCreciente(a^.HD);
		end;
	End;
	
	
procedure informoNumSocioParDecreciente(a:arbol);
	begin
		if (a <> nil) then begin
			informoNumSocioParDecreciente(a^.HD);
			if (a^.dato.numSocio mod 2 = 0) then 
				writeln(a^.dato.numSocio);
			informoNumSocioParDecreciente(a^.HI);
			end;
	End;
	
	
	
var a:arbol; //k:integer; //cant:integer;
begin
    //a	   crearArbol(a);
	//i    writeln(informoMaxNum(a));
    //ii   informoInciso2(a);
	//iii MAL HECHO 	writeln(retornoMaxEdad(a).numSocio);
	//iv   aumentoEdad(a);
	//v    writeln(existeSocio(a, 4));
	//vi   writeln(existeNombre(a, 'hola'));
	
	//vii  writeln(cantSocios(a));
	//     writeln(cantSocios(a));
	//     cant:=0;
	//     cantSocios(a, cant);
	
	//if cantSocios(a) <> 0 then
	//	k:=cantSocios(a)
	//else
	//k:=1;
	
	//viii  este cumple el enunciado pero hace mas calclos
	// writeln(promedioEdad(a, k));
	//       writeln(prom(a):3:3);
	
	//ix   writeln(informoSocioEnRango(a, 10, 20));
	//x    informoNumSocioCreciente(a);
	//xi informoNumSocioParDecreciente(a);
end.