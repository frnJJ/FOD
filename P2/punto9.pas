program asd;
type 
	votos  = record
		cod_p:integer;
		cod_l:integer;
		nro_mesa:integer;
		cant:integer;
	end;
	arc = file of votos;
procedure crear (var a:arc);
var
	aux:votos;
begin
	rewrite(a);
	writeln('ingrese el cod de provincia');
	readln(aux.cod_p);
	while (aux.cod_p <> 0) do begin
		writeln('ingrese el codigo de localidad');
		readln(aux.cod_l);
		writeln('ingrese el numero de mesa');
		readln(aux.nro_mesa);
		writeln('ingrese la cantidad de votos');
		readln(aux.cant);
		write(a,aux);
		writeln('--------------------');
		writeln('ingrese el cod de provincia');
		readln(aux.cod_p);
	end;
	close(a);
end;
procedure leer (var a:arc; var aux:votos);
begin
	if (not eof(a)) then 
		read(a,aux)
	else
		aux.cod_p:= 9999;
end;
procedure informar(var a:arc);
var
	act,aux:votos;
	cant_tot,cant_prov,cant_loc:integer;
begin
	reset(a);
	leer(a,aux);
	cant_loc:=0;
	cant_prov:=0;
	cant_tot:=0;
	while (aux.cod_p <> 9999) do begin
		act:= aux;
		writeln('CODIGO DE PROV: ',act.cod_p);
		while(aux.cod_p = act.cod_p) do begin
			cant_prov:= cant_prov + aux.cant;
			writeln('CODIGO DE LOC: ',act.cod_l);
			act:= aux;
			while ((aux.cod_p <> 9999) and(aux.cod_l = act.cod_l)) do begin
				cant_loc := cant_loc + aux.cant;
				leer(a,aux);
			end;
			writeln('CANT DE VOTOS DE LA LOCALIDAD: ',cant_loc);
			cant_loc:= 0;
		end;
		writeln('CANT DE VOTOS DE LA PROVINCIA: ',cant_prov);
		cant_tot:= cant_tot + cant_prov;
		cant_prov:= 0;
	end;
	writeln('VOTOS TOTALES : ',cant_tot);
	close(a);
end;
var
	a:arc;
begin
	assign(a,'ArchivodeVotos');
	informar(a);
end.
