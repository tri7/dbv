CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`produtos_AFTER_UPDATE`
AFTER UPDATE ON `cpm`.`produtos`
FOR EACH ROW
BEGIN
declare num_update mediumint(11);
declare modfields varchar(100) default '';
declare wservice tinyint;
declare wservice_st tinyint;
declare date_exp_in_new datetime;
declare date_exp_out_new datetime;

SELECT 
    `id`, `status`
INTO wservice , wservice_st FROM
    servicosweb
WHERE
    name = 'updates_clientes';
    
set @a := date_add(now(),interval 1 month);    

set @fimmesseg := (select find_startend_weekmonth(@a,"end","month"));

select date_exp_in, date_exp_out into date_exp_in_new, date_exp_out_new from datas_de_exploracao dde where dde.produto_id = new.id;

if wservice_st = 1 and ((date_exp_in_new between now() and @fimmesseg) or (date_exp_out_new between now() and @fimmesseg)) then 

	if new.status_id <> old.status_id or (new.status_id is null and old.status_id is not null) or (new.status_id is not null and old.status_id is null) then
	  set modfields := 'status_id';
	  
	UPDATE produtos_hist 
		SET 
			data_envio = NOW(),
			statusprod = 'OVERRIDE'
		WHERE
			id = new.id AND data_envio IS NULL
				AND mod_fields = modfields
				AND ws_id = wservice
				and statusprod = 'ACTIVO';
                
	  set num_update := (select max(update_number) from produtos_hist 
		where id = new.id and ws_id = wservice and mod_fields = modfields and statusprod NOT IN ('APAGADO','DONE')
	  );
	  
	  insert into produtos_hist values(old.id, old.titulo, old.status_id, old.tipo_de_produto_id,
		old.data_criacao, old.data_modificacao, old.fornecedor_id, old.versao_id, old.comentarios, ifnull(num_update,-1)+1, 
			'UPDATE',now(),NULL,modfields,ifnull(wservice,0),NULL,NULL,'ACTIVO');
			
	end if;

	if new.tipo_de_produto_id <> old.tipo_de_produto_id or (new.tipo_de_produto_id is null and old.tipo_de_produto_id is not null) or (new.tipo_de_produto_id is not null and old.tipo_de_produto_id is null) then
	  set modfields := 'tipo_de_produto_id';
	  
	UPDATE produtos_hist 
		SET 
			data_envio = NOW(), statusprod = 'OVERRIDE'
		WHERE
			id = new.id AND data_envio IS NULL
				AND mod_fields = modfields
				AND ws_id = wservice
                 and statusprod = 'ACTIVO';
                
	  set num_update := (select max(update_number) from produtos_hist 
		where id = new.id and ws_id = wservice and mod_fields = modfields and statusprod NOT IN ('APAGADO','DONE')
	  );
	  
	  insert into produtos_hist values(old.id, old.titulo, old.status_id, old.tipo_de_produto_id,
		old.data_criacao, old.data_modificacao, old.fornecedor_id, old.versao_id, old.comentarios, ifnull(num_update,-1)+1, 
			'UPDATE',now(),NULL,modfields,ifnull(wservice,0),NULL,NULL,'ACTIVO');
	end if;

	if new.fornecedor_id <> old.fornecedor_id or (new.fornecedor_id is null and old.fornecedor_id is not null) or (new.fornecedor_id is not null and old.fornecedor_id is null) then
	  set modfields := 'fornecedor_id';
	  
	UPDATE produtos_hist 
		SET 
			data_envio = NOW(), statusprod = 'OVERRIDE'
		WHERE
			id = new.id AND data_envio IS NULL
				AND mod_fields = modfields
				AND ws_id = wservice
                 and statusprod = 'ACTIVO';
                
	  set num_update := (select max(update_number) from produtos_hist 
		where id = new.id and ws_id = wservice and mod_fields = modfields and statusprod NOT IN ('APAGADO','DONE')
	  );
	  
	  insert into produtos_hist values(old.id, old.titulo, old.status_id, old.tipo_de_produto_id,
		old.data_criacao, old.data_modificacao, old.fornecedor_id, old.versao_id, old.comentarios, ifnull(num_update,-1)+1, 
			'UPDATE',now(),NULL,modfields,ifnull(wservice,0),NULL,NULL,'ACTIVO');
	end if;

	if new.versao_id <> old.versao_id or (new.versao_id is null and old.versao_id is not null) or (new.versao_id is not null and old.versao_id is null) then
	  set modfields := 'versao_id';
	  
	UPDATE produtos_hist 
		SET 
			data_envio = NOW(), statusprod = 'OVERRIDE'
		WHERE
			id = new.id AND data_envio IS NULL
				AND mod_fields = modfields
				AND ws_id = wservice
                 and statusprod = 'ACTIVO';
                
	  set num_update := (select max(update_number) from produtos_hist 
		where id = new.id and ws_id = wservice and mod_fields = modfields and statusprod NOT IN ('APAGADO','DONE')
	  );
	  
	  insert into produtos_hist values(old.id, old.titulo, old.status_id, old.tipo_de_produto_id,
		old.data_criacao, old.data_modificacao, old.fornecedor_id, old.versao_id, old.comentarios, ifnull(num_update,-1)+1, 
			'UPDATE',now(),NULL,modfields,ifnull(wservice,0),NULL,NULL,'ACTIVO');
	end if;

end if;

END