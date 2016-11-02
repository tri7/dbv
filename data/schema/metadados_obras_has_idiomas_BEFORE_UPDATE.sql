CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_has_idiomas_BEFORE_UPDATE`
BEFORE UPDATE ON `cpm`.`metadados_obras_has_idiomas`
FOR EACH ROW
begin
set @service_meta_idiomas := 0;
set @idiomas_old := (select group_concat(distinct i.idioma order by i.idioma asc separator ';') 
			from idiomas i join metadados_obras_has_idiomas mdohi on 
			i.id = mdohi.idiomas_id 
            where mdohi.metadados_obras_id = old.metadados_obras_id 
            group by mdohi.metadados_obras_id);
	if new.service = 1 then 
		set new.service := 0;
        set @service_meta_idiomas := 1;
    end if;
end