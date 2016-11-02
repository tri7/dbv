CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_has_paises_BEFORE_UPDATE`
BEFORE UPDATE ON `cpm`.`metadados_obras_has_paises`
FOR EACH ROW
begin
	set @service_meta_paises := 0;
    set @paises_old := (select group_concat(distinct p.pais order by p.pais asc separator ';') 
			from paises p join metadados_obras_has_paises mdohp on 
			mdohp.paises_pais_id = p.pais_id where mdohp.metadados_obras_id = old.metadados_obras_id 
            group by mdohp.metadados_obras_id);
            
	if new.service = 1 then
		set new.service := 0;
        set @service_meta_paises := 1;
	end if;
end