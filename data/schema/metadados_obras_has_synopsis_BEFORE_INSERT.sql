CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_has_synopsis_BEFORE_INSERT`
BEFORE INSERT ON `cpm`.`metadados_obras_has_synopsis`
FOR EACH ROW
begin
	set @service_synopsis := 0;
	if new.service = 1 then
		set new.service := 0;
        set @service_synopsis := 1;
	end if;
end