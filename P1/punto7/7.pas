program asd;
type
	novela = record
		cod:integer;
		nombre:String;
		genero:String;
		precio:real;
	end;
	arc = file of novela;
procedure crear (var a:arc; var txt: Text);
var
	aux: novela;
begin
	reset(txt);
	rewrite(a);
	while (not(eof(txt))) do begin
		readln(txt,aux.cod,aux.precio,aux.genero);
		readln(txt,aux.nombre);
		write(a,aux);
	end;
	close(a);
	close(txt);
end;
procedure leernovela (var n: novela);
begin
	writeln('ingrese codigo de novela');
	readln(n.cod);
	writeln('ingrese el nombre de la novela');
	readln(n.nombre);
	writeln('ingrese el genero de la novela');
	readln(n.genero);
	writeln('ingrese el precio de la novela');
	readln(n.precio);
end;
procedure agregar (var a:arc);
var
	aux: novela;
	nue: novela;
begin
	leernovela(nue);
	reset(a);
	if (not eof(a)) then
		read(a,aux);
	while (not (eof(a)) and (aux.cod <> nue.cod)) do 
		read(a,aux);
	if (aux.cod = nue.cod) then begin
		aux := nue;
		seek(a,filepos(a)-1);
		write(a,aux)
	end
	else 
		write(a,nue);
	close(a);
end;
procedure ver (var a: arc);
var
	aux: novela;
begin
	reset(a);
	while (not eof(a)) do begin
		read(a,aux);
		writeln('NOMBRE DE LA NOVELA = ',aux.nombre);
	end;
	close(a);
end;
	
var
	txt: Text;
	a: arc;
	name: string;
	n: char;
begin
	writeln('ingrese el nombre del archivo .bin');
	readln(name);
	assign(a,name);
	assign(txt,'novelas.txt');
	crear(a,txt);
	writeln(' A --> Agregar novela o modicar en caso de existir B--> IMPRIMIR EL .BIT C--> EXIT');
	readln(n);
	while (n <> 'C') do begin
		case (n) of
			'A': agregar(a);
			'B': ver(a);
			'C': continue;
		end;
		writeln(' A --> Agregar novela o modicar en caso de existir B--> IMPRIMIR EL .BIT C--> EXIT');
		readln(n);
	end;
	writeln('closing...');
end.
		
	
	
