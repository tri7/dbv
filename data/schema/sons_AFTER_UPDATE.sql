CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`sons_AFTER_UPDATE`
AFTER UPDATE ON `cpm`.`sons`
FOR EACH ROW
begin
declare productId varchar(45);
declare new_fields varchar(100);
declare new_fieldsid varchar(45);
declare old_fields varchar(100);
declare tipos_mix_new varchar(45);
declare tipos_mix_old varchar(45);

declare ownerL varchar(45) default '';
declare num_asset varchar(15) default '';
declare ws_enabled tinyint(1) default 0;
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	
    if @service_sons = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(oocm.terms_id,0) from obras_ocm as oocm 
			join pedido_rececao as pr on pr.obras_ocm_id = oocm.id
			join pedido_rececao_has_assets as prha on prha.pedido_rececao_id = pr.id 
			join sons as s on s.asset_id = prha.assets_id 
			where s.id = new.id);
            
		if new.tipo_de_mix is null then
			set tipos_mix_new := 'null';
		else 	           
			set tipos_mix_new := (select tipo from tipos_de_mix where id = new.tipo_de_mix);
		end if;
        
        if old.tipo_de_mix is null then
			set tipos_mix_old := 'null';
		else 	           
			set tipos_mix_old := (select tipo from tipos_de_mix where id = old.tipo_de_mix);
		end if;

        set new_fields := (select concat_ws(',',new.id, tipos_mix_new));
        
        set new_fieldsid := new.id;
        
        set old_fields := (select concat_ws(',',new.id, tipos_mix_old));
            
		insert into wsaux set row_id = new_fieldsid, table_name = 'sons', 
			oldfields = old_fields, newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'UPDATE';
	end if;
    
    /* GMedia */
	select tg.alias, tg.updt_ws_enabled, a.num_de_asset into ownerL, ws_enabled, num_asset from terms_groups tg 
		join external_owners eo on eo.terms_groups_id = tg.id
		join pedido_rececao pr on pr.obras_ocm_id = eo.obras_ocm_id
		join pedido_rececao_has_assets prha on prha.pedido_rececao_id = pr.id
        join assets a on prha.assets_id = a.id
		join sons on sons.asset_id = prha.assets_id
		where sons.id = new.id LIMIT 1;
	
    if ws_enabled = 1 then
		insert into wsaux_assets set table_name = 'sons', row_id = new.id, owner = ownerL, num_asset = num_asset;
	end if;
end