CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`obras_has_genres_AFTER_DELETE`
AFTER DELETE ON `cpm`.`obras_has_genres`
FOR EACH ROW
begin
declare productId varchar(45);
declare genero varchar(100);

declare new_fields varchar(100) default '';
declare new_fieldsid varchar(100) default '';
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	
    if @service_ohgenres = 0 and wservice_terms_out = 1 then

		set productId := (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = old.metadados_obras_id);
		
		set genero := (select group_concat(distinct g.genero order by g.genero asc separator ';') from generos g 
			join obras_has_genres ohg on ohg.genre_id = g.id
			where ohg.metadados_obras_id = old.metadados_obras_id 
			group by ohg.metadados_obras_id);
			
		set new_fields := concat_ws(' ### ',old.metadados_obras_id, ifnull(genero,''));
		set new_fieldsid := concat_ws(' ### ',old.metadados_obras_id, old.genre_id);

		insert into wsaux set row_id = new_fieldsid, table_name = 'obras_has_genres', 
				oldfields = ifnull(@genero_old,''), newfields = ifnull(new_fields,''), termsid = productId, method = 'PUT', trigger_com = 'DELETE';
	end if;
end