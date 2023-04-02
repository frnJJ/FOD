program asd;
type
	producto= record
		cod:integer;
		nom:String;
		desc:String;
		stkdis:integer;
		stkmin:integer;
		precio:real;
	end;
	arc = file of producto;
	detalle = record
		cod:integer;
		cant:integer;
	end;
	arc2 = file of detalle;
procedure leer (var a:arc2; var aux:detalle);
begin
	if (not eof(a)) then
		read(a,aux)
	else
		aux.cod:=9999;
end;
procedure crear (var a:arc2);
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
procedure creardos (var a:arc);
var
	aux:producto;
begin
	rewrite(a);
	writeln('ingrese el cod de producto');
	readln(aux.cod);
	while (aux.cod <> 0) do begin
		writeln('ingrese el nombre del producto');
		readln(aux.nom);
		writeln('ingrese el precio del producto');
		readln(aux.precio);
		writeln('ingrese el stock disponible');
		readln(aux.stkdis);
		writeln('ingrese el stock minimo');
		readln(aux.stkmin);
		writeln('ingrese la descripcion del producto');
		readln(aux.desc);
		write(a,aux);
		writeln('------------------------------');
		writeln('ingrese el cod de producto');
		readln(aux.cod);
	end;
	close(a);
end;
procedure calcularmin (var a2:arc2; var a3:arc2; var a4:arc2;var uno,dos,tres: detalle;var aux:detalle);

begin
	if((uno.cod <= dos.cod) and (uno.cod <= tres.cod)) then begin
		aux:=uno;
		leer(a2,uno)
	end
	else 
		if ((dos.cod <= uno.cod) and (dos.cod <= tres.cod)) then begin
			aux:=dos;
			leer(a3,dos)
		end
		else begin
			aux:=tres;
			leer(a4,tres);
		end;
end;
procedure actualizar (var a1:arc; var a2:arc2; var a3:arc2; var a4:arc2);
var
	aux,act:detalle;
	uno,dos,tres:detalle;
	cant:integer;
	aux2:producto;
begin
	reset(a1);
	reset(a2);
	reset(a3);
	reset(a4);
	leer(a2,uno);
	leer(a3,dos);
	leer(a4,tres);
	calcularmin(a2,a3,a4,uno,dos,tres,aux);
	while (aux.cod <> 9999) do begin
		act:= aux;
		cant:= 0;
		while (act.cod = aux.cod) do begin
			cant:= cant + aux.cant;
			calcularmin(a2,a3,a4,uno,dos,tres,aux);
		end;
		if (not eof(a1)) then begin
			read(a1,aux2);
			while (aux2.cod < act.cod) do
				read(a1,aux2);
			seek(a1,filepos(a1)-1);
		end;
		if (aux2.cod = act.cod) then begin
			aux2.stkdis := aux2.stkdis - cant;
			write(a1,aux2);
		end;
	end;
	close(a1);
	close(a2);
	close(a3);
	close(a4);
end;
procedure imp (var a:arc; var txt: Text);
var
	aux:producto;
begin
	reset(a);
	assign(txt,'FALTANTE.txt');
	rewrite(txt);
	while (not eof(a)) do begin
		read(a,aux);
		writeln('NOMBRE = ',aux.nom,' STK DIS= ',aux.stkdis,' STK MIN= ',aux.stkmin);
		if (aux.stkdis < aux.stkmin) then
			writeln('aa');
			writeln(txt,aux.cod,' ',aux.nom);
	end;
	close(a);
	close(txt);
end;
	
var
	a1:arc;
	a2,a3,a4:arc2;
	txt:Text;
begin
	assign(a1,'maestrop3');
	assign(a2,'detalle1');
	assign(a3,'detalle2');
	assign(a4,'detalle3');
	crear(a2);
	crear(a3);
	crear(a4);
	creardos(a1);
	actualizar(a1,a2,a3,a4);
	imp(a1,txt);
end.

