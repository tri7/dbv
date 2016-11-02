CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`premieres_AFTER_DELETE`
AFTER DELETE ON `cpm`.`premieres`
FOR EACH ROW
begin
declare productId varchar(45);
declare boxofficet varchar(45);
declare moedas_idt varchar(45);
declare old_fields varchar(100);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	
    if /*@service_prems = 0 and*/ wservice_terms_out = 1 then
		set productId = (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = old.metadados_obras_id);
		if old.boxoffice is null or old.boxoffice = '' then set boxofficet := 'boxoffice NA'; else set boxofficet := old.boxoffice; end if;
		if old.moedas_id is null or old.moedas_id = '' then set moedas_idt := 'moedas NA'; else set moedas_idt := old.moedas_id; end if;

		set old_fields = concat_ws(' ### ',old.metadados_obras_id,old.paises_pais_id,old.plataformas_id,old.date,boxofficet,moedas_idt);

		insert into wsaux set row_id = 0, table_name = 'premieres', 
					oldfields = old_fields, 
					newfields = '', termsid = productId, method = 'PUT', trigger_com = 'DELETE';
	end if;
end