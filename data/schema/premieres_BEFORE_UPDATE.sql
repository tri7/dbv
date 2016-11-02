CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`premieres_BEFORE_UPDATE`
BEFORE UPDATE ON `cpm`.`premieres`
FOR EACH ROW
begin
	set @service_prems := 0;
	if new.service = 1 then
		set new.service := 0;
        set @service_prems := 1;
	end if;
end