CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`obras_has_genres_BEFORE_INSERT`
BEFORE INSERT ON `cpm`.`obras_has_genres`
FOR EACH ROW
begin
	set @service_ohgenres := 0;
    set @genero_old := (select group_concat(distinct g.genero order by g.genero asc separator ';') from generos g 
        join obras_has_genres ohg on ohg.genre_id = g.id
        where ohg.metadados_obras_id = new.metadados_obras_id group by ohg.metadados_obras_id);
	if new.service = 1 then
		set new.service := 0;
        set @service_ohgenres := 1;
	end if;
end