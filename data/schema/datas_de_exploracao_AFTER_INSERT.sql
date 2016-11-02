CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`datas_de_exploracao_AFTER_INSERT`
AFTER INSERT ON `cpm`.`datas_de_exploracao`
FOR EACH ROW
BEGIN
declare wservice_uc tinyint;
declare wservice_uc_st tinyint;
declare wservice_tot tinyint;
/**** updates semanais aos clientes *********/

select `id`,`status` into wservice_uc, wservice_uc_st from servicosweb where name = 'updates_clientes';

set @a := date_add(now(),interval 1 month);

set @fimmesseg := (select find_startend_weekmonth(@a,"end","month"));

if wservice_uc_st = 1 and (new.date_exp_in between now() and @fimmesseg) then 

	insert into datas_de_exploracao_hist values(new.date_exp_in,new.date_exp_out,new.produto_id, new.early_window
	,0, 'INSERT',now(),NULL,'nova_programacao',wservice_uc,NULL,NULL,'ACTIVO');

end if;
/**** trigger criacao ot *********/

set wservice_tot = (select id from servicosweb where name = 'trigger_ot');

insert into datas_de_exploracao_hist values(new.date_exp_in,new.date_exp_out,new.produto_id, new.early_window
	,0, 'INSERT',now(),NULL,'nova_programacao_trigger_ot',wservice_tot,NULL,NULL,'ACTIVO');
        
/**********************************************/

END