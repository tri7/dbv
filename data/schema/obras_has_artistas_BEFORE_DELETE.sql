CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`obras_has_artistas_BEFORE_DELETE`
BEFORE DELETE ON `cpm`.`obras_has_artistas`
FOR EACH ROW
BEGIN
set @service_ohartistas := 0;
	if old.service = 1 then 
        set @service_ohartistas := 1;
    end if;
END