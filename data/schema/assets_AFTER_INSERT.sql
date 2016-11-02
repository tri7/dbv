CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`assets_AFTER_INSERT`
AFTER INSERT ON `cpm`.`assets`
FOR EACH ROW
begin
declare productId varchar(45);
declare new_fields varchar(100);
declare new_fieldsid varchar(45);

declare vgmedia varchar(45);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');

	if @service_assets = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(oocm.terms_id,0) from obras_ocm as oocm 
			join pedido_rececao as pr on pr.obras_ocm_id = oocm.id 
			join pedido_rececao_has_assets as prha on prha.pedido_rececao_id = pr.id
			where prha.assets_id = new.id limit 1);
            
		if new.versoes_gmedia_id is null then
			set vgmedia := 'null';
		else
			set vgmedia := (select versao_gmedia from versoes_gmedia where id = new.versoes_gmedia_id limit 1);
		end if;

        set new_fields := concat_ws(',',new.id, coalesce(new.num_de_asset,'null'), vgmedia
			, if(new.qc_tx_pilat_id is null,'N','Y'));
        
        set new_fieldsid := new.id;
            
		insert into wsaux set row_id = new_fieldsid, table_name = 'assets', 
			oldfields = '', newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'INSERT';
	end if;
end