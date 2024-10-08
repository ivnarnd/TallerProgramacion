{1.- Implementar un programa que invoque a los siguientes modulos.
a. Un modulo recursivo que retorne un vector de a lo sumo 15 numeros enteros �random� mayores a 10 y menores a 155 (incluidos ambos). La carga finaliza con 
el valor 20.
b. Un modulo no recursivo que reciba el vector generado en a) e imprima el contenido del vector.
c. Un modulo recursivo que reciba el vector generado en a) e imprima el contenido del vector.
d. Un modulo recursivo que reciba el vector generado en a) y devuelva la suma de los valores pares contenidos en el vector.
e. Un modulo recursivo que reciba el vector generado en a) y devuelva el maximo valor del vector.
f. Un modulo recursivo que reciba el vector generado en a) y un valor y devuelva verdadero si dicho valor se encuentra en el vector o falso en caso contrario.
g. Un modulo que reciba el vector generado en a) e imprima, para cada numero contenido en el vector, sus digitos en el orden en que aparecen en el numero. 
Debe implementarse un modulo recursivo que reciba el numero e imprima lo pedido. Ejemplo si se lee el valor 142, se debe imprimir 1  4  2
}

Program Clase2MI;
const dimF = 15;
      min = 10;
      max = 155;
type vector = array [1..dimF] of integer;
     

procedure CargarVector (var v: vector; var dimL: integer);

  procedure CargarVectorRecursivo (var v: vector; var dimL: integer);
  var 
	valor: integer;
  begin
    valor:= min + random (max - min + 1);
    if ((valor <> 20 ) and (dimL < dimF)) then
		begin
          dimL:= dimL + 1;
          v[dimL]:= valor;
          CargarVectorRecursivo (v, dimL);
        end;
  end;
  
begin
  dimL:= 0;
  CargarVectorRecursivo (v, dimL);
end;
 
procedure ImprimirVector (v: vector; dimL: integer);
var
   i: integer;
begin
     for i:= 1 to dimL do
         write ('------');
     writeln;
     write (' ');
     for i:= 1 to dimL do begin
        write(v[i], ' | ');
     end;
     writeln;
     for i:= 1 to dimL do
         write ('------');
     writeln;
     writeln;
End;     

procedure ImprimirVectorRecursivo (v: vector; dimL: integer);
begin    
	if(dimL=1)then
		 write(' ',v[dimL], ' | ')
	else
		begin
			ImprimirVectorRecursivo(v,dimL-1);
			write(v[dimL], ' | '); 
		end;
end; 
    
function Sumar (v: vector; dimL: integer): integer; 

  function SumarRecursivo (v: vector; pos, dimL: integer): integer;

  Begin
    if (pos <= dimL)then
		if(v[pos]mod 2=0)then
			SumarRecursivo:= SumarRecursivo (v, pos + 1, dimL) + v[pos]
		else
			SumarRecursivo:= SumarRecursivo(v,pos+1,dimL)
		  
    else 
		SumarRecursivo:=0;  
  End;
 
var
	pos: integer; 
begin
 pos:= 1;
 Sumar:= SumarRecursivo (v, pos, dimL);
end;

function  ObtenerMaximo (v: vector; dimL: integer): integer;

	function MaximoRecursivo(v:vector;maximo,dimL:integer):integer;
	begin
		if(dimL=0)then
			MaximoRecursivo:=maximo
		else
			begin
				if(v[dimL]>maximo)then
					maximo:=v[dimL];
				dimL:=dimL-1;
				MaximoRecursivo:=MaximoRecursivo(v,maximo,dimL);
			end;
				
end;
var
	maximo:integer;
begin
  {-- Completar --}
   maximo:=9;
   ObtenerMaximo := MaximoRecursivo(v,maximo,dimL);
end;     
     
function  BuscarValor (v: vector; dimL, valor: integer): boolean;
begin
  {-- Completar --}
  if(dimL=0)then
	BuscarValor:=false
  else
	begin
		if((dimL>0)and(v[dimL]=valor))then
			BuscarValor:=true
		else
			BuscarValor:=BuscarValor(v,dimL-1,valor);
	end;
end; 
procedure ImprimirNum(num:integer);

begin
	if(num<>0)then
		begin
			ImprimirNum(num div 10);
			write(num mod 10,' ');
		end;
end;
procedure ImprimirDigitos (v: vector; dimL: integer);
var
	i:integer;
begin    
     {-- Completar --}
     for i:= 1 to dimL do
		begin
			ImprimirNum(v[i]);
			write(' ');
		end;
end; 

var dimL, suma, maximo, valor: integer; 
    v: vector;
    encontre: boolean;
Begin
  randomize;
  CargarVector (v, dimL);
  writeln;
  if (dimL = 0) then
    writeln ('--- Vector sin elementos ---')
  else
	begin
        ImprimirVector(v, dimL);
		ImprimirVectorRecursivo(v, dimL);
    end;
  writeln;
  writeln;                   
  suma:= Sumar(v, dimL);
  writeln;
  writeln;
  writeln('La suma de los valores del vector es ', suma); 
  writeln;
  writeln;
  maximo:= ObtenerMaximo(v, dimL);
  writeln;
  writeln;
  writeln('El maximo del vector es ', maximo); 
  writeln;
  writeln;
  write ('Ingrese un valor a buscar: ');
  read (valor);
  encontre:= BuscarValor(v, dimL, valor);
  writeln;
  writeln;
  if (encontre) then
    writeln('El ', valor, ' esta en el vector')
  else
	writeln('El ', valor, ' no esta en el vector');
                
  writeln;
  writeln;
  ImprimirDigitos (v, dimL);
end.
