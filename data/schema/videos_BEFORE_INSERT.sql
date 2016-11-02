CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`videos_BEFORE_INSERT`
BEFORE INSERT ON `cpm`.`videos`
FOR EACH ROW
begin
declare filme_flag tinyint(11) default 0;
declare proc_vf tinyint(1) default 0;
declare proc_fi tinyint(1) default 0;
declare proc_rt tinyint(1) default 0;
        
	# video_format_id
    set proc_vf := (select new.video_format_id is not null);
    
    # formatos_de_imagem_id
    set proc_fi := (select new.formatos_de_imagem_id is not null);

    #run_time
    set proc_rt := (select new.run_time is not null);

	set @service_videos := 0;
    set filme_flag := (select pr.tipos_de_conteudos_id from pedido_rececao pr 
		join pedido_rececao_has_assets prha on prha.pedido_rececao_id = pr.id
		where prha.assets_id = new.asset_id);
        
	if filme_flag is null then
		set filme_flag := 0;
	end if;
        
	if new.service = 1 or filme_flag != 1 or (proc_vf = 0 and proc_fi = 0 and proc_rt = 0)then
		set new.service := 0;
        set @service_videos := 1;
	end if;
end