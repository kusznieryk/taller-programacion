

{3.- Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random” mayores a 0 y menores a 100.
Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista. 
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista. 
d. Implemente un módulo recursivo que devuelva verdadero si un valor determinado se encuentra en la lista o falso en caso contrario. 
}

program ej3;

type
    rango = 1..99;
    lista = ^nodo;
    
    nodo = record    
        dato:rango;
        sig:lista;
        end;
     
procedure generoLista(var l:lista);
    var aux:lista; num:integer;
    begin
        num:=random(10);
        if num <> 0 then begin
            new(aux); 
            aux^.dato:=num;
            aux^.sig:=l;
            l:=aux;
            generoLista(l);
            end;
    End;

procedure escriboLista(l:lista);
    begin
        while(l<> nil) do begin
            writeln(l^.dato);
            l:=l^.sig;
            end;
        end;

function minLista(l:lista; var min:integer):integer;
    begin
        if (l<> nil) then begin
            if (l^.dato < min) then
                min:=l^.dato;
            l:=l^.sig;
            minLista := minLista(l, min)    
            end;
        minLista:=min;
    end;
        
function maxLista(l:lista; var max:integer):integer;
    begin
        if (l<> nil) then begin
            if (l^.dato > max) then
                max:=l^.dato;
            l:=l^.sig;
            maxLista := maxLista(l, max)    
            end;
        maxLista:=max;
    end;   

function buscarNum(l:lista; dato:integer ):boolean;
begin
    if(l <> nil) and (l^.dato <> dato) then 
        buscarNum:=buscarNum(l^.sig, dato)
    else
         buscarNum:= l<>nil;
end;

function sumaLista(l:lista):integer;
begin
    if(l<>nil) then
        sumaLista:=l^.dato+sumaLista(l^.sig)
    else
        sumaLista:=0;
end;
var l:lista; min:integer; max:integer;
begin
    randomize;
    l:=nil;
    generoLista(l);
    min:=999;;
    max:=-1;
   writeln(minLista(l, min));
    writeln(maxLista(l, max));
    writeln(buscarNum(l,9));
    writeLn(sumaLista(l))
end.
