{
2. Escribir un programa que:
a. Implemente un módulo que genere aleatoriamente información de ventas de un comercio.
Para cada venta generar código de producto, fecha y cantidad de unidades vendidas. Finalizar
con el código de producto 0. Un producto puede estar en más de una venta. Se pide:
i. Generar y retornar un árbol binario de búsqueda de ventas ordenado por código de
producto. Los códigos repetidos van a la derecha.
ii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la
cantidad total de unidades vendidas.
iii. Generar y retornar otro árbol binario de búsqueda de productos vendidos ordenado por
código de producto. Cada nodo del árbol debe contener el código de producto y la lista de
las ventas realizadas del producto.
Nota: El módulo debe retornar TRES árboles.
b. Implemente un módulo que reciba el árbol generado en i. y una fecha y retorne la cantidad
total de productos vendidos en la fecha recibida.
c. Implemente un módulo que reciba el árbol generado en ii. y retorne el código de producto
con mayor cantidad total de unidades vendidas.
d. Implemente un módulo que reciba el árbol generado en iii. y retorne el código de producto
con mayor cantidad de ventas.
   
}


program comercio;

uses crt;
const
	fin=0;
type
	venta=record
		codP:integer;
		fecha:integer;
		cant:integer;
	end;
	venta2=record
		codP:integer;
		cant:integer;
	end;
	arbolA=^nodo;
	nodo=record
		dato:venta;
		HI:arbolA;
		HD:arbolA;
	end;
	ArbolB=^nodoB;
	nodoB=record
		dato:venta2;
		HI:arbolB;
		HD:arbolB;
	end;
	
	lista = ^nodoV;
	nodoV=record
		dato:venta;
		sig:lista;
	end;
	
	venta3=record
		codP:integer;
		ventas:lista;
	end;
	arbolC=^nodoC;
	nodoC=record
		dato:venta3;
		HI:arbolC;
		HD:arbolC;
	end;
		
	
procedure GenerarVentas(var a:arbolA;var b:arbolB;var c:arbolC);
	procedure LeerVenta(var v:venta);
	begin
		v.codP:=random(21);
		if(v.codP<>0)then	
			begin
				
				v.fecha := 2000+random(3)+random(12)+1+random(31)+1;
				v.cant:=random(41);
			end;
	end;
	procedure InsertarElemento(var a:arbolA;v:venta);
	begin
		if(a=nil)then
			begin
				new(a);
				a^.dato:=v;
				a^.HI:=nil;
				a^.HD:=nil;
			end
		else
			if(v.codP < a^.dato.codP)then
				InsertarElemento(a^.HI,v)
			else
				InsertarElemento(a^.HD,v);
	end;
	procedure InsertarElementoB(var b:arbolB;v:venta);
	begin
		if(b=nil)then
			begin
				new(b);
				b^.dato.codP := v.codP;
				b^.dato.cant := v.cant;
				b^.HI:=nil;
				b^.HD:=nil;
			end
		else
			if(v.codP < b^.dato.codP)then
				InsertarElementoB(b^.HI,v)
			else
				if(v.codP = b^.dato.codP)then
					b^.dato.cant := b^.dato.cant + v.cant
				else
					if(v.codP > b^.dato.codP)then
						InsertarElementoB(b^.HD,v);
	end;
procedure InsertarElementoC(var c:arbolC;v:venta);
procedure agregarAdelante(var l:lista;v:venta);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=v;
	nue^.sig:=nil;
	if l=nil then
		l:=nue
	else
		nue^.sig:=l;
		l:=nue;
end;
begin
	if(c=nil)then
		begin
			new(c);
			c^.dato.codP := v.codP;
			agregarAdelante(c^.dato.ventas,v);
			c^.HI:=nil;
			c^.HD:=nil;
		end
	else
		if(v.codP < c^.dato.codP)then
			InsertarElementoC(c^.HI,v)
		else
			if(v.codP=c^.dato.codP)then
				agregarAdelante(c^.dato.ventas,v)
			else
				InsertarElementoC(c^.HD,v);
end;
var
	v:venta;
begin
	LeerVenta(v);
	while(v.codP<>0)do
		begin
			InsertarElemento(a,v);
			InsertarElementoB(b,v);
			InsertarElementoC(c,v);
			LeerVenta(v);
		end;
end;
procedure ImprimirVentasA(a:arbolA);
begin
	if(a<>nil)then
		begin
			ImprimirVentasA(a^.HI);
			writeln('CodP = ',a^.dato.codP,' Fecha = ',a^.dato.fecha,' Cant = ',a^.dato.cant);
			ImprimirVentasA(a^.HD);
		end;
end;
procedure ImprimirVentasB(b:arbolB);
begin
	if(b<>nil)then
			begin
				ImprimirVentasB(b^.HI);
				writeln('CodP = ',b^.dato.codP,' Cant = ',b^.dato.cant);
				ImprimirVentasB(b^.HD);
			end;
end;
procedure InformeA(a:arbolA);
	function AcumCant(a:arbolA;f:integer):integer;
	begin
		if(a<>nil)then
			if(a^.dato.fecha = f)then
				AcumCant:= a^.dato.cant + AcumCant(a^.HI,f) + AcumCant(a^.HD,f)
			else
				AcumCant:=0+AcumCant(a^.HI,f)+AcumCant(a^.HD,f)
		else
			AcumCant:=0;
	end;
var
	fecha:integer;
	cant:integer;
begin
	cant:=0;
	writeln('Ingrese una fecha a buscar en el Arbol: ');
	readln(fecha);
	cant:= AcumCant(a,fecha);
	writeln('En la Fecha : ',fecha,' Se vendio una totalidad de :',cant,' productos');
end;
procedure ActualizarMaximo(var codM,cantM:integer;cod,cant:integer);
begin
	if(cant > cantM)then	
		begin
			cantM:=cant;
			codM:=cod;
		end;
end;
procedure InformeB(b:arbolB);
	procedure maximo(b:arbolB;var codM,cantM:integer);
	begin
		if(b<>nil)then
			begin
				ActualizarMaximo(codM,cantM,b^.dato.codP,b^.dato.cant);
				maximo(b^.HI,codM,cantM);
				maximo(b^.HD,codM,cantM);
			end;
	end;
var
	codMax:integer;
	cantMax:integer;
begin
	cantMax:=-1;
	codMax:=-1;
	maximo(b,codMax,cantMax);
	if(cantMax<>-1)then
		writeln('El producto con mayor cantidad total de unidades vendidas es: ',codMax)
	else
		writeln('El Arbol no cuenta con elementos: ');
end;
procedure InformeC(c:arbolC);
	function contar(l:lista):integer;
	begin
		if(l<>nil)then
			contar:=1+contar(l^.sig)
		else
			contar:=0;
	end;
	procedure maximo(c:arbolC;var codM,maxV:integer);
	begin
		if(c<>nil)then
			begin
				actualizarMaximo(codM,maxV,c^.dato.codP,contar(c^.dato.ventas));
				maximo(c^.HI,codM,maxV);
				maximo(c^.HD,codM,maxV);
			end;
	end;
	
var
	maxVent:integer;
	codMax:integer;
begin
	maxVent:=-1;
	codMax:=-1;
	maximo(c,codMax,maxVent);
	if(codMax=-1)then
		writeln('El Arbol no contiene elementos: ')
	else
		writeln('El producto con codigo: ',codMax,' es el que mas ventas tuvo');
end;
var	
	a: arbolA;
	b:arbolB;
	c:arbolC;
	ok:integer;
BEGIN
	randomize;
	a:=nil;
	b:=nil;
	GenerarVentas(a,b,c);
	writeln('pulse');
	read(ok);
	ImprimirVentasA(a);
	writeln('Pulse un numero para Continuar: ');
	read(ok);
	ImprimirVentasB(b);
	InformeA(a);
	InformeB(b);
	InformeC(c);
END.

