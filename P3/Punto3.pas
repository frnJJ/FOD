program asd;
type
	novela = record
		cod:integer;
		genero:String;
		nombre:String;
		duracion:real;
		director:String;
		precio:real;
	end;
	arc = file of novela;
procedure readd (var aux:novela);
begin
	writeln('ingrese el cod de novela');
	readln(aux.cod);
	if (aux.cod <> 0) then begin
		writeln('ingrese el genero');
		readln(aux.genero);
		writeln('ingrese el nombre');
		readln(aux.nombre);
		writeln('ingrese la duracion');
		readln(aux.duracion);
		writeln('ingrese el director');
		readln(aux.director);
		writeln('ingrese el precio');
		readln(aux.precio);
	end;
end;
procedure crear (var a:arc);
var
	aux:novela;
begin
	rewrite(a);
	aux.cod:= 0;
	write(a,aux);
	readd(aux);
	while(aux.cod <> 0) do begin
		write(a,aux);
		readd(aux);
	end;
	close(a);
end;
procedure dar_alta(var a:arc);
var
	aux:novela;
	cab,nueva_cab:novela;
begin
	readd(aux);
	reset(a);
	read(a,cab);
	if (cab.cod < 0) then begin
		seek(a,-(cab.cod));
		read(a,nueva_cab);
		nueva_cab.cod := -(nueva_cab.cod);
		seek(a,filepos(a)-1);
		write(a,aux);
		seek(a,0);
		write(a,nueva_cab);
	end
	else begin
		seek(a,filesize(a));
		write(a,aux);
	end;
	close(a);
end;
procedure listar_txt (var a:arc);
var
	txt: Text;
	aux:novela;
begin
	assign(txt,'Novelas.txt');
	rewrite(txt);
	reset(a);
	while (not eof(a)) do begin
		read(a,aux);
		writeln(txt,aux.cod,' ',aux.nombre);
	end;
	close(a);
	close(txt);
end;
procedure eli_cod (var a:arc);
var
	codigo:integer;
	aux,cab:novela;
begin
	reset(a);
	read(a,aux);
	cab:= aux;
	writeln('ingrese el codigo que quiere eliminar');
	readln(codigo);
	while (not eof(a)) do begin
		read(a,aux);
		if (aux.cod = codigo) then begin
			aux.cod:= cab.cod;
			aux.nombre:= '***';
			seek(a,filepos(a)-1);
			write(a,aux);
			aux.cod:= -(filepos(a)-1);
			seek(a,0);
			write(a,aux);	
		end;
	end;
	close(a);
end;
var
	a:arc;
	car:char;
begin
	assign(a,'novelas');
	writeln('ingrese la opcion = A-> Crear B-> Dar_de_Alta C-> Modificar Novela D-> Eliminar por codigo de novela E-> Listar en .txt');
	readln(car);
	while (car <> 'F') do begin
		case car of
			'A': crear(a);
			'B': dar_alta(a);
			//'C': mod_nov(a);
			'D': eli_cod(a);
			'E': listar_txt(a);
		end;
		writeln('ingrese la opcion = A-> Crear B-> Dar_de_Alta C-> Modificar Novela D-> Eliminar por codigo de novela E-> Listar en .txt');
		readln(car);
	end;
end.
