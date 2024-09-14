{
   
}


program universidad;

uses crt;
const 
	fin=0;
type
	finalM=record
		legajo:integer;
		codMat:integer;
		fecha:integer;
		nota:1..10;
	end;
	
	listaF=^nodoF;
	nodoF=record
		dato:finalM;
		sig:listaF;
	end;
	
	alumno=record
		legajo:integer;
		finales:listaF;
	end;
	
	arbol=^nodo;
	nodo=record
		dato:alumno;
		HI:arbol;
		HD:arbol;
	end;
	aprobados=record
		legajo:integer;
		promedio:real;
	end;
	listaA=^nodoA;
	nodoA=record
		dato:aprobados;
		sig:listaA;
	end;
procedure CargarFinal(var f:finalM);
begin
	f.legajo:=random(50);
	if(f.legajo<>0)then
		begin
			f.codMat := random(20);
			f.fecha := 2000+random(12)+random(32);
			f.nota := random(11);
		end;
end;
procedure Insertar(var a:arbol;f:finalM);
	procedure AgregarAdelante(var l:listaF;elem:finalM);
	var
		nue:listaF;
	begin
		new(nue);
		nue^.dato:=elem;
		nue^.sig:=nil;
		if l=nil then
		   l:=nue
		else
			begin
				nue^.sig:=l;
				l:=nue;
			end;
	end;
begin
	if(a=nil)then
		begin
			new(a);
			a^.dato.legajo:=f.legajo;
			AgregarAdelante(a^.dato.finales,f);
			a^.HI:=nil;
			a^.HD:=nil;
		end
	else
		if(f.legajo < a^.dato.legajo)then
			Insertar(a^.HI,f)
		else
			if(f.legajo=a^.dato.legajo)then
				AgregarAdelante(a^.dato.finales,f)
			else
				Insertar(a^.HD,f);
end;
procedure CargarArbol(var a:arbol);
var
	f:finalM;
begin
	CargarFinal(f);
	while(f.legajo<>0)do
		begin
			Insertar(a,f);
			CargarFinal(f);
		end;
end;
function CantLegajoImpar(a:arbol):integer;
begin
	if(a<>nil)then
		begin	
			if((a^.dato.legajo mod 2) = 1)then
				CantLegajoImpar:=1+CantLegajoImpar(a^.HI)+CantLegajoImpar(a^.HD)
			else
				CantLegajoImpar:=0+CantLegajoImpar(a^.HI)+CantLegajoImpar(a^.HD);
		end
	else
		CantLegajoImpar:=0;
end;
procedure Informar(a:arbol);
	function Contar(l:listaF):integer;
	begin
		if(l<>nil)then
			if(l^.dato.nota>=4)then
				Contar:=1+Contar(l^.sig)
			else
				Contar:=0+Contar(l^.sig)
		else
			Contar:=0;
	end;
var
	cantMAprob:integer;
begin
	cantMAprob:=0;
	if(a<>nil)then
		begin
			Informar(a^.HI);
			Informar(a^.HD);
			cantMAprob:=Contar(a^.dato.finales);
			writeln('Cod Alumno = ',a^.dato.legajo,' Cant Finales Aprobados = ',cantMAprob);
		end;
end;
procedure Superior(a:arbol;prom:real;var apr:listaA);
	procedure AgregarAdelanteSup(var l:listaA;elem:aprobados);
	var
		nue:listaA;
	begin
		new(nue);
		nue^.dato:=elem;
		nue^.sig:=nil;
		if(l=nil)then
			l:=nue
		else
			begin
				nue^.sig:=l;
				l:=nue;
			end
	end;
	procedure recorrer(l:listaF;var notas,cant:integer);
	begin
		if(l<>nil)then
			begin
				recorrer(l^.sig,notas,cant);
				notas:=notas+l^.dato.nota;
				cant:=cant+1;
			end;
	end;
var
	notas:integer;
	cant:integer;
	promedio:real;
	auxApr:aprobados;
begin
	notas:=0;
	cant:=0;
	promedio:=0;
	
	if(a<>nil)then
		begin
			Superior(a^.HI,prom,apr);
			Superior(a^.HD,prom,apr);
			recorrer(a^.dato.finales,notas,cant);
			promedio:=notas/cant;
			if(promedio>=prom)then
				begin
					auxApr.legajo:=a^.dato.legajo;
					auxApr.promedio:=promedio;
					AgregarAdelanteSup(apr,auxApr);
				end;
		end;
end;
procedure InformarPromediosSup(l:listaA);
begin	
	if (l<>nil)then
		begin
			InformarPromediosSup(l^.sig);
			writeln('LEGAJO = ',l^.dato.legajo,' PROMEDIO = ',l^.dato.promedio:4:2);
		end;
end;
var
	a:arbol;
	cantLegajoImpares:integer;
	b:listaA;
	promSup:real;
BEGIN
	randomize;
	cantLegajoImpares:=0;
	writeln('Cargando Finales.....');
	writeln();
	CargarArbol(a);
	writeln('Carga Finalizada.');
	cantLegajoImpares:=CantLegajoImpar(a);
	writeln('Procesando...');
	writeln('La cantidad de alumnos con legajo impar es: ',cantLegajoImpares);
	Informar(a);
	b:=nil;
	writeln('Ingrese un promedio Real a superar: ');
	readln(promSup);
	Superior(a,promSup,b);
	InformarPromediosSup(b);
END.

