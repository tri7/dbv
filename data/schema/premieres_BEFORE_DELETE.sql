CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`premieres_BEFORE_DELETE`
BEFORE DELETE ON `cpm`.`premieres`
FOR EACH ROW
BEGIN
set @service_prems := 0;
	if old.service = 1 then
        set @service_prems := 1;
	end if;
END