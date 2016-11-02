CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`assets_BEFORE_DELETE`
BEFORE DELETE ON `cpm`.`assets`
FOR EACH ROW
BEGIN
set @service_assets := 0;
if old.service = 1 then
        set @service_assets := 1;
	end if;
END