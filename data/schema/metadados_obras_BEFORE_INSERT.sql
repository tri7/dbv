CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_BEFORE_INSERT`
BEFORE INSERT ON `cpm`.`metadados_obras`
FOR EACH ROW
begin
declare proc_tit tinyint(1) default 0;
declare proc_imdb_link tinyint(1) default 0;
declare proc_classificacao_etaria_id tinyint(1) default 0;

select new.titulo_pt is not null, new.imdb_link is not null, new.classificacao_etaria_id is not null
    into proc_tit, proc_imdb_link, proc_classificacao_etaria_id;

	set @service_meta := 0;
    
	if new.service = 1 or (proc_tit = 0 and proc_imdb_link = 0 and proc_classificacao_etaria_id = 0) then
		set new.service := 0;
        set @service_meta := 1;
	end if;
end