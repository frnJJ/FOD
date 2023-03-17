program gigo;
type
	archivo = file of integer;
var
	ar:archivo;
	n:integer;
	nombre:String;
begin
	writeln('INGRESE EL NOMBRE DEL ARCHIVO');
	read(nombre);
	assign(ar,nombre);
	rewrite(ar);
	writeln('INGRESAR UN NUMERO');
	readln(n);
	while (n <> 30000) do begin
		write(ar,n);
		writeln('INGRESAR OTRO NUMERO');
		readln(n);
	end;
	close(ar);
end.
