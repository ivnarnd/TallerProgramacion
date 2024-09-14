{
2.- El administrador de un edificio de oficinas cuenta, en papel, con la información del pago de 
las expensas de dichas oficinas. 
Implementar un programa que invoque a módulos para cada uno de los siguientes puntos:
a. Genere un vector, sin orden, con a lo sumo las 300 oficinas que administra. De cada oficina se 
ingresa el código de identificación, DNI del propietario y valor de la expensa. La lectura finaliza 
cuando se ingresa el código de identificación -1, el cual no se procesa.
b. Ordene el vector, aplicando el método de inserción, por código de identificación de la oficina.
c. Ordene el vector aplicando el método de selección, por código de identificación de la oficina.
}

program oficinas;

uses crt;
const 
	dimF=300;
type
	oficina=record
		codOf:-1..300;
		dniProp:integer;
		valorExp:real;
	end;
	vecOf=array[1..300]of oficina;
procedure CargarOficinas(var v:vecOf;var dimL:integer);
procedure LeerOficina(var ofi:oficina);
begin
	writeln('Ingrese el codigo de oficina');
	readln(ofi.codOf);
	if (ofi.codOf <> -1)then
		begin
			writeln('Ingrese el dni del propietario:');
			readln(ofi.dniProp);
			writeln('Ingrese el valor de las expensas: ');
			readln(ofi.valorExp);
		end;
end;
var
	ofi:oficina;
begin
	LeerOficina(ofi);
	while((dimL<dimF) and (ofi.codOf<>-1))do
		begin
			dimL:=dimL+1;
			v[dimL]:=ofi;
			LeerOficina(ofi);
		end;
end;
procedure MostrarOficinas(vec:vecOf;dimL:integer);
var	
	i:integer;
begin
	for i:=1 to dimL do
		begin
			writeln(i,'. Cod=',vec[i].codOf,' DNI propietario = ',vec[i].dniProp,' Exp $ ',vec[i].valorExp:4:2);
		end;
end;
procedure Seleccion(var v:vecOf;dimL:integer);
var
	i,j,pos:integer;
	ofi:oficina;
begin
	for i := 1 to dimL - 1 do
		begin
			pos:=i;
			for j := i+1 to dimL do 
				begin
					if (v[j].codOf < v[pos].codOf) then
						pos := j;
				end;
			ofi:= v[pos];
			v[pos]:= v[i];
			v[i] := ofi;
		end;
end;
procedure Insersion(var v:vecOf;dimL:integer);
var
	i,j:integer;
	actual:oficina;
begin
	for i:=2 to dimL do
		begin
			actual:=v[i];
			j:=i-1;
			while (j>0) and (v[j].codOf > actual.codOf)do
				begin
					v[j+1]:=v[j];
					j:=j-1;
				end;
			v[j+1]:=actual;
		end;
end;					
var 
	vec: vecOf;
	dimL:integer;
BEGIN
	dimL:=0;
	CargarOficinas(vec,dimL);
	writeln('Oficinas Ingresadas: ');
	MostrarOficinas(vec,dimL);
	Seleccion(vec,dimL);
	writeln('Oficinas Ordenadas por numero de oficina: ');
	MostrarOficinas(vec,dimL);
	writeln('Oficinas Ordenadas por numero de oficina: ');
	Insersion(vec,dimL);
END.

