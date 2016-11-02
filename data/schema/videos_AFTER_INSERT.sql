CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`videos_AFTER_INSERT`
AFTER INSERT ON `cpm`.`videos`
FOR EACH ROW
begin
declare productId varchar(45);
declare new_fields varchar(100);
declare new_fieldsid varchar(45);
declare iformato varchar(45);
declare vformato varchar(45);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	
    if @service_videos = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(oocm.terms_id,0) from obras_ocm as oocm 
			join pedido_rececao as pr on pr.obras_ocm_id = oocm.id 
			join pedido_rececao_has_assets as prha on prha.pedido_rececao_id = pr.id 
			join videos as v on v.asset_id = prha.assets_id 
			where v.id = new.id);
            
		if new.video_format_id is null then
			set vformato := 'null';
		else
			set vformato := (select formato from formatos_de_video where id = new.video_format_id);
        end if;
        
        if new.formatos_de_imagem_id is null then
			set iformato := 'null';
		else
			set iformato := (select formato from formatos_de_imagem where id = new.formatos_de_imagem_id);
        end if;

        set new_fields := (select concat_ws(',',new.id, vformato, iformato, coalesce(new.run_time,'null')));
        
        set new_fieldsid := new.id;
            
		insert into wsaux set row_id = new_fieldsid, table_name = 'videos', 
			oldfields = '', newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'INSERT';
	end if;
end