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
procedure leer (var c:celular);
begin
	writeln('ingrese el nombre de celular');
	readln(c.nombre);
	if (c.nombre <> ' ') then begin
		writeln('ingrese el codigo del celular');
		readln(c.cod);
		writeln('ingrse la descripcion del celular');
		readln(c.desc);
		writeln('ingrese la marca del celular');
		readln(c.marca);
		writeln('ingrese el precio del celular');
		readln(c.precio);
		writeln('ingrese el stock minimo del celular');
		readln(c.smin);
		writeln('ingrese el stock disponible');
		readln(c.stockdisp);
	end;
end;
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
		writeln('NOMBRE: ',aux.nombre,' MARCA : ',aux.marca,' PRECIO : $',aux.precio,' Descripcion : ',aux.desc,' Stock Disponible = ',aux.stockdisp);
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
			writeln('NOMBRE: ',aux.nombre,' MARCA : ',aux.marca,' PRECIO : $',aux.precio,' Descripcion : ',aux.desc,' Stock dissponible = ',aux.stockdisp);
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
			writeln('NOMBRE: ',aux.nombre,' MARCA : ',aux.marca,' PRECIO : $',aux.precio,' Descripcion : ',aux.desc,' Stock disponible = ',aux.stockdisp);
	end;
	close(a);
end;
procedure inF (var a:arc);
var
	txt:Text;
	aux:celular;
begin
	reset(a);
	assign(txt,'celulares.txt');
	rewrite(txt);
	while (not (eof(a))) do begin
		read(a,aux);
		writeln(txt,aux.cod,' ',aux.precio,' ',aux.marca);
		writeln(txt,aux.stockdisp,' ',aux.smin,' ',aux.desc);
		writeln(txt,aux.nombre);
	end;
	close(a);
	close(txt);
end;
procedure inG (var a: arc);
var
	c:celular;
begin
	reset(a);
	leer(c);
	while (c.nombre <> ' ') do begin
		seek(a,filesize(a));
		write(a,c);
		leer(c);
	end;
	close(a);
end;
procedure inH (var a:arc);
var
	nom:String;
	aux:celular;
	ns:integer;
begin
	writeln('ingrese el nombre del celular');
	readln(nom);
	reset(a);
	read(a,aux);
	while ((not eof(a)) and (nom <> aux.nombre))  do 
		read(a,aux);
	if (nom = aux.nombre) then begin
		writeln('ingrese la cantidad de celulares ingresados del celular ',nom);
		readln(ns);
		aux.stockdisp:= aux.stockdisp + ns;
		seek(a,filepos(a)-1);
		write(a,aux)
	end
	else 
		writeln('el celular "',nom,'" no se encuentra, agreguelo primero');
	close(a);
end; 
procedure inI (var a:arc);
var
	aux:celular;
	txt:Text;
begin
	reset(a);
	assign(txt,'SinStock.txt');
	rewrite(txt);
	while (not eof(a)) do begin
		read(a,aux);
		if (aux.stockdisp = 0) then begin
			writeln(txt,aux.cod,' ',aux.precio,' ',aux.marca);
			writeln(txt,aux.stockdisp,' ',aux.smin,' ',aux.desc);
			writeln(txt,aux.nombre);
		end;
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
	writeln(' A--> Crear archivo .bin B--> Mostrar archivo C--> Listar aquellos que tengan Stock menor al Stock minimo D--> Busca por descripcion F--> Exportar a txt G--> Añadir mas celulares H--> Modificar Stock de un celular I--> Exp celulares sin stock E--> Salir');
	readln(n);
	while (n <> 'E') do begin
		case (n) of
			'A': inA(a,cel);
			'B': inB(a);
			'C': inC(a);
			'D': inD(a);
			'F': inF(a);
			'G': inG(a);
			'H': inH(a);
			'I': inI(a);
			'E': writeln('closing...');
		end;
		writeln('OPCIONES: ');
		writeln(' A--> Crear archivo .bin B--> Mostrar archivo C--> Listar aquellos que tengan Stock menor al Stock minimo D--> Busca por descripcion F--> Exportar a txt G--> Añadir mas celulares H--> Modificar Stock de un celular I--> Exp celulares sin stock E--> Salir');
		readln(n);
	end;
end.
