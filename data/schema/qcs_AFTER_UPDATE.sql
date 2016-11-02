CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`qcs_AFTER_UPDATE` AFTER UPDATE ON `qcs` FOR EACH ROW
BEGIN
declare ownerL varchar(45) default '';
declare num_asset varchar(15) default '';
declare ws_enabled tinyint(1) default 0;
	/* GMedia */
    select tg.alias, tg.updt_ws_enabled, a.num_de_asset into ownerL, ws_enabled, num_asset from terms_groups tg 
		join external_owners eo on eo.terms_groups_id = tg.id
        join pedido_rececao pr on pr.obras_ocm_id = eo.obras_ocm_id
        join pedido_rececao_has_assets prha on prha.pedido_rececao_id = pr.id
        join assets a on a.id = prha.assets_id
        join qcs on qcs.id = a.qc_id
        where qcs.id = new.id LIMIT 1;
	
    if ws_enabled = 1 then
		insert into wsaux_assets set table_name = 'qcs', row_id = new.id, owner = ownerL, num_asset = num_asset;
	end if;
END