program asd;
type
	aves = record
		cod:integer;
		nombre:String;
		familia:String;
		desc:String;
		zona:String;
	end;
	arc = file of aves;
procedure leer (var a:arc; var aux:aves);
begin
	if (not eof(a)) then
		read(a,aux)
	else
		aux.cod:=9999;
end;
procedure marcar (var a:arc);
var
	aux:aves;
	co:integer;
begin
	reset(a);
	writeln('ingrese el cod de ave a borrar');
	readln(co);
	while (co <> 5000) do begin
		leer(a,aux);
		while (aux.cod <> 9999) do begin
			if (aux.cod = co) then begin
				aux.nombre:= '***';
				seek(a,filepos(a)-1);
				write(a,aux);
			end;		
			leer(a,aux);
		end;
		close(a);
		writeln('ingrese el cod de ave a borrar');
		readln(co);
		reset(a);
	end;
	close(a);
end;
procedure crear (var a:arc);
var
	aux:aves;
begin
	rewrite(a);
	writeln('Codigo');
	readln(aux.cod);
	while (aux.cod <> 0) do begin
		writeln('Nombre');
		readln(aux.nombre);
		aux.familia:= 'a';
		aux.desc:= 'a';
		aux.zona:= 'bsas';
		write(a,aux);
		writeln('--------------------------');
		writeln('Codigo');
		readln(aux.cod);
	end;
	close(a);
end;
procedure compactar (var a:arc);
var
	aux:aves;
	pos:integer;
begin
	reset(a);
	leer(a,aux);
	while (aux.cod <> 9999) do begin
		if (aux.nombre = '***') then begin
			pos:=(filepos(a)-1);
			seek(a,filesize(a)-1);
			leer(a,aux);
			seek(a,pos);
			write(a,aux);
			seek(a,filesize(a)-1);
			Truncate(a);
			seek(a,pos);
		end;
		leer(a,aux);
	end;
	close(a);
end;
procedure imp (var a:arc);
var
	aux:aves;
begin
	reset(a);
	leer(a,aux);
	while (aux.cod <> 9999) do begin
		writeln('Codigo = ',aux.cod);
		leer(a,aux);
	end;
	close(a);
end;
procedure eliminar (var a:arc);
begin
	marcar(a);
	compactar(a);
end;
var
	a:arc;
begin
	assign(a,'ArchivoLocura');
	crear(a);
	eliminar(a);
	imp(a);
end.
