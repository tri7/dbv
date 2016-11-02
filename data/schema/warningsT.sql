CREATE DEFINER=`root`@`localhost` PROCEDURE `warningsT`()
BEGIN
declare lim,off,tot mediumint;
set lim := 500;
set off := 0;
set tot := (select count(*) from gcd_contratos.obras); 
	while 
		off < tot
	do
		call cpm.warnings(off,lim);
		set off := off + lim;
	select count(A.id) numero_warnings from cpm.warnings as A;
	end while;

/*if (select count(*) from cpm.warnings) != 0 then
	select * from cpm.warnings;
else 
	select "calling loop_obras: tudo OK";
	call loop_obras();
end if;*/
select * from cpm.warnings;
END