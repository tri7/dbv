CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`videos_AFTER_UPDATE`
AFTER UPDATE ON `cpm`.`videos`
FOR EACH ROW
begin
declare productId varchar(45);
declare new_fields varchar(100);
declare new_fieldsid varchar(45);
declare old_fields varchar(100);
declare iformato_new varchar(45);
declare vformato_new varchar(45);
declare iformato_old varchar(45);
declare vformato_old varchar(45);

declare ownerL varchar(45) default '';
declare num_asset varchar(15) default '';
declare ws_enabled tinyint(1) default 0;
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	
    if @service_videos = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(oocm.terms_id,0) from obras_ocm as oocm 
			join pedido_rececao as pr on pr.obras_ocm_id = oocm.id 
			join pedido_rececao_has_assets as prha on prha.pedido_rececao_id = pr.id 
			join videos as v on v.asset_id = prha.assets_id 
			where v.id = new.id);
            
		if new.video_format_id is null then
			set vformato_new := 'null';
		else
			set vformato_new := (select formato from formatos_de_video where id = new.video_format_id);
        end if;
        
        if new.formatos_de_imagem_id is null then
			set iformato_new := 'null';
		else
			set iformato_new := (select formato from formatos_de_imagem where id = new.formatos_de_imagem_id);
        end if;
        
        if old.video_format_id is null then
			set vformato_old := 'null';
		else
			set vformato_old := (select formato from formatos_de_video where id = old.video_format_id);
        end if;
        
        if old.formatos_de_imagem_id is null then
			set iformato_old := 'null';
		else
			set iformato_old := (select formato from formatos_de_imagem where id = old.formatos_de_imagem_id);
        end if;
        

        set new_fields := (select concat_ws(',',new.id, vformato_new, iformato_new, coalesce(new.run_time,'null')));
        
        set new_fieldsid := new.id;
        
        set old_fields := (select concat_ws(',',old.id, vformato_old, iformato_old, coalesce(old.run_time,'null')));
            
		insert into wsaux set row_id = new_fieldsid, table_name = 'videos', 
			oldfields = old_fields, newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'UPDATE';
	end if;
    
	/* GMedia */
	select tg.alias, tg.updt_ws_enabled, a.num_de_asset into ownerL, ws_enabled, num_asset from terms_groups tg 
		join external_owners eo on eo.terms_groups_id = tg.id
		join pedido_rececao pr on pr.obras_ocm_id = eo.obras_ocm_id
		join pedido_rececao_has_assets prha on prha.pedido_rececao_id = pr.id
		join videos vid on vid.asset_id = prha.assets_id
		where vid.id = new.id LIMIT 1;
	if ws_enabled = 1 then
		insert into wsaux_assets set table_name = 'videos', row_id = new.id, owner = ownerL, num_asset = num_asset;
	end if;
end