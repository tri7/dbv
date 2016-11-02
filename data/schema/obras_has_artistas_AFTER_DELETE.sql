CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`obras_has_artistas_AFTER_DELETE`
AFTER DELETE ON `cpm`.`obras_has_artistas`
FOR EACH ROW
begin
declare productId varchar(45);
declare old_fields varchar(45);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	if @service_ohartistas = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = old.metadados_obras_id);
		set old_fields := concat_ws(' ### ',old.metadados_obras_id,old.artista_id,old.funcao_id); 
		insert into wsaux set row_id = old_fields, table_name = 'obras_has_artistas', 
				oldfields = old_fields, newfields = '', termsid = productId, method = 'PUT',
				 trigger_com = 'DELETE';
	end if;
end