CREATE DEFINER=`root`@`localhost` PROCEDURE `correct_obras_pedidos`(IN serieid varchar(200), IN pedido_recid int)
BEGIN

  DECLARE cur_pedidos CURSOR FOR

    select distinct 
      pdr.id as pdr_id, 
      pdr.obras_ocm_id,
        /*oocm.id as epis_hist_id, 
      oocm.serie_id as epis_hist_serie_id, 
      oocm.num_episodio as epis_hist_num_epis, 
      oocm.deleted_flag as epis_hist_del_flag,*/ 
      oocm_terms.id as new_oocm_id/*, 
      oocm_terms.terms_id as new_terms_id, 
      oocm_terms.deleted_flag*/
     
    from pedido_rececao pdr
    join obras_ocm oocm on oocm.id = pdr.obras_ocm_id
    join obras_ocm oocm_terms on oocm_terms.serie_id = oocm.serie_id and oocm_terms.num_episodio = oocm.num_episodio
    where 
    if(pedido_recid = 0,1 = 1, pdr.id = pedido_recid) and
    
      find_in_set(oocm.serie_id, serieid)
      and oocm.terms_id is null 
      and oocm.deleted_flag = 1 
      and oocm.num_episodio is not null 
      and oocm.tipos_de_obra_id = 5
      
      and oocm_terms.terms_id is not null 
      and oocm_terms.deleted_flag = 0
      and oocm_terms.tipos_de_obra_id = 5;

  OPEN cur_pedidos;
  BEGIN
      DECLARE exit_flag INT DEFAULT 0;
      
      DECLARE pdrid INT(10);
      DECLARE hist_oocmid INT(10);
      DECLARE new_oocmid INT(10);

      DECLARE CONTINUE HANDLER FOR NOT FOUND
      begin
		SELECT 1 INTO exit_flag FROM (SELECT 1) AS t;
      end;

      cur_pedidosLoop: LOOP
        FETCH cur_pedidos INTO pdrid, hist_oocmid, new_oocmid;
        
            IF exit_flag THEN LEAVE cur_pedidosLoop; 
            END IF;
            update pedido_rececao set obras_ocm_id = new_oocmid where id = pdrid;
            insert into hist_correct set tabela = 'pedido_rececao', elem_id = pdrid, old_obraid = hist_oocmid, new_obraid = new_oocmid;
      END LOOP;
  END;
  CLOSE cur_pedidos;

END