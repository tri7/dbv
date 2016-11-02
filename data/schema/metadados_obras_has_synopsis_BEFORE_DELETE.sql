CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_has_synopsis_BEFORE_DELETE`
BEFORE DELETE ON `cpm`.`metadados_obras_has_synopsis`
FOR EACH ROW
BEGIN
	set @service_synopsis := 0;
	if old.service = 1 then
        set @service_synopsis := 1;
	end if;
END