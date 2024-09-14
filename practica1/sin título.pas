{
4.- Una librería requiere el procesamiento de la información de sus productos. De cada producto 
se conoce el código del producto, código de rubro (del 1 al 8) y precio. 
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Lea los datos de los productos y los almacene ordenados por código de producto y agrupados 
por rubro, en una estructura de datos adecuada. El ingreso de los productos finaliza cuando se 
lee el precio 0.
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
				end
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
	writeln('Ingrese el codigo de producto: ');
	readln(p.codigoP);
	if(codigoP<>0)then
		begin	
			writeln('Ingrese el codigo de Rubro:  ');
			readln(p.codigoR);
			writeln('Ingrese el precio del Producto: ');
			readln(p.precio);
		end;
end;
procedure CargarProductos(var v:vLista);
var
	prod:producto;
begin
	LeerProducto(prod);
	while(prod.codP<>0)do
		begin
			Insertar(v[prod.codR],prod);
			LeerProducto(prod);
		end;
end;
var 
	vectorProd: vLista;

BEGIN
	CrearLista(vectorProd);
	CargarProductos(vectorProd);
	
	
END.

