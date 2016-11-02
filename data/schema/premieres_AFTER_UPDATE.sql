CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`premieres_AFTER_UPDATE`
AFTER UPDATE ON `cpm`.`premieres`
FOR EACH ROW
begin
declare productId varchar(45);
declare new_fields varchar(100);
declare old_fields varchar(100);
declare new_fieldsid varchar(45);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	
    if @service_prems = 0 and wservice_terms_out = 1 then
		set productId = (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = new.metadados_obras_id);

        set new_fields := concat_ws(' ### ',new.metadados_obras_id, new.paises_pais_id, new.plataformas_id, new.date,
			ifnull(new.boxOffice,'boxoffice NA'), ifnull(new.moedas_id,'moedas NA'));
            
		set old_fields := concat_ws(' ### ',old.metadados_obras_id, old.paises_pais_id, old.plataformas_id, old.date,
			ifnull(old.boxOffice,''), ifnull(old.moedas_id,'moedas NA'));
        
        set new_fieldsid := concat_ws(' ### ',new.metadados_obras_id, new.paises_pais_id, new.plataformas_id, new.date);
            
		insert into wsaux set row_id = new_fieldsid, table_name = 'premieres', 
			oldfields = old_fields, newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'UPDATE';
	end if;
end