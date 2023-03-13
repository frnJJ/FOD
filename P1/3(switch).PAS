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
procedure leeremp (var e:emp);
begin	
	writeln('-----------------------NUEVO EMPLEADO----------------------------');
	write('APELLIDO = ');
	readln(e.apellido);
	if (e.apellido <> 'fin') then begin
		write('NOMBRE = ');
		readln(e.nombre);
		write('NUMERO DE EMPLEADO = ');
		readln(e.num);
		write('DNI =');
		readln(e.dni);
		write('EDAD = ');
		readln(e.edad);
	end;
end;
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
procedure insertar (em:emp; var e:arc);
begin	
	reset(e);
	seek(e,filesize(e));
	write(e,em);
	close(e);
end;
procedure esta(em:emp;var e:arc;var ok:boolean);
var	
	empleado:emp;
begin	
	ok:=false;
	reset(e);
	while (not eof(e)) do begin
		read(e,empleado);
		if (empleado.dni = em.dni) then
			ok:=true;
	end;
	close(e);
end;
procedure agregar (var e:arc);
var	
	em:emp;
	ok:boolean;
begin	
	leeremp(em);
	while (em.apellido <> 'fin') do begin
		esta(em,e,ok);
		if (not ok) then	
			insertar(em,e);
		leeremp(em);
	end;
end;
procedure cedad (var e:arc);
var		
	empleado:emp;
	id,ne:integer;
begin	
	writeln('   ');
	writeln('INGRESE DNI DEL EMPLEADO PARA MODIFICAR SU EDAD');
	readln(id);
	while (id <> 0) do begin
		reset(e);
		while (not eof (e)) do begin
			read(e,empleado);
			if (empleado.dni = id) then begin
				writeln('INGRESE LA NUEVA EDAD');
				readln(ne);
				empleado.edad:= ne;
				seek(e,FilePos(e)- 1);
				write(e,empleado);
				seek(e,filesize(e));
			end;
		end;
		close(e);
		writeln('INGRESE DNI DEL EMPLEADO PARA MODIFICAR SU EDAD');
		readln(id);
	end;
end;
procedure exp (var e:arc; var txt:Text);
var	
	empleado:emp;
begin	
	assign(txt,'todos_empleados.txt');
	reset(e);
	rewrite(txt);
	while (not eof(e))do begin	
		read(e,empleado);	
		writeln(txt, empleado.nombre,' ', empleado.edad, ' ',empleado.dni, ' ');
	end;
	close(e);
	close(txt);
end;
procedure dni_cero (var e:arc; var txt: Text );
var	
	empleado:emp;
begin	
	reset(e);
	assign(txt,'Empleadocondni00.txt');
	rewrite(txt);
	while (not eof(e)) do begin	
		read(e,empleado);
		if (empleado.dni = 00)then begin
			writeln(txt,' NOMBRE = ',empleado.nombre,' APELLIDO = ',empleado.apellido,' DNI = ',empleado.dni,' NUMERO DE EMPLEADO = ',empleado.num);
		end;
	end;
	close(e);
	close(txt);
end;
var
	e:arc;
	mos:String;
	n:char;
	txt: Text;
begin
	n:='Z';
	while (n <> 'I') do begin
		writeln('OPCIONES = ');
		writeln('A --> CREAR ARCHIVO B--> LISTAR UN EMPLEADO POR NOMBRE O APELLIDO C--> LISTAR TODOS LOS EMPLEADOS D--> LISTAR EMPLEADOS CON POSIBILIDAD DE JUBILACION E--> AGREGAR EMPLEADOS F--> CAMBIAR EDAD DE EMPLEADOS G--> EXPORTAR ARCHIVO A .TXT H--> EXPORTAR ARCHICO .TXT CON EMPLEADOS CON DNI 00 I--> EXIT');
		readln(n);
		case (n) of 
		    'A':A(mos,e);
			'B':B(mos,e);
			'C':listar(e);
			'D':jubilar(e);
			'E':agregar(e);
			'F':cedad(e);
			'G':exp(e,txt);
			'H':dni_cero(e,txt);
			'I':writeln('closing..');
		end;
	end;
end.