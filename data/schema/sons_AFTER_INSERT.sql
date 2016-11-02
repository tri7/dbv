CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`sons_AFTER_INSERT`
AFTER INSERT ON `cpm`.`sons`
FOR EACH ROW
begin
declare productId varchar(45);
declare new_fields varchar(100);
declare new_fieldsid varchar(45);
declare tipos_mix varchar(45);
declare wservice_terms_out tinyint(1);

set wservice_terms_out := (select status from servicosweb where name = 'terms_out');
	
    if @service_sons = 0 and wservice_terms_out = 1 then
		set productId := (select ifnull(oocm.terms_id,0) from obras_ocm as oocm 
			join pedido_rececao as pr on pr.obras_ocm_id = oocm.id 
			join pedido_rececao_has_assets as prha on prha.pedido_rececao_id = pr.id 
			join sons as s on s.asset_id = prha.assets_id 
			where s.id = new.id);
            
		if new.tipo_de_mix is null then
			set tipos_mix := 'null';
		else 	           
			set tipos_mix := (select tipo from tipos_de_mix where id = new.tipo_de_mix);
		end if;
        
        set new_fields := (select concat_ws(',',new.id, tipos_mix));
        
        set new_fieldsid := new.id;
            
		insert into wsaux set row_id = new_fieldsid, table_name = 'sons', 
			oldfields = '', newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'INSERT';
	end if;
end