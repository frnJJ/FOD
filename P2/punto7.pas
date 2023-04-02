program asd;
type
	maestro = record
		cod:integer;
		nom:String;
		precio:real;
		stkdis:integer;
		stkmin:integer;
	end;
	detalle = record
		cod:integer;
		cant:integer;
	end;
	arc = file of maestro;
	arc2 = file of detalle;
procedure crear (var a:arc);
var
	aux:maestro;
begin
	rewrite(a);
	writeln('ingrese el nombre del producto');
	readln(aux.nom);
	while (aux.nom <> 'zzz') do begin
		writeln('ingrese el codigo de producto');
		readln(aux.cod);
		writeln('ingrese el precio del producto');
		readln(aux.precio);
		writeln('ingrese el stock minimo del producto');
		readln(aux.stkmin);
		writeln('ingrese el stock disponible del producto');
		readln(aux.stkdis);
		write(a,aux);
		writeln('-----------------------------');
		writeln('ingrese el nombre del producto');
		readln(aux.nom);
	end;
	close(a);
end;
procedure crear2 (var a:arc2);
var
	aux:detalle;
begin
	rewrite(a);
	writeln('ingrese el cod de producto');
	readln(aux.cod);
	while (aux.cod <> 0) do begin
		writeln('ingrese la cantidad vendida');
		readln(aux.cant);
		write(a,aux);
		writeln('--------------------');
		writeln('ingrese el cod de producto');
		readln(aux.cod);
	end;
	close(a);
end;	
	
procedure leer (var a:arc2;var aux:detalle);
begin
	if (not (eof(a))) then 
		read(a,aux)
	else
		aux.cod:=9999;
end;
procedure ac (var a:arc; var a2:arc2);
var
	aux,act:detalle;
	cant:integer;
	aux2:maestro;
begin
	reset(a);
	reset(a2);
	leer(a2,aux);
	while (aux.cod <> 9999) do begin
		act:=aux;
		cant:=0;
		while (act.cod = aux.cod) do begin
			cant:= cant + aux.cant;
			leer(a2,aux);
		end;
		read(a,aux2);
		while (aux2.cod < act.cod)do 
			read(a,aux2);
		seek(a,filepos(a)-1);
		aux2.stkdis:= aux2.stkdis - cant;
		writeln(aux2.stkmin);
		write(a,aux2);
	end;
	close(a);
	close(a2);
end;
procedure imp (var a:arc);
var
	txt:Text;
	aux:maestro;
begin
	reset(a);
	assign(txt,'Bajo stock.txt');
	rewrite(txt);
	while (not eof(a)) do begin
		read(a,aux);
		if (aux.stkdis < aux.stkmin) then begin
			writeln(txt,aux.stkdis,' ',aux.nom);
		end;
	end;
	close(a);
	close(txt);
end;
var
	a:arc;
	a2:arc2;
	n:char;
begin
	assign(a,'inventario');
	assign(a2,'detalle inv');
	crear(a);
	crear2(a2);
	writeln('ingrese la opcion 	A--> Actualizar archivo maestro B--> Generar txt con P de stock bajo C--> Exit');
	readln(n);
	while (n <> 'C') do begin	
		case n of
			'A':ac(a,a2);
			'B':imp(a);
		end;
		writeln('ingrese la opcion 	A--> Actualizar archivo maestro B--> Generar txt con P de stock bajo C--> Exit');
		readln(n);
	end;
end.
