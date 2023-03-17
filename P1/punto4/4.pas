program asd;
type    
    emp = record    
        nombre:String;
        edad:integer;
        dni:String[8];
    end;
    arc = file of emp;
var 
    e : arc;
    t:Text;
    aux: emp;
begin
    assign(t,'texto.txt');
    assign(e,'GIGO');
    reset(t)
    rewrite(e)
    read(t,emp);
    write(e,emp);
end.