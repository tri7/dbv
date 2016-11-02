CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`obras_has_artistas_BEFORE_INSERT`
BEFORE INSERT ON `cpm`.`obras_has_artistas`
FOR EACH ROW
begin
	set @service_ohartistas := 0;
	if new.service = 1 then
		set new.service := 0;
        set @service_ohartistas := 1;
	end if;
end