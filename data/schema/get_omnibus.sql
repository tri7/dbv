CREATE DEFINER=`root`@`localhost` PROCEDURE `get_omnibus`()
BEGIN

declare finished boolean;
declare clipname varchar(64);
declare tcin varchar(11);
declare tcout varchar(11);
declare assetid mediumint(11);
declare ctcid mediumint(11);
declare dur varchar(35);
declare tcid_tmp mediumint(11);
declare lid mediumint(11);

DECLARE get_rows CURSOR FOR SELECT clip_name, tc_in, tc_out, duration FROM cpm.omnibus_clips 
where date_modified >=  subdate(now(),Interval 5 MINUTE);

DECLARE CONTINUE HANDLER 
	FOR NOT FOUND SET finished := 1;

OPEN get_rows;

vrows: LOOP

	FETCH get_rows INTO clipname, tcin, tcout, dur;

	IF finished = 1 THEN 
	LEAVE vrows;
	END IF;

	if (select count(distinct asset_id) from videos where filename_actual = clipname) != 1 then
		iterate vrows;
	end if;

	set assetid := (select asset_id from videos where filename_actual = clipname);

	update videos set run_time = dur where filename_actual = clipname;

	select count(distinct timecode_id) into ctcid from assets_has_timecodes where asset_id = assetid;

	if ctcid = 1 then

		update timecodes set tc_in = tcin, tc_out = tcout where id = 
		(select timecode_id from assets_has_timecodes where asset_id = assetid);

	elseif ctcid = 0 then
		select count(id) into tcid_tmp from timecodes where tc_in = tcin and tc_out = tcout;
        
        if tcid_tmp = 0 then
			insert into timecodes set tc_in = tcin, tc_out = tcout;
            set lid := (select last_insert_id());
		elseif tcid_tmp = 1 then
			set lid := (select id from timecodes where tc_in = tcin and tc_out = tcout);
        end if;
        if tcid_tmp = 0 or tcid_tmp = 1 then
			insert into assets_has_timecodes set asset_id = assetid, 
			timecode_id = lid;
        end if;
        
    end if;
END LOOP vrows;
 
CLOSE get_rows;



END