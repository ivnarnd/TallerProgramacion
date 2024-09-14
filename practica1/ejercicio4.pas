{
4.- Una librería requiere el procesamiento de la información de sus productos. De cada producto 
se conoce el código del producto, código de rubro (del 1 al 8) y precio. 
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados 
por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza cuando se 
lee el precio 0.-
* 
b. Una vez almacenados, muestre los códigos de los productos pertenecientes a cada rubro.
* 
c. Genere un vector (de a lo sumo 30 elementos) con los productos del rubro 3. Considerar que 
puede haber más o menos de 30 productos del rubro 3. Si la cantidad de productos del rubro 3 
es mayor a 30, almacenar los primeros 30 que están en la lista e ignore el resto. 
* 
d. Ordene, por precio, los elementos del vector generado en c) utilizando alguno de los dos 
métodos vistos en la teoría.
* 
e. Muestre los precios del vector resultante del punto d).
* 
f. Calcule el promedio de los precios del vector resultante del punto d)
   
   
}


program Libreria2024;

uses crt;
const
	fin=0;
	dimF=30;
type
	tRubro=1..8;
	producto=record
		codigoP:integer;
		codigoR:tRubro;
		precio:real;
	end;
	lista = ^nodo;
	nodo = record
		dato:producto;
		sig:lista;
	end;
	vLista = array[tRubro] of lista;
	vectorRubro = array[1..dimF] of producto;
procedure ImprimirProducto(p:producto);
begin
	write('Cod Producto =',p.codigoP,' Codigo de Rubro = ',p.codigoR,' precio = $',p.precio:4:3,'...');
end;
procedure CrearLista(var v:vLista);
var
	i:integer;
	
begin
	for i:=1 to 8 do
		v[i]:=nil;
end;
procedure Insertar(var pI:lista;valor:producto);
var
	nuevo,actual,ant:lista;
begin
	new(nuevo);
	nuevo^.dato:=valor;
	nuevo^.sig:=nil;
	if(pI=nil)then
		pI:=nuevo
	else
		begin
			actual:=pI;
			ant:=pI;
			while(actual<>nil)and(actual^.dato.codigoP < nuevo^.dato.codigoP)do 
				begin
					ant:=actual;
					actual:=actual^.sig;
				end;
			if (actual = pI) then
				begin	
					nuevo^.sig:=pI;
					pI:=nuevo;
				end
			else
				if(actual<>nil)then
					begin	
						ant^.sig:=nuevo;
						nuevo^.sig:=actual;
					end
				else
					begin
						ant^.sig:=nuevo;
						nuevo^.sig:=nil;
					end;
		end;
end;
procedure LeerProducto(var p:producto);
begin
	p.codigoP:=random(1000);
	writeln(p.codigoP);
	if(p.codigoP<>0)then
		begin
			p.codigoR:=random(8)+1;
			p.precio:=random(10000);
		end;
end;
procedure CargarProductos(var v:vLista);
var
	prod:producto;
begin
	LeerProducto(prod);
	while(prod.codigoP<>0)do
		begin
			Insertar(v[prod.codigoR],prod);
			LeerProducto(prod);
		end;
end;
procedure ImprimirLista(pI:lista);
var
	aux:lista;
begin
	aux:=pI;
	while(aux<>nil)do
		begin
			ImprimirProducto(aux^.dato);
			aux:=aux^.sig;
		end;
end;
procedure ImprimirProductosXRubro(v:vLista;dimL:integer);
var
	i:integer;
begin	
	for i:=1 to dimL do
		begin
		writeln('-------------------------------------------------------------------------------------------------------------------------');
			writeln('Codigo de Rubro : ',i);
			ImprimirLista(v[i]);
		end;
end;
procedure CargarVectorRubro(var vecProd:vLista;var v:vectorRubro;var dimL:integer);
var
	aux:lista;
begin
	aux:=vecProd[3];
	while(aux<>nil)and(dimL<30)do
		begin	
			dimL:=dimL+1;
			v[dimL]:=aux^.dato;
			aux:=aux^.sig;
		end;
end;
procedure Seleccion(var v:vectorRubro; dimL:integer);
var
	i,j,pos:integer;
	item:producto;
begin
	for i:=1 to dimL-1 do 
		begin
			pos:=i;
			for j:=i+1 to dimL do 
				if(v[j].precio<v[pos].precio)then
					pos:=j;
			item:=v[pos];
			v[pos]:=v[i];
			v[i]:=item;
		end;
end;
procedure ImprimirVectorRubro(v:vectorRubro;dimL:integer);
var
	i:integer;
begin
	for i:=1 to dimL do
		begin
			ImprimirProducto(v[i]);
			writeln();
		end;
end;
function promedio(v:vectorRubro;dimL:integer):real;
var
	i:integer;
	acumulado:real;
	prom:real;
begin
	acumulado:=0;
	for i:=1 to dimL do 
		acumulado:=acumulado+v[i].precio;
	prom:=acumulado/dimL;
	promedio:=prom;
end;
		
var 
	vectorProd: vLista;
	vecRubro:vectorRubro;
	dimL:integer;

BEGIN
	randomize;
	CrearLista(vectorProd);
	CargarProductos(vectorProd);
	ImprimirProductosXRubro(vectorProd,8);
	dimL:=0;
	CargarVectorRubro(vectorProd,vecRubro,dimL);
	ImprimirVectorRubro(vecRubro,dimL);
	Seleccion(vecRubro,dimL);
	ImprimirVectorRubro(vecRubro,dimL);
	writeln('El promedio de precios del rubro 3 es : ',promedio(vecRubro,dimL):4:2);
END.

