CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_has_idiomas_AFTER_DELETE`
AFTER DELETE ON `cpm`.`metadados_obras_has_idiomas`
FOR EACH ROW
begin
declare productId varchar(45);
declare idiomas_new varchar(100);
declare new_fields varchar(100);
declare new_fieldsid varchar(100);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	if @service_meta_idiomas = 0 and wservice_terms_out = 1 then

	set productId = (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = old.metadados_obras_id);
    
    set idiomas_new := (select group_concat(distinct i.idioma order by i.idioma asc separator ';') 
			from idiomas i 
            join metadados_obras_has_idiomas mdohi on 
			i.id = mdohi.idiomas_id 
            where mdohi.metadados_obras_id = old.metadados_obras_id 
            group by mdohi.metadados_obras_id);

	set new_fields := concat_ws(' ### ',old.metadados_obras_id, ifnull(idiomas_new,''));
	set new_fieldsid := concat_ws(' ### ',old.metadados_obras_id, old.idiomas_id);
            
	insert into wsaux set row_id = new_fieldsid, table_name = 'metadados_obras_has_idiomas', 
			oldfields = ifnull(@idiomas_old,''), newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'DELETE';
            
end if;
end