CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`obras_has_artistas_AFTER_INSERT`
AFTER INSERT ON `cpm`.`obras_has_artistas`
FOR EACH ROW
begin
declare productId varchar(45);
declare artista_name varchar(100);
declare funcao_artista varchar(45);
declare new_fields varchar(100);
declare new_fieldsid varchar(45);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	if @service_ohartistas = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = new.metadados_obras_id);
        
        set artista_name := (select a.nome from artistas a where a.id = new.artista_id);
        set funcao_artista := (select fda.funcao_de_artista from funcoes_de_artista fda where fda.id = new.funcao_id);
        
        set new_fields := concat_ws(' ### ',new.metadados_obras_id, artista_name, funcao_artista);
        set new_fieldsid := concat_ws(' ### ',new.metadados_obras_id, new.artista_id, new.funcao_id);
            
		insert into wsaux set row_id = new_fieldsid, table_name = 'obras_has_artistas', 
			oldfields = '', newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'INSERT';
	end if;
end