program asd;
type
	maestro = record
		cod:integer;
		nombre:String;
		apellido:String;
		ano:integer;
		mes:integer;
		dia:integer;
		monto:real;
	end;
	arc = file of maestro;
procedure leer (var a:arc; var aux:maestro);
begin
	if (not eof(a)) then
		read(a,aux);
	else
		aux.cod:= 9999;
end;
procedure informar (var a:arc);
var
	cant_mes,cant_ano,cant_tot:real;
	aux,actual:maestro;
begin
	reset(a);
	leer(a,aux);
	cant_ano:=0;
	cant_mes:=0;
	cant_tot:=0;
	while (aux.cod <> 9999) do begin
		actual:=aux;
		while ((aux.cod == act.cod) and (aux.mes == act.mes) and(aux.ano == act.ano)) do begin
			cant_mes:=cant_mes + aux.monto;
			cant_ano:= cant_ano + aux.monto;
			cant_tot:= cant_tot + aux.monto;
			leer(a,aux);
		end;
		if ((aux.cod <> act.cod) or (aux.mes <> act.mes)) then begin
			writeln('Monto gastado por ',act.nombre,' en el mes ',act.mes,' es ',cant_mes);
			cant_mes:=0;
		end;
		if  ((act.cod <> aux.cod) or (aux.ano <> act.ano)) then begin
			writeln('monto gastado en el ano',cant_ano);
			cant_ano:=0;
		end;
	end;
	writeln('el total gastado es ',cant_tot);
	close(a);
end;	
var
	a:arc;
begin
	assign(a,'dontyouworry');
	rewrite(a);
	close(a);
	informar(a);
end.
	
	
