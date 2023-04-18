program asd;
type
	reg_flor = record
		nombre:String;
		cod:integer;
	end;
	arc = file of reg_flor;

procedure agregarFlor (var a:arc; nombre:String; cod:integer);
var
	aux:reg_flor;
	pos:integer;
begin
	reset(a);
	read(a,aux);
	if (aux.cod < 0) then begin
		pos:= -(aux.cod);
		seek(a,pos);
		read(a,aux);
		pos:= -(aux.cod);
		seek(a,filepos(a)-1);
		aux.nombre:=nombre;
		aux.cod:=cod;
		write(a,aux);
		seek(a,0);
		aux.cod:=pos;
		write(a,aux)
	end
	else begin
		seek(a,filesize(a));
		aux.cod:=cod;
		aux.nombre:=nombre;
		write(a,aux);
	end;
end;
procedure crear (var a:arc);
var
	aux:reg_flor;
begin
	rewrite(a);
	aux.cod:=0;
	write(a,aux);
	writeln('ingrese el nombre de la flor');
	readln(aux.nombre);
	while (aux.nombre <> 'fin') do begin
		writeln('ingrese el codigo');
		readln(aux.cod);
		write(a,aux);
		writeln('--------------------------');
		writeln('ingrese el nombre de la flor');;
		readln(aux.nombre);
	end;
	close(a);
end;
procedure  listar (var  a:arc);
var
	aux: reg_flor;
	txt: Text;
begin
	assign(txt,'Bajas.txt');
	rewrite(txt);
	reset(a);
	while (not eof(a)) do begin
		read(a,aux);
		if (aux.nombre <> '***') then 
			writeln(txt,aux.cod,' ',aux.nombre);
	end;
	close(a);
	close(txt);
end;
procedure imp (var a:arc);
var
	aux:reg_flor;
begin
	reset(a);
	while (not eof(a)) do begin
		read(a,aux);
		writeln(aux.cod);
	end;
	close(a);
end; 
procedure eliminarFlor (var a:arc; flor:reg_flor);
var
	aux,pos:reg_flor;
begin
	reset(a);
	read(a,pos);
	read(a,aux);
	while (aux.nombre <> flor.nombre) do 
		read(a,aux);
	seek(a,filepos(a)-1);
	aux.nombre:= '***';
	aux.cod:=-(pos.cod);
	pos.cod:=-(filepos(a));
	write(a,aux);
	seek(a,0);
	write(a,pos);
	close(a);
end;
var
	a:arc;
	c:char;
	nom:String;
	cod:integer;
	aux:reg_flor;
begin
	assign(a,'Nuevodoc');
	crear(a);
	writeln('ingrese la opcion A--> Eliminar flor B--> AgregarFlor C--> Listar D--> Exit');
	readln(c);
	while (c <> 'D') do begin
		case c of
			'A':begin writeln('ingrese el nombre de la flor que quiere eliminar');
				readln(aux.nombre);
				writeln('ingrese el cod de la flor que quiere agregar');
				readln(aux.cod);
				eliminarFlor(a,aux);
				end;
			'B':begin writeln('ingrese el nombre de la flor que quiere agregar');
				readln(nom);
				writeln('ingrese el cod de la flor que quiere agregar');
				readln(cod);
				agregarFlor(a,nom,cod);
				end;
			'C':listar(a);
		end;
		writeln('ingrese la opcion A--> Eliminar flor B--> AgregarFlor C--> Listar D--> Exit');
		readln(c);
	end;
end. 
