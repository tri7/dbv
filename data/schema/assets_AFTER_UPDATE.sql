CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`assets_AFTER_UPDATE`
AFTER UPDATE ON `cpm`.`assets`
FOR EACH ROW
begin
declare productId varchar(45);
declare new_fields varchar(100);
declare new_fieldsid varchar(45);
declare old_fields varchar(100);

declare vgmedia_new varchar(45);
declare vgmedia_old varchar(45);

declare ownerL varchar(45) default '';
declare ws_enabled tinyint(1);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');

	if @service_assets = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(oocm.terms_id,0) from obras_ocm as oocm 
			join pedido_rececao as pr on pr.obras_ocm_id = oocm.id 
            join pedido_rececao_has_assets as prha on prha.pedido_rececao_id = pr.id 
            where prha.assets_id = new.id limit 1);
            
		if new.versoes_gmedia_id is null then
			set vgmedia_new := 'null';
		else
			set vgmedia_new := (select versao_gmedia from versoes_gmedia where id = new.versoes_gmedia_id limit 1);
		end if;
        
        if old.versoes_gmedia_id is null then
			set vgmedia_old := 'null';
		else
			set vgmedia_old := (select versao_gmedia from versoes_gmedia where id = old.versoes_gmedia_id limit 1);
		end if;

        set new_fields := (select concat_ws(' ### ',new.id, coalesce(new.num_de_asset,'null'), vgmedia_new
			, if(new.qc_tx_pilat_id is null,'N','Y')));
        
        set new_fieldsid := new.id;
        
        set old_fields := (select concat_ws(' ### ',old.id, coalesce(old.num_de_asset,'null'), vgmedia_old
			, if(old.qc_tx_pilat_id is null,'N','Y')));
            
		insert into wsaux set row_id = new_fieldsid, table_name = 'assets', 
			oldfields = old_fields, newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'UPDATE';
	end if;
    
    /* GMedia */
    select tg.alias, tg.updt_ws_enabled into ownerL, ws_enabled from terms_groups tg 
		join external_owners eo on eo.terms_groups_id = tg.id
        join pedido_rececao pr on pr.obras_ocm_id = eo.obras_ocm_id
        join pedido_rececao_has_assets prha on prha.pedido_rececao_id = pr.id
        where prha.assets_id = new.id LIMIT 1;
	
    if ws_enabled = 1 then
		insert into wsaux_assets set table_name = 'assets', row_id = new.id, owner = ownerL, num_asset = new.num_de_asset;
	end if;
end