CREATE DEFINER=`root`@`localhost` FUNCTION `find_startend_weekmonth`(dt datetime,command ENUM('start','end'),typeF ENUM('week','month')) RETURNS date
    DETERMINISTIC
BEGIN
declare week_stdate date;
declare week_eddate date;
declare month_stdate date;
declare month_eddate date;
if command = "start" then
	if typeF = "week" then
		set week_stdate := adddate(dt,interval -weekday(dt) day);
    elseif typeF = "month" then
		set month_stdate := adddate(dt,interval -dayofmonth(dt)+1 day);
    end if;
	
elseif command = "end" then

	if typeF = "week" then
		set week_eddate := adddate(dt,interval (6-weekday(dt)) day);
    elseif typeF = "month" then
		set month_eddate := last_day(dt);
    end if;
	
end if;
if command = "start" and typeF = "week" then
	RETURN week_stdate;
elseif command = "start" and typeF = "month" then
	return month_stdate;
elseif command = "end" and typeF = "week" then
	return week_eddate;
elseif command = "end" and typeF = "month" then
	return month_eddate;
end if;
END