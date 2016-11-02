CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`obras_has_genres_BEFORE_DELETE`
BEFORE DELETE ON `cpm`.`obras_has_genres`
FOR EACH ROW
BEGIN

set @service_ohgenres := 0;
set @genres_old := (select group_concat(distinct g.genero order by g.genero asc separator ';') from generos g 
        join obras_has_genres ohg on ohg.genre_id = g.id
        where ohg.metadados_obras_id = old.metadados_obras_id 
        group by ohg.metadados_obras_id);
	if old.service = 1 then 
        set @service_ohgenres := 1;
    end if;

END