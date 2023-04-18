program asd;
type
	dist = record
		nombre:String;
		ano:Integer;
		versiones:integer;
		cant_dev:integer;
		desc:String;
	end;
	arc = file of dist;
procedure leer (var a:arc; var aux:dist);
begin
	if (not eof(a)) then
		read(a,aux)
	else
		aux.ano:=9999;
end;
procedure esc (var aux:dist);
begin
	writeln('ingrese el nombre de la dist');
	readln(aux.nombre);
	if (aux.nombre <> 'fin') then begin
		writeln('ingrese el año de la dist');
		readln(aux.ano);
		aux.versiones:=9;
		aux.cant_dev:=42;
		aux.desc:='asd';
	end;
end;
procedure crear (var a:arc);
var
	aux:dist;
begin
	rewrite(a);
	aux.ano:= 0;
	write(a,aux);
	esc(aux);
	while (aux.nombre <> 'fin') do begin
		write(a,aux);
		esc(aux);
	end;
	close(a);
end;
Procedure ExisteDist (var a:arc; nombre:String;var bool:boolean);
var
	aux:dist;
begin
	reset(a);
	leer(a,aux);
	bool:=False;
	while(aux.ano <> 9999) do begin
		if (aux.nombre = nombre) then
			bool:=True;
		leer(a,aux);
	end;
	close(a);
end;

procedure AltaDist (var a:arc);
var
	aux,aux2:dist;
	bool:boolean;
begin
	esc(aux);
	ExisteDist(a,aux.nombre,bool);
	reset(a);
	leer(a,aux2);
	if (not(bool))then begin
		if (aux2.ano < 0) then begin
			seek(a,-(aux2.ano));
			write(a,aux);
			aux2.ano:= -(filepos(a)-1);
			seek(a,0);
			write(a,aux2)
		end
		else begin
			seek(a,filesize(a));
			write(a,aux)
		end
	end
	else
		writeln('Ya existe esa disctribucion');
	close(a);
end;
procedure borrar (var a:arc);
var
	aux,aux2,pos:dist;
	bool:boolean;
begin
	esc(aux);
	ExisteDist(a,aux.nombre,bool);
	reset(a);
	if (bool) then begin
		leer(a,aux2);
		while (aux.nombre <> aux2.nombre) do 
			leer(a,aux2);
		pos.ano:= -(filepos(a)-1);
		seek(a,0);
		read(a,aux);
		seek(a,filepos(a)-1);
		write(a,pos);
		seek(a,-(pos.ano));
		aux.cant_dev:=-1;
		write(a,aux)
	end
	else
		writeln('no existe esa dist');
end;
procedure imp (var a:arc);
var
	aux:dist;
begin
	reset(a);
	leer(a,aux);
	while (aux.ano <> 9999) do begin
		writeln('nombre = ',aux.nombre);
		leer(a,aux);
	end;
	close(a);
end;
var
	a:arc;
begin
	assign(a,'ArcDisst');
	crear(a);
	AltaDist(a);
	borrar(a);
	imp(a);
end.
