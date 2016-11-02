CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`akas_BEFORE_INSERT`
BEFORE INSERT ON `cpm`.`akas`
FOR EACH ROW
begin
	set @service_akas := 0;
	if new.service = 1 then
		set new.service := 0;
        set @service_akas := 1;
	end if;
end