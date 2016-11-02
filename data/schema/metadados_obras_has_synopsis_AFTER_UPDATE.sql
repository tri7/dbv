CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_has_synopsis_AFTER_UPDATE`
AFTER UPDATE ON `cpm`.`metadados_obras_has_synopsis`
FOR EACH ROW
begin
declare productId varchar(45);
declare new_fields varchar(100);
declare old_fields varchar(100);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	if @service_synopsis = 0 and wservice_terms_out = 1 then
    
		set productId = (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = new.metadados_obras_id);

        set new_fields := concat_ws(' ### ',new.metadados_obras_id, new.synopsis_id,new.paises_pais_id, new.idiomas_id);
        
        set old_fields := concat_ws(' ### ',old.metadados_obras_id, old.synopsis_id,old.paises_pais_id, old.idiomas_id);
            
		insert into wsaux set row_id = new_fields, table_name = 'metadados_obras_has_synopsis', 
			oldfields = old_fields, newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'UPDATE';
	end if;
end