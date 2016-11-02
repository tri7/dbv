CREATE DEFINER=`root`@`localhost` PROCEDURE `update_epis`(IN idF mediumint,IN episT mediumint)
BEGIN

declare lastID mediumint;
declare mdiff mediumint;
declare diff mediumint;
declare episT_old mediumint;
declare epis_type_id mediumint;

set epis_type_id := (select id from cpm.tipos_de_obra where tipo = "EPISODIO");
set episT_old := (select num_total_episodios from cpm.obras_ocm where id = idF);
set diff = episT - episT_old;

SET SQL_SAFE_UPDATES=0;

if diff < 0 then

	update cpm.obras_ocm set status = 0 where serie_id = idF and num_episodio > episT;

	update cpm.obras_ocm set num_total_episodios = episT where id = idF or (serie_id = idF and num_episodio <= episT);

elseif diff > 0 then

	insert into cpm.metadados_obras (id) select null from cpm.episodios_aux limit diff;

	set lastID := last_insert_id();

	insert into cpm.obras_ocm (metadados_individual_id,tipos_de_obra_id,num_episodio,num_total_episodios,serie_id) 
		select meta1,tipo1,epis1,episT,idFf from 
		(select @meta:=@meta+1 as meta1,@tipo as tipo1,@epis := @epis+1 as epis1,episTf,idFf from 
		(select @meta := lastID-1,@tipo := epis_type_id,@epis := episT - diff,episT as episTf,idF as idFf) vars 
		,cpm.episodios_aux limit diff) vars1;

	update cpm.obras_ocm set num_total_episodios = episT where id = idF or (serie_id = idF and num_episodio <= episT_old);

end if;


SET SQL_SAFE_UPDATES=1;


END