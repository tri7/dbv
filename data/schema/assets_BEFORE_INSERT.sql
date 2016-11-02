CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`assets_BEFORE_INSERT`
BEFORE INSERT ON `cpm`.`assets`
FOR EACH ROW
begin
declare filme_flag tinyint(11) default 0;
declare proc_vers tinyint(1) default 0;
declare proc_num tinyint(1) default 0;
declare proc_pilat tinyint(1) default 0;

	set @service_assets := 0;
    set filme_flag := (select pr.tipos_de_conteudos_id from pedido_rececao pr 
		join pedido_rececao_has_assets prha on prha.pedido_rececao_id = pr.id
		where prha.assets_id = new.id);
        
	if filme_flag is null then
		set filme_flag := 0;
	end if;
        
	# versoes_gmedia_id mudou?
    if new.versoes_gmedia_id is not null then
		set proc_vers := 1;
	end if;
    
    # num_de_asset mudou?
	if new.num_de_asset is not null then
		set proc_num := 1;
	end if;

    # qc_tx_pilat_id mudou?
    if new.num_de_asset is not null then
		set proc_num := 1;
	end if;

	if new.service = 1 or filme_flag != 1 or (proc_vers = 0 and proc_num = 0 and proc_pilat = 0) then
		set new.service := 0;
        set @service_assets := 1;
	end if;
end