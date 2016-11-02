CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`premios_AFTER_DELETE`
AFTER DELETE ON `cpm`.`premios`
FOR EACH ROW
begin
declare productId varchar(45);
declare numnomiacoes varchar(45);
declare numpremio varchar(45);
declare old_fields varchar(100);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	
    if @service_awards = 0 and wservice_terms_out = 1 then

		set productId = (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = old.metadados_obras_id);
		if old.num_de_nomiacoes is null or old.num_de_nomiacoes = '' then
			set numnomiacoes := 'numnomiacoes NA'; 
		else
			set numnomiacoes := old.num_de_nomiacoes;
		end if;

		if old.num_de_premio is null or old.num_de_premio = '' then 
			set numpremio := 'numpremio NA';
		else
			set numpremio := old.num_de_premio;
		end if;
		
		set old_fields = concat_ws(' ### ',old.id,old.premio,old.metadados_obras_id,numnomiacoes,numpremio);

		insert into wsaux set row_id = 0, table_name = 'premios', 
					oldfields = old_fields, 
					newfields = '', termsid = productId, method = 'PUT', trigger_com = 'DELETE';
            
	end if;
end