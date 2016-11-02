CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`premios_BEFORE_UPDATE`
BEFORE UPDATE ON `cpm`.`premios`
FOR EACH ROW
begin
	set @service_awards := 0;
	if new.service = 1 then
		set new.service := 0;
        set @service_awards := 1;
	end if;
end