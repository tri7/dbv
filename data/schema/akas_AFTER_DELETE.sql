CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`akas_AFTER_DELETE`
AFTER DELETE ON `cpm`.`akas`
FOR EACH ROW
begin
declare productId varchar(45);
declare old_fields varchar(100);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');

if @service_akas = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(terms_id,0) from obras_ocm where obras_ocm.id = old.obras_obra_id);
        set old_fields := concat_ws(' ### ',old.obras_obra_id, ifnull(old.aka,'aka NA'), old.paises_pais_id);
        
		insert into wsaux set row_id = old.id, table_name = 'akas', 
				oldfields = old_fields, newfields = '', termsid = productId, method = 'PUT', trigger_com = 'DELETE';
end if;
end