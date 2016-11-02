CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_AFTER_UPDATE`
AFTER UPDATE ON `cpm`.`metadados_obras`
FOR EACH ROW
begin
declare productId varchar(45);
declare classet varchar(45) default '';
declare classet_old varchar(45) default 0;

declare new_fields varchar(100);
declare old_fields varchar(100);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');

	if @service_meta = 0 and wservice_terms_out = 1 then

		set productId := (select ifnull(terms_id,0) as termsid from obras_ocm where metadados_individual_id = new.id);
        
        set classet := (select ifnull(classificacao,'') from classificacoes_etarias where id = new.classificacao_etaria_id);
        
        set new_fields := concat_ws(' ### ',ifnull(new.titulo_pt,''),ifnull(new.imdb_link,''),classet);
        
        set classet_old := (select ifnull(classificacao,'') from classificacoes_etarias where id = old.classificacao_etaria_id);
        
        set old_fields := concat_ws(' ### ',ifnull(old.titulo_pt,''),ifnull(old.imdb_link,''),classet_old);
            
		insert into wsaux set row_id = new.id, table_name = 'metadados_obras', 
			oldfields = old_fields, newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'UPDATE';
	end if;
end