CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`datas_de_exploracao_AFTER_UPDATE`
AFTER UPDATE ON `cpm`.`datas_de_exploracao`
FOR EACH ROW
BEGIN
declare num_update mediumint(11);
declare modfields varchar(50) default '';
declare wservice_uc tinyint;
declare wservice_uc_st tinyint;
declare wservice_tot tinyint;
/**** updates semanais aos clientes *********/
select `id`,`status` into wservice_uc, wservice_uc_st from servicosweb where name = 'updates_clientes';

set @a := date_add(now(),interval 1 month);

set @fimmesseg := (select find_startend_weekmonth(@a,"end","month"));

if wservice_uc_st = 1 and ((new.date_exp_in between now() and @fimmesseg) or (new.date_exp_out between now() and @fimmesseg)) then 

	if (new.date_exp_in <> old.date_exp_in or (new.date_exp_in is null and old.date_exp_in is not null) or 
	   (new.date_exp_in is not null and old.date_exp_in is null)) 
	   or 
	   (new.date_exp_out <> old.date_exp_out or (new.date_exp_out is null and old.date_exp_out is not null) or 
	   (new.date_exp_out is not null and old.date_exp_out is null)) then
       
       set modfields := 'alteracao_datas';
       
	   set num_update := (select max(update_number) from datas_de_exploracao_hist 
		where produto_id = new.produto_id and ws_id = wservice_uc and (mod_fields = modfields or mod_fields = 'nova_programacao')
        and statusprod NOT IN ('APAGADO','DONE') 
	   );
	  
	   update datas_de_exploracao_hist set data_envio = now(), statusprod = 'OVERRIDE'
		where produto_id = new.produto_id and data_envio is null 
        and (mod_fields = modfields or mod_fields = 'nova_programacao') 
        and ws_id = wservice_uc and statusprod = 'ACTIVO';
	  
	   insert into datas_de_exploracao_hist values(old.date_exp_in,old.date_exp_out,old.produto_id, old.early_window,
		ifnull(num_update,-1)+1, 'UPDATE',now(),NULL,modfields,ifnull(wservice_uc,0),NULL,NULL,'ACTIVO');
	end if;
end if;
/**** trigger criacao ot *********/
/* Existe row na datas_exploracao_hist ainda nao enviado (data_envio is null) relativa ao produto_id? */
/* Se sim actualizar */

set wservice_tot = (select id from servicosweb where name = 'trigger_ot');

set num_update := (select max(update_number) from datas_de_exploracao_hist 
		where produto_id = new.produto_id and ws_id = wservice_tot and statusprod NOT IN ('APAGADO','DONE')
	  );

update datas_de_exploracao_hist set data_envio = now(), statusprod = 'OVERRIDE' 
	where produto_id = new.produto_id and data_envio is null and ws_id = wservice_tot and statusprod = 'ACTIVO';
    
insert into datas_de_exploracao_hist values(old.date_exp_in,old.date_exp_out,old.produto_id, old.early_window,
	ifnull(num_update,-1)+1, 'UPDATE',now(),NULL,'nova_programacao_trigger_ot',ifnull(wservice_tot,0),NULL,NULL,'ACTIVO');

        
/**********************************************/


END