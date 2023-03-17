program asd;
type
	celular = record
		cod: integer;
		nombre: String;
		desc: String;
		marca: String;
		precio: real;
		smin: integer;
		stockdisp: integer;
	end;
	arc = file of celular;
procedure inA (var a:arc ; var c: Text);
var
	nombre:String;
	aux:celular;
begin
	writeln('ingrese un nombre para su archivo');
	readln(nombre);
	assign(a,nombre);
	rewrite(a);
	reset(c);
	while (not (eof(c)))do begin
		readln(c,aux.cod,aux.precio,aux.marca);
		readln(c,aux.stockdisp,aux.smin,aux.desc);
		readln(c,aux.nombre);
		write(a,aux);
	end;
	writeln(aux.marca);
	close(c);
	close(a);
end;
procedure inB (var a: arc);
var
	aux:celular;
begin
	reset(a);
	while (not (eof(a))) do begin
		read(a,aux);
		writeln('NOMBRE: ',aux.nombre,' MARCA : ',aux.marca,' PRECIO : $',aux.precio,' Descripcion : ',aux.desc);
	end;
	close(a);
end;
procedure inC (var a:arc);
var
	aux:celular;
begin
	reset(a);
	while (not(eof(a))) do begin
		read(a,aux);
		if (aux.stockdisp < aux.smin) then
			writeln('NOMBRE: ',aux.nombre,' MARCA : ',aux.marca,' PRECIO : $',aux.precio,' Descripcion : ',aux.desc);
	end;
	close(a);
end;
procedure inD (var a:arc);
var
	aux:celular;
	des:String;
begin
	writeln('ingrese la descripcion que busca');
	readln(des);
	reset(a);
	des:= concat(' ',des);
	while (not(eof(a))) do begin
		read(a,aux);
		if (aux.desc = des) then 
			writeln('NOMBRE: ',aux.nombre,' MARCA : ',aux.marca,' PRECIO : $',aux.precio,' Descripcion : ',aux.desc);
	end;
	close(a);
end;
procedure inF (var a:arc);
var
	txt:Text;
	aux:celular;
begin
	reset(a);
	assign(txt,'Celulares2.txt');
	rewrite(txt);
	while (not (eof(a))) do begin
		read(a,aux);
		writeln(txt,aux.cod,aux.precio,aux.marca);
		writeln(txt,aux.stockdisp,' ',aux.smin,aux.desc);
		writeln(txt,aux.nombre);
	end;
	close(a);
	close(txt);
end;
var
	cel: Text;
	a: arc;
	n: char;
begin
	assign(cel,'celulares.txt');
	writeln('OPCIONES: ');
	writeln(' A--> Crear archivo .bin B--> Mostrar archivo C--> Listar aquellos que tengan Stock menor al Stock minimo D--> Busca por descripcion F--> Exportar a txt E--> Salir');
	readln(n);
	while (n <> 'E') do begin
		case (n) of
			'A': inA(a,cel);
			'B': inB(a);
			'C': inC(a);
			'D': inD(a);
			'F': inF(a);
			'E': writeln('closing...');
		end;
		writeln('OPCIONES: ');
		writeln(' A--> Crear archivo .bin B--> Mostrar archivo C--> Listar aquellos que tengan Stock menor al Stock minimo D--> Busca por descripcion F--> Exportar a txt E--> Salir');
		readln(n);
	end;
end.
