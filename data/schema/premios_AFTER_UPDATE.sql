CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`premios_AFTER_UPDATE`
AFTER UPDATE ON `cpm`.`premios`
FOR EACH ROW
begin
declare productId varchar(45);
declare new_fields varchar(250);
declare new_fieldsid varchar(45);
declare old_fields varchar(100);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	
    if @service_awards = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = new.metadados_obras_id);

        set new_fields := concat_ws(' ### ',new.premio, new.metadados_obras_id, ifnull(new.num_de_nomiacoes,''), ifnull(new.num_de_premio,''));
        
        set old_fields := concat_ws(' ### ',old.premio, old.metadados_obras_id, ifnull(old.num_de_nomiacoes,''), ifnull(old.num_de_premio,''));
        
        set new_fieldsid := concat_ws(' ### ',new.id, new.premio, new.metadados_obras_id);
            
		insert into wsaux set row_id = new_fieldsid, table_name = 'premios', 
			oldfields = old_fields, newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'UPDATE';
	end if;
end