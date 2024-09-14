{
3.- Implementar un programa que invoque a los siguientes módulos.
a. Un módulo recursivo que retorne un vector de 20 números enteros “random” mayores a 300
y menores a 1550 (incluidos ambos).

b. Un módulo que reciba el vector generado en a) y lo retorne ordenado. (Utilizar lo realizado
en la práctica anterior)
c. Un módulo que realice una búsqueda dicotómica en el vector, utilizando el siguiente
encabezado:
Procedure busquedaDicotomica (v: vector; ini,fin: indice; dato:integer; var pos: indice);
Nota: El parámetro “pos” debe retornar la posición del dato o -1 si el dato no se encuentra
en el vector.
   
}


program enteros;

uses crt;
const
	min = 300;
	max = 1550;
type
	vecEnteros = array [1..20] of integer;

{modulos}
procedure CargarVectorRecursivo(var v:vecEnteros; var dimL:integer);
var
	num:integer;
begin
	if(dimL < 20)then
		begin
			num := min + random(max - min + 1);
			dimL:=dimL+1;
			v[dimL]:=num;
			CargarVectorRecursivo(v,dimL);
		end;
end;
procedure ImprimirVector(v:vecEnteros;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do 
		write(v[i],' |');
end;
procedure ordenarVector(var v:vecEnteros; dimL:integer);
var
	i,j,pos,elem:integer;
begin
	 for i:=1 to dimL-1 do
		begin
			pos:=i;
			for j:=i+1 to dimL do 
				begin
					if(v[j] < v[pos])then
						pos:=j;
				end;
			elem:=v[pos];
			v[pos]:=v[i];
			v[i]:=elem;
		end;
end;
procedure busquedaDicotomica(v:vecEnteros;ini,fin:integer;dato:integer;var pos:integer);
var
	mid:integer;
begin
	pos:=-1;
	mid:=(ini+fin) div 2;
	while((ini<=fin)and(dato<>v[mid]))do
		begin
			if(dato<v[mid])then
				fin:=mid-1
			else
				ini:=mid+1;
			mid:=(ini+fin) div 2;
		end;
	if (ini<=fin)and(dato=v[mid]) then
		pos:=mid;
end;
var 
	vec:vecEnteros;
	dimL:integer;
	num:integer;
	pos:integer;
BEGIN
	randomize;
	dimL:=0;
	CargarVectorRecursivo(vec,dimL);
	ImprimirVector(vec,dimL);
	writeln;
	ordenarVector(vec,dimL);
	writeln('Vector Ordenado de menor a mayor');
	ImprimirVector(vec,dimL);
	writeln;
	writeln('Ingrese un Numero a buscar en el vector: ');
	num := min + random(max - min + 1);
	busquedaDicotomica(vec,1,dimL,num,pos);
	if(pos<>-1)then
		writeln('El numero: ',num,' Se encuentra en la posicion: ',pos)
	else
		writeln('El numero: ',num,' No se encuentra en el vector: ');
END.

