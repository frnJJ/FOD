program asd;
type
	alumno = record
		cod:integer;
		apellido:String;
		nombre:String;
		sinfinal:integer;
		confinal:integer;
	end;
	detalle = record
		cod:integer;
		fin:boolean;
	end;
	arc =file of alumno;
	arc2 = file of detalle;
procedure leer (var a:arc2;var aux:detalle);
begin
	if (not (eof(a))) then 
		read(a,aux)
	else
		aux.cod:=9999;
end;
procedure leer2 (var a:arc; var aux:alumno);
begin
	if (not (eof(a))) then
		read(a,aux)
	else
		aux.cod:=9999;
end;
procedure buscar (var a:arc; cod:integer;var aux:alumno);
begin
	leer2(a,aux);
	while((aux.cod <> 9999) and (aux.cod < cod)) do 
		leer2(a,aux);
	seek(a,(filepos(a))-1)
end;
procedure p1 (var a:arc; var b:arc2);
var
	aux,act:detalle;
	finales,cursadas:integer;
	aux2:alumno;
begin
	reset(a);
	reset(b);
	leer(b,aux);
	while (aux.cod <> 9999) do begin
		act:= aux;
		finales:=0;
		cursadas:=0;
		while((aux.cod <> 9999) and (act.cod = aux.cod)) do begin
			if (aux.fin = true) then
				finales:= finales+1
			else
				cursadas:= cursadas+1;
			leer(b,aux);
		end;
		buscar(a,act.cod,aux2);
		if (aux2.cod = act.cod) then begin
			aux2.confinal:= aux2.confinal + finales;
			aux2.sinfinal:= aux2.sinfinal + cursadas;
			write(a,aux2);
		end;
	end;
	close(a);
	close(b);
end;
procedure crear (var a:arc);
var
	aux:alumno;
begin
	rewrite(a);
	aux.nombre:= 'Juan Pablo';
	aux.apellido:= 'Perla';
	aux.cod:= 10;
	aux.sinfinal:= 0;
	aux.confinal:= 7;
	write(a,aux);
	close(a); 
end;
procedure crear2 (var a:arc2);
var 
	aux:detalle;
begin
	rewrite(a);
	aux.cod:=10;
	aux.fin:=false;
	write(a,aux);
	write(a,aux);
	close(a);
end;
procedure listar (var a:arc);
var
	txt:Text;
	aux:alumno;
begin
	assign(txt,'texto.txt');
	rewrite(txt);
	reset(a);
	while(not eof(a)) do begin
		read(a,aux);
		writeln(txt,aux.cod,' ',aux.confinal,' ',aux.sinfinal,' ',aux.nombre);	
	end;
	close(txt);
	close(a);	
end;
var
	a1:arc;
	a2:arc2;
	n:char;
begin
	assign(a1,'maestro');
	assign(a2,'detalle');
	crear(a1);
	crear2(a2);
	writeln('Seleccione una opcion = A--> Actualizar el archivo maestro  B--> Lista en .txt los alumnos con mas de 4 cursadas, C--> EXIT');
	readln(n);
	while (n <> 'C') do begin
		case n of 
			'A':p1(a1,a2);
			'B':listar(a1);
		end;
		writeln('Seleccione una opcion = A--> Actualizar el archivo maestro  B--> Lista en .txt los alumnos con mas de 4 cursadas,, C--> EXIT');
		readln(n);
	end;
end.
