CREATE DEFINER=`root`@`localhost` PROCEDURE `teste`(IN serieid int, IN prdid int)
BEGIN

DECLARE cur_produtos CURSOR FOR
    
    select distinct 
      phoocm.produtos_id, 
      oocm.id /*as epis_hist_id*/, 
      /*oocm.serie_id as epis_hist_serie_id, 
      oocm.num_episodio as epis_hist_num_epis, 
      oocm.deleted_flag as epis_hist_del_flag, */
      oocm_terms.id /*as new_oocm_id, 
      oocm_terms.terms_id as new_terms_id, 
      oocm_terms.deleted_flag*/

    from produtos_has_obras_ocm phoocm
    join obras_ocm oocm on oocm.id = phoocm.obras_ocm_id
    join obras_ocm oocm_terms on oocm_terms.serie_id = oocm.serie_id and oocm_terms.num_episodio = oocm.num_episodio
    where
	  if(prdid = 0,1 = 1, phoocm.produtos_id = prdid) and
    
      oocm.serie_id = serieid
      and oocm.terms_id is null 
      and oocm.deleted_flag = 1 
      and oocm.num_episodio is not null 
      and oocm.tipos_de_obra_id = 5
      
      and oocm_terms.terms_id is not null 
      and oocm_terms.deleted_flag = 0
      and oocm_terms.tipos_de_obra_id = 5;


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
      oocm.serie_id = serieid
      and oocm.terms_id is null 
      and oocm.deleted_flag = 1 
      and oocm.num_episodio is not null 
      and oocm.tipos_de_obra_id = 5
      
      and oocm_terms.terms_id is not null 
      and oocm_terms.deleted_flag = 0
      and oocm_terms.tipos_de_obra_id = 5;
    

  OPEN cur_produtos;
  BEGIN
      DECLARE exit_flag INT DEFAULT 0;
      
      DECLARE produtoid INT(10);
      DECLARE hist_oocmid INT(10);
      DECLARE new_oocmid INT(10);

      DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_flag = 1;

      cur_produtosLoop: LOOP
        FETCH cur_produtos INTO produtoid, hist_oocmid, new_oocmid;
            IF exit_flag THEN LEAVE cur_produtosLoop; 
            END IF;
            select new_oocmid;
            #update produtos_has_obras_ocm set obras_ocm_id = new_oocmid where produtos_id = produtoid and obras_ocm_id = hist_oocmid;
      END LOOP;
  END;
  CLOSE cur_produtos;

  OPEN cur_pedidos;
  BEGIN
      DECLARE exit_flag INT DEFAULT 0;
      
      DECLARE produtoid INT(10);
      DECLARE hist_oocmid INT(10);
      DECLARE new_oocmid INT(11);

      DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_flag = 1;

      cur_pedidosLoop: LOOP
        FETCH cur_produtos INTO produtoid, hist_oocmid, new_oocmid;
            IF exit_flag THEN LEAVE cur_pedidosLoop; 
            END IF;
            #update pedido_rececao set obras_ocm_id = new_oocmid where id = produtoid and obras_ocm_id = hist_oocmid;
      END LOOP;
  END;
  CLOSE cur_pedidos;


END