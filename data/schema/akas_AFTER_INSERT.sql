CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`akas_AFTER_INSERT`
AFTER INSERT ON `cpm`.`akas`
FOR EACH ROW
begin
declare productId varchar(45);
declare new_fields varchar(250);
declare new_fieldsid varchar(45);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	if @service_akas = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(terms_id,0) from obras_ocm where obras_ocm.id = new.obras_obra_id);

        set new_fields := concat_ws(' ### ',new.obras_obra_id, ifnull(new.aka,'aka NA'), new.paises_pais_id);
        
        set new_fieldsid := new.id;
            
		insert into wsaux set row_id = new_fieldsid, table_name = 'akas', 
			oldfields = '', newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'INSERT';
	end if;

end