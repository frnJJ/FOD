program asd;
type
	empleado = record
		nombre:String;
		cod:integer;
		monto:real;
	end;
	arc = file of empleado;
procedure leerempleado (var a:empleado);
begin
	writeln('ingrese codigo de empleado');
	readln(a.cod);
	writeln('bbb');
	if (a.cod <> 0) then begin
		writeln('ingrese el nombre del empleado');
		readln(a.nombre);
		writeln('ingrese el monto que posee el empleado de comisiones');
		readln(a.monto);
	end;
end;

		
procedure cargar (var a:arc);
var
	nodo:empleado;
begin
	leerempleado(nodo);
	rewrite(a);
	while(nodo.cod <> 0) do begin
		write(a,nodo);
		leerempleado(nodo);
	end;
	close(a);
end;
procedure leer (var a:arc; var aux:empleado);
begin
	if (not (eof(a))) then
		read(a,aux)
	else
		aux.cod:=9999;
end;
		
procedure compactar (var a:arc; var a1:arc);
var
	aux:empleado;
	contador:real;
	act:empleado;
begin
	reset(a);
	rewrite(a1);
	leer(a,aux);
	while (aux.cod <> 9999) do begin
		contador:=0;
		act:= aux;
		while((aux.cod <> 9999) and (aux.cod = act.cod)) do begin
			contador:= contador + aux.monto;
			leer(a,aux);
		end;
		act.monto:= contador;
		write(a1,act);
	end;
	close(a);
	close(a1);
end;
procedure imprimir (var a:arc);
var
	aux:empleado;
begin
	reset(a);
	while (not (eof(a))) do begin
		read(a,aux);
		writeln(' codigo = ',aux.cod,' nombre = ',aux.nombre,' monto = ',aux.monto);
	end;
	close(a);
end;
var
	a:arc;
	a1:arc;
begin
	assign(a,'archivo');
	assign(a1,'compact');
	//cargar(a);
	compactar(a,a1);
	imprimir(a1);
end.
		
	
