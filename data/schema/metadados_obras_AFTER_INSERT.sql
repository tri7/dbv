CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_AFTER_INSERT`
AFTER INSERT ON `cpm`.`metadados_obras`
FOR EACH ROW
begin
declare productId varchar(45);
declare titpt tinyint(1) default 0;
declare imdblink tinyint(1) default 0;
declare classet  varchar(45) default '';
declare new_fields varchar(100);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	if @service_meta = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = new.id);
        
        set classet := (select ifnull(classificacao,'') from classificacoes_etarias where id = new.classificacao_etaria_id);
        
        set new_fields := concat_ws(' ### ',ifnull(new.titulo_pt,''),ifnull(new.imdb_link,''),classet);

		insert into wsaux set row_id = new.id, table_name = 'metadados_obras', 
			oldfields = '', newfields = new_fields, termsid = productId,
            method = 'PUT', trigger_com = 'INSERT';
	end if;
end