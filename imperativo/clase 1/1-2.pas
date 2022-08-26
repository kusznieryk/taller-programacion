{
.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de las expensas de dichas oficinas. 
Implementar un programa modularizado que:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se ingresa el código de identificación,
	 DNI del propietario y valor de la expensa. La lectura finaliza cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}
program ej2;
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
	    {Randomize; lo pongo entre corchetes porque por algun motivo hacia que no se ejecute random() si lo dejo}
	    theOffice.id:=random(20) - 1;
	    writeln (theOffice.id);
	    if (theOffice.id <> -1)
	    then begin
	    	theOffice.dni:=random(100);
	    	writeln (theOffice.dni);
	    	theOffice.precio:=random(1000)/100;
	    	writeln (theOffice.precio:2:2);
	        end
	    else
	      writeln('se recibio la id -1');
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
<<<<<<< HEAD

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

=======
	
procedure OrdenamientoSeleccion(var v:vector; dimL:rango);
  var i,j,item:integer;
  begin
    for i:=1 to dimL - 1 do begin
      for j:=i+1 to dimL do begin
        if v[j].id < v[i].id then begin
          item:=v[i].id;
          v[i].id:=v[j].id;
          v[j].id:=item;
          end;
        end; 
      end;
  End;
  
{procedure OrdenamientoSeleccionComoEstaEnLaTeoria(var v:vector; dimL:rango);
  var i,j,item, p:integer;
  begin
    for i:=1 to dimL - 1 do begin
      p:=i;
      for j:=i+1 to dimL do begin
        if v[j].id < v[p].id then begin
          p:=j;
          item:=v[i].id;
          v[i].id:=v[p].id;
          v[p].id:=item;
          end;
        end; 
      end;
      * No entiendo porque esta p si j es perfectamente capaz de hacer el trabajo
  End;}
  
  
procedure OrdenamientoInsercion(var v:vector; dimL:rango);
  var i,j,actual:integer;
  begin
    for i:=2 to diml do begin
      actual:=v[i].id; 
      j:=i-1;
      while (j > 0) and (v[j].id > actual) do begin
        v[j+1].id:=v[j].id;
        j:=j-1;
        end;
      v[j+1].id:=actual;
      end;
        
  End;
  
>>>>>>> f094a34f76e988f550afefcee476a29a80657f80
var oficinas:vector;
	dimL:rango;
begin
	AlmacenarInformacion(oficinas, dimL);
	ImprimirVector(oficinas,diml);
<<<<<<< HEAD
	OrdenarSeleccion(oficinas,dimL);
	//OrdenarInsercion(oficinas,dimL);
	ImprimirVector(oficinas,diml);

=======
    {OrdenamientoSeleccion(oficinas, dimL);}
    OrdenamientoInsercion(oficinas, dimL); 
    ImprimirVector(oficinas,dimL);
>>>>>>> f094a34f76e988f550afefcee476a29a80657f80
end.