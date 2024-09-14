{
2.- Escribir un programa que:
a. Implemente un módulo recursivo que genere y retorne una lista de números enteros
“random” en el rango 100-200. Finalizar con el número 100.
b. Un módulo recursivo que reciba la lista generada en a) e imprima los valores de la lista en el
mismo orden que están almacenados.
c. Implemente un módulo recursivo que reciba la lista generada en a) e imprima los valores de
la lista en orden inverso al que están almacenados.
d. Implemente un módulo recursivo que reciba la lista generada en a) y devuelva el mínimo
valor de la lista.
e. Implemente un módulo recursivo que reciba la lista generada en a) y un valor y devuelva
verdadero si dicho valor se encuentra en la lista o falso en caso contrario
   
}


program recursividadListas;

uses crt;
const
	min=100;
	max=200;
type
	lista=^nodo;
	nodo=record
		dato:integer;
		sig:lista;
	end;
procedure ImprimirListaRecursivo(pri:lista);
begin
		if(pri<>nil)then
			begin
				write(pri^.dato,' | ');
				ImprimirListaRecursivo(pri^.sig);
			end;
end;
			
procedure CargarListaRecursivo(var pri:lista);
procedure AgregarAdelante(var pri:lista;elem:integer);
var
	nue:lista;
begin
	new(nue);
	nue^.dato:=elem;
	nue^.sig:=nil;
	if(pri=nil)then
		pri:=nue
	else
		begin
			nue^.sig:=pri;
			pri:=nue;
		end;
end;
var
	elem:integer;
begin
	elem:=min+random(max-min+1);
	if(elem<>100)then
		begin
			AgregarAdelante(pri,elem);
			CargarListaRecursivo(pri);
		end;
		
end;
procedure MostrarLista(l:lista);
begin
	while(l<>nil)do
		begin
			write(l^.dato,' | ');
			l:=l^.sig;
		end;
end;
procedure ImprimirListaRecursivoInverso(pri:lista);
begin
	if(pri<>nil)then
		begin
			ImprimirListaRecursivoInverso(pri^.sig);
			write(' ',pri^.dato,' |');
		end;
end;
Function MinimoRecursivo(pri:lista;min:integer):integer;
begin
	if(pri<>nil)then
		begin	
			if(pri^.dato < min)then
				min:=pri^.dato;
			MinimoRecursivo := MinimoRecursivo(pri^.sig,min);
		end
	else
		MinimoRecursivo:=min;
end;
function BuscarElementoEnLista(pri:lista;elem:integer):boolean;
begin
	if(pri<>nil)then
		if(pri^.dato = elem)then
			BuscarElementoEnLista:=true
		else
			BuscarElementoEnLista:=BuscarElementoEnLista(pri^.sig,elem)
	else
		BuscarElementoEnLista:=false;
end;
var
	listaEnteros:lista;
	minimo:integer;
	elem:integer;
	encontrado:boolean;
BEGIN
	randomize;
	minimo:=201;
	encontrado:=false;
	listaEnteros:=nil;
	CargarListaRecursivo(listaEnteros);
	writeln('Muestra de lista recursivo');
	ImprimirListaRecursivo(listaEnteros);
	writeln();
	ImprimirListaRecursivoInverso(listaEnteros);
	minimo:=MinimoRecursivo(listaEnteros,minimo);
	writeln('El valor Minimo de la lista es: ',minimo);
	writeln('Ingrese el valor a Buscar en la lista: ');
	read(elem);
	encontrado:=BuscarElementoEnLista(listaEnteros,elem);
	if(encontrado)then	
		writeln('El Elemento: ',elem,' se encuentra en la lista')
	else
		writeln('El elemento: ',elem,' no se encuentra en la lista');
	
END.

