{
.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas. 
Implementar un programa modularizado que:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el código de identificación,
	 DNI del propietario y valor de la expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.

}
program aaa;
const 
	DIM_F=300;
type
	rango=1..DIM_F;
	oficina = record
		id : integer;
		dni:integer;
		precio:Real;
	end;

	vector=array[rango] of oficina;

procedure AlmacenarInformacion (var v: vector; var dimL: rango); 
  procedure LeerOficina (var theOffice: oficina);
	  begin
	    Randomize;
	    theOffice.id:=random(100);
	    writeln (theOffice.id);
	    if (theOffice.id <> -1)
	    then begin
	    	theOffice.dni:=random(100);
	    	writeln (theOffice.dni);
	    	theOffice.precio:=random(1000)/100;
	    	writeln (theOffice.precio:2:2);
	        end;
	  	end;

	var unaOfi:oficina;
	begin
    	dimL := 0;
	    LeerOficina (unaOfi);
	    while (unaOfi.id<>-1)  and ( dimL < DIM_F ) do 
	    begin
	       dimL := dimL + 1;
	       v[dimL]:= unaOfi;
		   LeerOficina (unaOfi);
	    end;
	end;
procedure ImprimirVector (v: vector; dimL: rango);
	var
	   i: integer;
	begin
	     for i:= 1 to dimL do
	         write ('-----');
	     writeln;
	     write (' ');
	     for i:= 1 to dimL do begin
	        if(v[i].id <= 9)then
	            write ('0');
	        write(v[i].id, ' | ');
	     end;
	     writeln;
	     writeln;
	     write (' ');
	     for i:= 1 to dimL do begin
	        if (v[i].dni <= 9)then
	            write ('0');
	        write(v[i].dni, ' | ');
	     end;
	     writeln;
	     for i:= 1 to dimL do
	         write ('-----');
	     writeln;
	     writeln;
	End;

Procedure OrdenarInsercion ( var v: vector; dimL: rango );
	var i, j: rango; actual:oficina;	
		
	begin
	 for i:=2 to dimL do begin 
	     actual:= v[i];
	     j:= i-1; 
	     while (j > 0) and (v[j].id > actual.id) do      
	       begin
	         v[j+1]:= v[j];
	         j:= j - 1;                  
	       end;  
	     v[j+1]:= actual; 
	 end;
	end;

Procedure OrdenarSeleccion ( var v: vector; dimL:rango  );
	var i, j, p: rango; item : oficina;
	begin
	 for i:=1 to dimL-1 do begin {busca el mínimo y guarda en p la posición}
	          p := i;
	          for j := i+1 to dimL do
	             if v[ j].id < v[ p ].id then p:=j;

	         {intercambia v[i] y v[p]}
	         item := v[ p ];   
	         v[ p ] := v[ i ];   
	         v[ i ] := item;
	      end;
	end;

var oficinas:vector;
	dimL:rango;
begin
	AlmacenarInformacion(oficinas, dimL);
	ImprimirVector(oficinas,diml);
	OrdenarSeleccion(oficinas,dimL);
	//OrdenarInsercion(oficinas,dimL);
	ImprimirVector(oficinas,diml);

end.