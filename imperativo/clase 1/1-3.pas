program a;
const 
	GENEROS_CANT=8;
type
	Generos = 1..GENEROS_CANT;
	peli=record
		codigo : Integer;
		genero:Generos;
		puntaje:Real
	end;
	PeliculasAgrup=array[Generos] of PelisLista;
	PelisLista=^NodoPeli;
	NodoPeli=record
		elem : peli;
		sig:PelisLista;
	end;

procedure CargarPelis();
	
	var
		peliAux:peli;
	begin
	LeerPelicula(peliAux);
	while peliAux.codigo<>-1 do
	begin
	 	agregar
	end; 
end;


begin
	
end.