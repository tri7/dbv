CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`sons_BEFORE_INSERT`
BEFORE INSERT ON `cpm`.`sons`
FOR EACH ROW
begin
declare filme_flag tinyint(11) default 0;
declare tmix tinyint(1) default 0;

	# tipo_de_mix
    set tmix := (select new.tipo_de_mix is not null);

	set @service_sons := 0;
    set filme_flag := (select pr.tipos_de_conteudos_id from pedido_rececao pr 
		join pedido_rececao_has_assets prha on prha.pedido_rececao_id = pr.id
		where prha.assets_id = new.asset_id);
        
	if filme_flag is null then
		set filme_flag := 0;
	end if;
        
	if new.service = 1 or filme_flag != 1 or tmix = 0 then
		set new.service := 0;
        set @service_sons := 1;
	end if;
end