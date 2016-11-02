CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_has_paises_AFTER_DELETE`
AFTER DELETE ON `cpm`.`metadados_obras_has_paises`
FOR EACH ROW
begin
declare productId varchar(45);
declare paises varchar(100);
declare new_fields varchar(100);
declare new_fieldsid varchar(45);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	if @service_meta_paises = 0 and wservice_terms_out = 1 then

	set productId = (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = old.metadados_obras_id);
	
    set paises := (select group_concat(distinct p.pais order by p.pais asc separator ';') 
			from paises p join metadados_obras_has_paises mdohp on 
			mdohp.paises_pais_id = p.pais_id where mdohp.metadados_obras_id = old.metadados_obras_id 
            group by mdohp.metadados_obras_id);
        
	set new_fields := concat_ws(' ### ',old.metadados_obras_id, ifnull(paises,''));
	set new_fieldsid := concat_ws(' ### ',old.metadados_obras_id, old.paises_pais_id);

	insert into wsaux set row_id = new_fieldsid, table_name = 'metadados_obras_has_paises', 
			oldfields = ifnull(@paises_old,''), newfields = ifnull(new_fields,''), termsid = productId, method = 'PUT', trigger_com = 'DELETE';
end if;
end