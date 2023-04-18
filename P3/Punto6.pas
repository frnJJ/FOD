program asd;
type
	prendas = record
		cod:integer;
		desc:String;
		color:String;
		t_prenda:String;
		stock:integer;
		precio:real;
	end;
	arc = file of prendas;
	arc2 = file of integer;
procedure crear (var a:arc);
var
	aux:prendas;
begin
	rewrite(a);
	writeln('ingrese el codigo de prenda');
	readln(aux.cod);
	while (aux.cod <> 0) do begin
		writeln('ingrese la decs de la prenda');
		readln(aux.desc);
		writeln('ingrese el precio de la prenda');
		readln(aux.precio);
		write(a,aux);
		writeln('--------------------------------');
		writeln('ingrese el codigo de prenda');
		readln(aux.cod);	
	end;
	close(a);
end;
procedure crear2 (var a:arc2);
var
	cod:integer;
begin
	rewrite(a);
	cod:= 0;
	write(a,cod);
	writeln('ingrese el cod a borrar');
	readln(cod);
	while (cod <> 0) do begin
		write(a,cod);
		writeln('---------------------------');
		writeln('ingrese el cod a borrar');
		readln(cod);
	end;
	close(a);
end;
	
procedure leer (var a:arc; var aux:prendas);
begin
	if (not eof(a)) then 
		read(a,aux)
	else
		aux.cod:=9999;
end;
procedure leer2 (var a:arc2; var c:integer);
begin
	if (not eof(a)) then
		read(a,c)
	else
		c:=9999;
end;
procedure actualizar (var a:arc; var b:arc2);
var
	c:integer;
	aux:prendas;
begin
	reset(b);
	leer2(b,c);
	while (c <> 9999) do begin
		reset(a);
		leer(a,aux);
		while (aux.cod <> 9999) and (aux.cod <> c) do 
			leer(a,aux);
		if (aux.cod <> 9999) then begin
			seek(a,filepos(a)-1);
			aux.desc:='***';
			write(a,aux);
		end;
		close(a);
		leer2(b,c);
	end;
	close(b);
end;
procedure imp (var a:arc);
var
	aux:prendas;
begin
	reset(a);
	leer(a,aux);
	while (aux.cod <> 9999) do begin
		writeln(aux.desc);
		leer(a,aux);
	end;
	close(a);
end;
var
	a:arc;
	b:arc2;
begin
	assign(a,'MaestroPrendas');
	assign(b,'FueraDeTemporada');
	crear(a);
	crear2(b);
	actualizar(a,b);
	imp(a);
end.
	
