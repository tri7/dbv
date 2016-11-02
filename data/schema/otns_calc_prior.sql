CREATE DEFINER=`root`@`localhost` PROCEDURE `otns_calc_prior`(IN ottipoid mediumint, IN date_obj_temp varchar(45), IN parid mediumint)
BEGIN

declare crs_new double;
declare date_obj datetime;
declare otn_ids varchar(1000);
declare otid mediumint;
declare i mediumint;
declare prio mediumint default 0;

set date_obj := STR_TO_DATE(date_obj_temp, '%Y-%m-%d %H:%i:%s');

# cr to be updated in inserted row
select crs.value into crs_new from crs 
join ot_tipo on ot_tipo.machine_name = crs.name 
where ot_tipo.id = ottipoid;

# A prioridade e calculada linearmente atraves do val
select group_concat(B.id) as ids into otn_ids
from 
	(select otn.data_inicio is null as dinicio, otn.prioridade, convert(otn.id,signed) as id, crs.value as val, ots.data_objectivo as dobj 
			from ot_nodes otn
			join ots on ots.id = otn.ot_id
			join ot_tipo ottipo on ottipo.id = ots.ot_tipo_id
			join crs on crs.name = ottipo.machine_name
			where otn.responsavel = parid
		  union
		  select 1,0,-1, crs_new, date_obj order by dinicio asc, val ASC, dobj asc, prioridade asc) B;

set i:= 1;
while i != 0 do
	set otid := replace(substring(substring_index(otn_ids, ',', i), length(substring_index(otn_ids, ',', i - 1)) + 1), ',', '')+0;

	if otid != -1 and otid != 0 then
		update ot_nodes set prioridade = i where id = otid;
		set i := i+1;
	elseif otid = -1 then 
		set prio := i;
		set i := i+1;
	else
		set i:= 0;
	end if;
end while;

select prio;

END