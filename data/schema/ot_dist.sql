CREATE DEFINER=`root`@`localhost` PROCEDURE `ot_dist`(IN ottipoid TINYINT, IN grupoF varchar(45), IN date_obj_temp varchar(45), IN exclds varchar(50))
this_ot_dist:
BEGIN

# data_obj_temp representa a data objectivo menos 2 dias
declare parid_temp mediumint;
declare date_obj datetime;
declare cnt tinyint;
declare quotR, sum_mins double;
declare countotns, countturnos smallint;

set date_obj := STR_TO_DATE(date_obj_temp, '%Y-%m-%d %H:%i:%s');

if date_obj < date_sub(curdate(),interval 2 day) then
	select NULL as parid, -3 as error_code;
	LEAVE this_ot_dist;
end if;

# horarios dos proximos meses existem?
if date_obj >= (select date_sub(date_add(curdate(), interval 1 month), interval day(curdate())-1 day)) then

	select count(*) into cnt from (select * from horarios where ano_mes between 
	date_format(curdate(),'%Y-%m-01') and date_obj group by ano_mes) S;
	if cnt < TIMESTAMPDIFF(MONTH,curdate(),date_obj)+1 then 
		select NULL as parid, -1 as error_code;
		LEAVE this_ot_dist;
	end if;
end if;

if date_obj < curdate() then
	set date_obj := curdate();
end if;

set @num := -1;
set @num1 := -1;
SELECT 
    paridT, quot, sum_mins, cnt_otns, cnt_turnos
INTO parid_temp , quotR , sum_mins , countotns , countturnos FROM
    ((SELECT DISTINCT
        COALESCE(H.parceiro_id, 0) AS paridT,
            COUNT(DISTINCT B.date_sequence) AS cnt_turnos,
            0 AS sum_mins,
            0 AS quot,
            0 AS cnt_otns
    FROM
        (SELECT 
        P1.parceiro_id AS parceiro_id2
    FROM
        parceiros AS P1
    JOIN grupos_has_users AS GHU ON GHU.parceiro_id = P1.parceiro_id
    JOIN grupos AS G ON G.id = GHU.grupo_id
    WHERE
        G.nome = grupoF) S
    LEFT JOIN horarios AS H ON H.parceiro_id = S.parceiro_id2
    LEFT JOIN ot_nodes AS otn ON otn.responsavel = H.parceiro_id
    JOIN turnos AS T ON H.turno_id = T.nome
    JOIN (SELECT 
        DATE_FORMAT(ADDDATE(CURDATE(), INTERVAL @num1 + 1 DAY), '%Y-%m-01') AS anomes,
            ADDDATE(CURDATE(), INTERVAL @num1 + 1 DAY) AS date_sequence,
            @num1:=@num1 + 1,
            episodios_aux.id
    FROM
        episodios_aux
    WHERE
        episodios_aux.id IS NOT NULL
            AND ADDDATE(curdate(), INTERVAL @num1 + 1 DAY) <= date_obj) B ON B.anomes = H.ano_mes
            #ADDDATE(date_obj, INTERVAL 1 DAY)) B ON B.anomes = H.ano_mes
    WHERE
        H.ano_mes BETWEEN DATE_FORMAT(CURDATE(), '%Y-%m-01') AND date_obj
            AND ADDDATE(NOW(), INTERVAL 1 HOUR) < ADDTIME(B.date_sequence, T.end_time)
            AND FIND_IN_SET(DAY(B.date_sequence), H.dias) > 0
            AND FIND_IN_SET(H.parceiro_id, exclds) = 0
            AND (T.nome = 'A' OR T.nome = 'B'
            OR T.nome = 'I'
            OR T.nome = 'S')
            AND T.end_time IS NOT NULL
            AND otn.id IS NULL
            AND H.parceiro_id NOT IN (SELECT 
                ghu.parceiro_id
            FROM
                cpm.grupos_has_users ghu
            WHERE
                ghu.grupo_id = 8)
    GROUP BY paridT) 
    UNION
    (SELECT DISTINCT
        total.paridT AS paridT,
            cnt_turnos AS cnt_turnos,
            SUM(total.havgt) AS sum_mins,
            SUM(total.havgt) / (60 * cnt_turnos * 8) AS quot,
            COUNT(DISTINCT total.otnid) AS cnt_otns
    FROM
        (SELECT DISTINCT
        COALESCE(H.parceiro_id, 0) AS paridT,
            COUNT(DISTINCT B.date_sequence) AS cnt_turnos,
            otn.id AS otnid,
            ott.human_avgt AS havgt
    FROM
        (SELECT 
        P1.parceiro_id AS parceiro_id2
    FROM
        parceiros AS P1
    JOIN grupos_has_users AS GHU ON GHU.parceiro_id = P1.parceiro_id
    JOIN grupos AS G ON G.id = GHU.grupo_id
    WHERE
        G.nome = grupoF) S
    LEFT JOIN horarios AS H ON H.parceiro_id = S.parceiro_id2
    JOIN turnos AS T ON H.turno_id = T.nome
    LEFT JOIN ot_nodes AS otn ON otn.responsavel = H.parceiro_id
    JOIN (SELECT 
        DATE_FORMAT(ADDDATE(CURDATE(), INTERVAL @num + 1 DAY), '%Y-%m-01') AS anomes,
            ADDDATE(CURDATE(), INTERVAL @num + 1 DAY) AS date_sequence,
            @num:=@num + 1,
            episodios_aux.id
    FROM
        episodios_aux
    WHERE
        episodios_aux.id IS NOT NULL
            AND ADDDATE(NOW(), INTERVAL @num + 1 DAY) <= date_obj) B ON B.anomes = H.ano_mes
            #ADDDATE(date_obj, INTERVAL 1 DAY)) B ON B.anomes = H.ano_mes
    JOIN ots ON ots.id = otn.ot_id
    JOIN ot_tipo ott ON ott.id = ots.ot_tipo_id
    WHERE
        ano_mes BETWEEN DATE_FORMAT(CURDATE(), '%Y-%m-01') AND date_obj
            AND ADDDATE(NOW(), INTERVAL 1 HOUR) < ADDTIME(B.date_sequence, T.end_time)
            AND FIND_IN_SET(DAY(B.date_sequence), H.dias) > 0
            AND FIND_IN_SET(H.parceiro_id, exclds) = 0
            AND otn.data_fim IS NULL
            AND ott.id = ottipoid
            AND H.parceiro_id NOT IN (SELECT 
                ghu.parceiro_id
            FROM
                cpm.grupos_has_users ghu
            WHERE
                ghu.grupo_id = 8)
            AND (T.nome = 'A' OR T.nome = 'B'
            OR T.nome = 'I'
            OR T.nome = 'S')
            AND T.end_time IS NOT NULL
    GROUP BY otn.id) AS total
    GROUP BY total.paridT)) F
ORDER BY paridT DESC, quot ASC , cnt_turnos DESC , sum_mins ASC , cnt_otns ASC
LIMIT 1;

#set parid := parid_temp;
#if parid is null then
#	set parid := (SELECT ghu.parceiro_id FROM appdev.grupos_has_users ghu where ghu.grupo_id = 8 limit 1);
#end if;

if parid_temp is null then
select NULL as parid, -2 as error_code;
else 
select parid_temp as parid, NULL as error_code;
end if;
END