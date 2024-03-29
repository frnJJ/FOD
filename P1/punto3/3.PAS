program asd;
type
	emp = record 
		num:integer;
		apellido:String;
		nombre:String;
		edad:integer;
		dni:integer;
	end;	
	arc = file of emp;
procedure cargar (var ar:arc);
var
	e:emp;
begin
    rewrite(ar);
	writeln('-----------------------NUEVO EMPLEADO----------------------------');
	write('APELLIDO = ');
	readln(e.apellido);
	while (e.apellido <> 'fin') do begin
		write('NOMBRE = ');
		readln(e.nombre);
		write('NUMERO DE EMPLEADO = ');
		readln(e.num);
		write('DNI =');
		readln(e.dni);
		write('EDAD = ');
		readln(e.edad);
		write(ar,e);
		writeln('-----------------------NUEVO EMPLEADO----------------------------');
		write('APELLIDO = ');
		readln(e.apellido);
	end;
	close(ar);
end;
procedure esp (nom:String;var ar:arc);
var
	empleado:emp;
	bo:boolean;
begin
	reset(ar);
	while (not eof(ar)) do begin
		read(ar,empleado);
		if ((empleado.nombre = nom) or (empleado.apellido = nom)) then begin
			writeln('---> NOMBRE = ',empleado.nombre,'---> APELLIDO = ', empleado.apellido);
			bo:=true;
		end;
	end;
	if (bo = false) then
		writeln('NO SE ENCONTRO EL EMPLEADO BUSCADO');
	close(ar);
end;
procedure leer (e:emp);
begin
	writeln('---> NOMBRE = ',e.nombre,'/ APELLIDO = ',e.apellido,'/ NUMERO DE EMPLEADO = ',e.num,'/ EDAD = ',e.edad,'/ DNI = ',e.dni);
end;
procedure listar (var ar:arc);
var
	e:emp;
begin
	reset(ar);
	while (not eof(ar)) do begin
		read(ar,e);
		leer(e);
	end;
	close(ar);
end;
procedure jubilar (var ar:arc);
var
	e:emp;
	cont:integer;
begin
	cont:=0;
	writeln('INFORMACION DE EMPLEADOS EN CONDICION DE JUBILARSE ');
	writeln('-----------------------------------------------------');
	reset(ar);
	while (not eof(ar)) do begin
		read(ar,e);
		if (e.edad >= 70) then begin
			leer(e);
			cont:= cont + 1;
		end;
	end;
	writeln('>>>>> LA CANTIDAD DE EMPLEADOS EN CONDICION DE JUBILARSE SON = ',cont,' <<<<<');
	close(ar);
end;
procedure A (mos: String; var e:arc);
begin
	writeln('INSERTE UN NOMBRE PARA SU ARCHIVO');
	readln(mos);
	assign(e,mos);
	cargar(e);
end;
procedure B (mos:String; var e:arc);
begin
	writeln('INGRESE EL NOMBRE O APELLIDO A BUSCAR');
	readln(mos);
	esp(mos,e);	
end;
var
	e:arc;
	mos:String;
	n:char;
begin
	n:='Z';
	while (n <> 'E') do begin
		writeln('OPCIONES = ');
		writeln('A --> CREAR ARCHIVO B--> LISTAR UN EMPLEADO POR NOMBRE O APELLIDO C--> LISTAR TODOS LOS EMPLEADOS D--> LISTAR EMPLEADOS CON POSIBILIDAD DE JUBILACION E--> EXIT');
		readln(n);
		case (n) of 
		    'A':A(mos,e);
			'B':B(mos,e);
			'C':listar(e);
			'D':jubilar(e);
			'E':writeln('closing..');
		end;
	end;
end.
