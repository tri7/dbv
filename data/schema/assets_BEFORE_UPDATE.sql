CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`assets_BEFORE_UPDATE`
BEFORE UPDATE ON `cpm`.`assets`
FOR EACH ROW
begin
declare filme_flag tinyint(11) default 0;
declare proc_vers tinyint(1) default 0;
declare proc_num tinyint(1) default 0;
declare proc_pilat tinyint(1) default 0;

	# versoes_gmedia_id mudou?
	set proc_vers := (select (new.versoes_gmedia_id is not null and old.versoes_gmedia_id is null) 
		or (new.versoes_gmedia_id is null and old.versoes_gmedia_id is not null)
		or (new.versoes_gmedia_id is not null and old.versoes_gmedia_id is not null and old.versoes_gmedia_id != new.versoes_gmedia_id));
	
    # num_de_asset mudou?
	set proc_num := (select (new.num_de_asset is not null and old.num_de_asset is null) 
		or (new.num_de_asset is null and old.num_de_asset is not null)
		or (new.num_de_asset is not null and old.num_de_asset is not null and old.num_de_asset != new.num_de_asset));

    # qc_tx_pilat_id mudou?
	set proc_pilat := (select (new.qc_tx_pilat_id is not null and old.qc_tx_pilat_id is null) 
		or (new.qc_tx_pilat_id is null and old.qc_tx_pilat_id is not null)
		or (new.qc_tx_pilat_id is not null and old.qc_tx_pilat_id is not null and old.qc_tx_pilat_id != new.qc_tx_pilat_id));	

	set @service_assets := 0;
    
    set filme_flag := (select pr.tipos_de_conteudos_id from pedido_rececao pr 
		join pedido_rececao_has_assets prha on prha.pedido_rececao_id = pr.id
		where prha.assets_id = new.id);
        
	if filme_flag is null then
		set filme_flag := 0;
	end if;
	
        
	# nao serao processadas
	if new.service = 1 or filme_flag != 1 or (proc_vers = 0 and proc_num = 0 and proc_pilat = 0) then
		set new.service := 0;
        set @service_assets := 1;
	end if;
    
end