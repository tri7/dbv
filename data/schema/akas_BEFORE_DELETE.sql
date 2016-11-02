CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`akas_BEFORE_DELETE`
BEFORE DELETE ON `cpm`.`akas`
FOR EACH ROW
BEGIN
set @service_akas := 0;
	if old.service = 1 then
        set @service_akas := 1;
	end if;
END