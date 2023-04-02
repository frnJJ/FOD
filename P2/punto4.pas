program asd;
type
	detalle = record
		cod:integer;
		fecha:integer;
		tiempo:integer;
	end;
	arc = file of detalle;
	vectoraux = array [1..5] of detalle;
	vector = array [1..5] of arc;
procedure leer (var a:arc; var aux:detalle);
begin
	if (not eof(a)) then
		read(a,aux)
	else
		aux.cod:=9999;
end;
procedure calcularmin (var v:vector;var aux:vectoraux; var min:detalle);
var
	min,i,punt:integer;
begin
	min:=9999;
	for i:= 1 to 5 do begin
		if (aux[i] < min) then begin
			min:=aux[i];
			punt:=i;
		end;
	end;
	leer(v[punt],aux[punt]);
end;
procedure merge (var a: arc; var v:vector);
var
	i:integer;
	act_uno,min:detalle;
	aux:vectoraux;
	aux2:detalle;
begin
	for i:= 1 to 5 do begin
		v[i]:=reset(v[i]);
		aux[i]:=read(v[i],aux[i]);
	end;
	rewrite(a);
	calcularmin(v,aux,min);
	while (min.cod <> 9999) do begin
		act_uno:=min;
		cant:=0;
		while ((act.fecha = min.fecha) and (act.cod = min.cod))do begin
			cant:= cant+ min.tiempo;
			calcularmin(v,aux,min);
		end;
		aux2:= act_uno;
		aux2.tiempo:= cant;
		write(a,aux2);
	end;
end;
var
	a: arc;
	v:vector;
begin
	merge(a,v);
end.
