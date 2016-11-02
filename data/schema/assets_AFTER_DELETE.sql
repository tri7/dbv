CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`assets_AFTER_DELETE`
AFTER DELETE ON `cpm`.`assets`
FOR EACH ROW
begin
declare productId varchar(45);
declare vgmedia_old varchar(45);
declare old_fields varchar(45);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');

	if @service_assets = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(oocm.terms_id,0) 
			from obras_ocm as oocm 
			join pedido_rececao as pr on pr.obras_ocm_id = oocm.id 
			join pedido_rececao_has_assets as prha on prha.pedido_rececao_id = pr.id 
			where prha.assets_id = old.id limit 1);
        
        
        if old.versoes_gmedia_id is null then
			set vgmedia_old := 'null';
		else
			set vgmedia_old := (select versao_gmedia from versoes_gmedia where id = old.versoes_gmedia_id limit 1);
		end if;

        set old_fields := (select concat_ws(' ### ',old.id, coalesce(old.num_de_asset,'null'), vgmedia_old
			, if(old.qc_tx_pilat_id is null,'N','Y')));
		
	insert into wsaux set row_id = old.id, table_name = 'assets', 
		oldfields = old_fields, newfields = '', termsid = ifnull(productId,0), method = 'PUT', trigger_com = 'DELETE';
end if;
end