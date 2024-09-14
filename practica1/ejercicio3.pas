{
3.- Netflix ha publicado la lista de películas que estarán disponibles durante el mes de diciembre 
de 2022. De cada película se conoce: código de película, código de género (1: acción, 2: aventura, 
3: drama, 4: suspenso, 5: comedia, 6: bélico, 7: documental y 8: terror) y puntaje promedio 
otorgado por las críticas. 
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:

a. Lea los datos de películas, los almacene por orden de llegada y agrupados por código de 
género, y retorne en una estructura de datos adecuada. La lectura finaliza cuando se lee el 
código de la película -1.

b. Genere y retorne en un vector, para cada género, el código de película con mayor puntaje 
obtenido entre todas las críticas, a partir de la estructura generada en a)..

c. Ordene los elementos del vector generado en b) por puntaje utilizando alguno de los dos 
métodos vistos en la teoría. 

d. Muestre el código de película con mayor puntaje y el código de película con menor puntaje, 
del vector obtenido en el punto c).
}


program netflix;

uses crt;
type
	tCodG = 1..8;
	tPuntaje=0..10;
	pelicula = record
		codP:integer;
		codGen:tCodG;
		puntaje:tPuntaje;
	end;
	lista = ^nodo;
	nodo = record
		dato:pelicula;
		sig:lista;
	end;
	
	vlista=array[tCodG]of lista;
	vMay=array[tCodG]of pelicula;

{inicializar el vector de listas}
procedure inicializarPel(var p:pelicula);
begin	
	p.codP:=-1;
	p.codGen:=1;
	p.puntaje:=0;
end;
procedure inicializarVecPeliculas(var v:vMay);
var
	i:tCodG;
	pel:pelicula;
begin	
	inicializarPel(pel);
	for i:=1 to 8 do
		v[i]:=pel;
end;
procedure inicializarVec(var v:vlista);
var
	i:tCodG;
begin	
	for i:=1 to 8 do 
		v[i]:=nil;
end;
{imprimir una lista}
procedure ImprimirLista(p:lista);
var
	aux:lista;
begin
	aux:=p;
	while(aux<>nil)do
		begin
			writeln('Cod = ',aux^.dato.codP,' Cod Genero = ',aux^.dato.codGen,'Puntaje =',aux^.dato.puntaje);
			aux:=aux^.sig;
		end;
end;
{imprimir un vector con una lista dentro de cada item}
procedure ImprimirPeliculas(v:vlista);
var
	i:tCodG;
begin	
	for i:=1 to 8 do 
		begin
			writeln('____________________________________________________________________________________________');
			ImprimirLista(v[i]);
		end;
end;
{cargar un vector de lista}
procedure CargarPeliculas(var v:vlista);
	{Agregar adelante en una lista}
	procedure AgregarAdelante(var pri:lista;p:pelicula);
	var 
		nuevo:lista;
	begin
		new(nuevo);
		nuevo^.dato:=p;
		nuevo^.sig:=nil;
		if(pri=nil)then
			pri:=nuevo
		else
			begin
				nuevo^.sig:=pri;
				pri:=nuevo;
			end;
	end;
	{leer un registro de pelicula}
	procedure LeerPelicula(var p:pelicula);
	begin	
		writeln('Ingrese el codigo de la pelicula: ');
		readln(p.codP);
		if(p.codP<>-1)then
			begin
				writeln('Ingrese el genero de pelicula: [1..8]: ');
				read(p.codGen);
				writeln('Ingrese el puntaje promedio de critica: ');
				read(p.puntaje);
			end;
	end;
var
	pel:pelicula;
begin	
	LeerPelicula(pel);
	while(pel.codP<>-1)do
		begin	
			AgregarAdelante(v[pel.codGen],pel);
			LeerPelicula(pel);
		end;
end;

{filtrar para cada lista del vector un elemento con mayor puntaje}
procedure filtrarMayor(vecPel:vlista;var v:vMay);
	
	procedure mayorLista(pri:lista;var may:pelicula);
	var
		aux:lista;
	begin
		aux:=pri;
		while(aux<>nil)do
			begin	
				if (aux^.dato.puntaje > may.puntaje)then
					begin
						may:=aux^.dato;
					end;
				aux:=aux^.sig;
			end;
	end;

var
	i:tCodG;
	may:pelicula;
	
begin

	for i:=1 to 8 do 
		begin
			may.codP:=0;
			may.codGen:=1;
			may.puntaje:=0;
			mayorLista(vecPel[i],may);
			v[i]:=may;
		end;	
end;
procedure seleccion(var v:vMay);
var
	i,j,pos:tcodG;
	elem:pelicula;
begin
	for i:=1 to 7 do 
		begin
			pos:=i;
			for j:= i+1 to 8 do 
				if(v[j].puntaje<v[pos].puntaje)then
					pos:=j;
			elem:=v[pos];
			v[pos]:=v[i];
			v[i]:=elem;
		end;
end;
	
procedure ImprimirVector(vectorMay:vMay; dimL:tCodG);
var
	i:integer;
begin
	for i:=1 to dimL do 
		begin	
			writeln('ELemento = ',i,' Mayor puntaje = ',vectorMay[i].codP);
		end;
end;
procedure ImprimirMaxMen(v:vMay;dimL:tCodG);
var
	i:tCodG;
begin
	i:=1;
	while(i<dimL)and(v[i].codP-1)do
		begin	
			i:=i+1;
		end;
	if (i<dimL) then
		writeln('El elemento minimo es: ',v[i].codP,' y el elemento maximo es : ',v[dimL].codP);
end;
var 
	vectorPel:vlista;{vector con todas las listas de peliculas segun genero}
	vectorMay:vMay;
BEGIN
		inicializarVec(vectorPel);
		CargarPeliculas(vectorPel);
		ImprimirPeliculas(vectorPel);
		inicializarVecPeliculas(vectorMay);
		filtrarMayor(vectorPel,vectorMay);
		writeln('Los codigos de peliculas con mayor puntaje por genero son: ');
		ImprimirVector(vectorMay,8);
		seleccion(vectorMay);
		writeln('Vector Ordenado por puntaje de reseña:');
		ImprimirVector(vectorMay,8);
		ImprimirMaxMen(VectorMay,8);
		
END.

