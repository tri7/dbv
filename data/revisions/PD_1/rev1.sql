use `appdev`;

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_dist_naolinear`()
BEGIN
declare done boolean default false;
declare cnl_id mediumint(11);
declare plt_id mediumint(11);
declare novstab boolean;

DECLARE cur1 CURSOR FOR 
SELECT distinct cnlp.clientes_nao_linear_id, cnlp.plataformas_id, cnlp.novidades 
from clientes_nao_linear_plataforma cnlp where cnlp.feedback = 1 and cnlp.disabled = 0;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;

OPEN cur1;

read_loop: LOOP
  
FETCH cur1 INTO cnl_id, plt_id, novstab;

IF done THEN
    LEAVE read_loop;
END IF;

	BEGIN
    
    declare prdid int;
	declare novidade varchar(3);
	declare done2 boolean default false;
		
	DECLARE cur2 CURSOR FOR
		SELECT DISTINCT
			prd.id as prdid, 
			if(dde.early_window = 0 and prd.status_id IN (1,2,3),"yes","no") AS novidade
		FROM
			datas_de_exploracao dde
				RIGHT JOIN
			produtos prd ON prd.id = dde.produto_id
				JOIN
			tipos_de_produtos tdp ON prd.tipo_de_produto_id = tdp.id
				AND tdp.plataforma_id = plt_id
				LEFT JOIN
			majors_nao_linear AS mnl ON mnl.major_id = prd.fornecedor_id
				LEFT JOIN
			dist_nao_linear ON dist_nao_linear.tipo_de_produto_id = tdp.id
				AND dist_nao_linear.fornecedor_id = COALESCE(mnl.parent_id, mnl.major_id)
				JOIN
			produtos_has_obras_ocm phoocm ON phoocm.produtos_id = prd.id
				JOIN
			obras_ocm oocm ON oocm.id = phoocm.obras_ocm_id
				JOIN
			metadados_obras mdo ON mdo.id = oocm.metadados_individual_id
		WHERE DATE(dde.date_exp_in) BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 40 DAY)
				AND dist_nao_linear.cliente_id = cnl_id
				AND prd.status_id = 3
		GROUP BY prd.id;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 := TRUE;

	OPEN cur2;

	read_loop2: LOOP
	  
	FETCH cur2 INTO prdid,novidade;

	IF done2 THEN
		LEAVE read_loop2;
	END IF;
#select prdid;
	if (select exists (select produtos_id, cliente_id as cnt from dist_nao_linear_por_produto where produtos_id = prdid and cliente_id = cnl_id limit 1)) then
	 ITERATE read_loop2; 
	end if;

	if novidade = "yes" then 
		insert into dist_nao_linear_por_produto set produtos_id = prdid, cliente_id = cnl_id, feedback = 1;
	elseif novidade = "no" then 
		insert into dist_nao_linear_por_produto set produtos_id = prdid, cliente_id = cnl_id, feedback = 1-novstab;
	end if;


	END LOOP read_loop2;

	CLOSE cur2;

	END;


END LOOP read_loop;

CLOSE cur1;

END;

ALTER TABLE `cpm`.`akas` 
CHANGE COLUMN `aka` `aka` VARCHAR(255) NULL DEFAULT NULL COMMENT '';

CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_dist_naolinear`()
BEGIN
declare done boolean default false;
declare cnl_id mediumint(11);
declare plt_id mediumint(11);
declare novstab boolean;

DECLARE cur1 CURSOR FOR 
SELECT distinct cnlp.clientes_nao_linear_id, cnlp.plataformas_id, cnlp.novidades 
from clientes_nao_linear_plataforma cnlp where cnlp.feedback = 1 and cnlp.disabled = 0;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;

OPEN cur1;

read_loop: LOOP
  
FETCH cur1 INTO cnl_id, plt_id, novstab;

IF done THEN
    LEAVE read_loop;
END IF;

	BEGIN
    
    declare prdid int;
	declare novidade varchar(3);
	declare done2 boolean default false;
		
	DECLARE cur2 CURSOR FOR
		SELECT DISTINCT
			prd.id as prdid, 
			if(dde.early_window = 0 and prd.status_id IN (1,2,3),"yes","no") AS novidade
		FROM
			datas_de_exploracao dde
				RIGHT JOIN
			produtos prd ON prd.id = dde.produto_id
				JOIN
			tipos_de_produtos tdp ON prd.tipo_de_produto_id = tdp.id
				AND tdp.plataforma_id = plt_id
				LEFT JOIN
			majors_nao_linear AS mnl ON mnl.major_id = prd.fornecedor_id
				LEFT JOIN
			dist_nao_linear ON dist_nao_linear.tipo_de_produto_id = tdp.id
				AND dist_nao_linear.fornecedor_id = COALESCE(mnl.parent_id, mnl.major_id)
				JOIN
			produtos_has_obras_ocm phoocm ON phoocm.produtos_id = prd.id
				JOIN
			obras_ocm oocm ON oocm.id = phoocm.obras_ocm_id
				JOIN
			metadados_obras mdo ON mdo.id = oocm.metadados_individual_id
		WHERE DATE(dde.date_exp_in) BETWEEN NOW() AND DATE_ADD(NOW(), INTERVAL 40 DAY)
				AND dist_nao_linear.cliente_id = cnl_id
				AND prd.status_id = 3
		GROUP BY prd.id;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done2 := TRUE;

	OPEN cur2;

	read_loop2: LOOP
	  
	FETCH cur2 INTO prdid,novidade;

	IF done2 THEN
		LEAVE read_loop2;
	END IF;
#select prdid;
	if (select exists (select produtos_id, cliente_id as cnt from dist_nao_linear_por_produto where produtos_id = prdid and cliente_id = cnl_id limit 1)) then
	 ITERATE read_loop2; 
	end if;

	if novidade = "yes" then 
		insert into dist_nao_linear_por_produto set produtos_id = prdid, cliente_id = cnl_id, feedback = 1;
	elseif novidade = "no" then 
		insert into dist_nao_linear_por_produto set produtos_id = prdid, cliente_id = cnl_id, feedback = 1-novstab;
	end if;


	END LOOP read_loop2;

	CLOSE cur2;

	END;


END LOOP read_loop;

CLOSE cur1;

END;

ALTER TABLE `cpm`.`akas` 
CHANGE COLUMN `aka` `aka` VARCHAR(255) NULL DEFAULT NULL COMMENT '';