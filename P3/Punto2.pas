program asd;
type
	asistente = record
		nro: integer;
		apellido:String;
		nombre: String;
		email:String;
		telefono:integer;
		dni:integer;
	end;
	arc = file of asistente;
procedure crear (var a:arc);
var
	aux:asistente;
begin
	rewrite(a);
	writeln('ingrese el nro de asistente');
	readln(aux.nro);
	while (aux.nro <> 0) do begin
		writeln('ingrese el apellido');
		readln(aux.apellido);
		writeln('ingrese el nombre');
		readln(aux.nombre);
		writeln('ingrese el email');
		readln(aux.email);
		writeln('ingrese el telefono');
		readln(aux.telefono);
		writeln('ingrese el dni');
		readln(aux.dni);
		write(a,aux);
		writeln('----------------------');
		writeln('ingrese el nro de asistente');
		readln(aux.nro);
	end;
	close(a);
end;
procedure leer(var a:arc; var aux:asistente);
begin
	if (not eof(a)) then 
		read(a,aux)
	else
		aux.nro:= 9999;
end;
procedure imprimir (var a:arc);
var
	aux:asistente;
begin
	reset(a);
	while (not eof(a)) do begin
		read(a,aux);
		writeln('Nombre: ',aux.nombre);
	end;
	close(a);
end;
procedure lod_del (var a:arc);
var
	aux:asistente;
begin
	reset(a);
	leer(a,aux);
	while (aux.nro <> 9999) do begin
		if (aux.nro < 1000) then begin
			aux.nombre:= '***';
			seek(a,filepos(a)-1);
			write(a,aux);
		end;
		leer(a,aux);
	end;
	close(a);
end;
var
	a:arc;
begin
	assign(a,'prueba');
	crear(a);
	lod_del(a);
	imprimir(a);
end.
