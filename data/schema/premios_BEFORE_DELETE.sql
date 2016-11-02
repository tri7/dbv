CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`premios_BEFORE_DELETE`
BEFORE DELETE ON `cpm`.`premios`
FOR EACH ROW
BEGIN
set @service_awards := 0;
	if old.service = 1 then
        set @service_awards := 1;
	end if;
END