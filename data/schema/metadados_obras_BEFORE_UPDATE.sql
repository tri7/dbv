CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`metadados_obras_BEFORE_UPDATE`
BEFORE UPDATE ON `cpm`.`metadados_obras`
FOR EACH ROW
begin

declare titpt tinyint(1) default 0;
declare imdblink tinyint(1) default 0;
declare classet tinyint(1) default 0;

set @service_meta := 0;
	set titpt := (select (new.titulo_pt is not null and old.titulo_pt is null) 
	or (new.titulo_pt is null and old.titulo_pt is not null)
	or (new.titulo_pt is not null and old.titulo_pt is not null and old.titulo_pt <> new.titulo_pt));

	set imdblink := (select (new.imdb_link is not null and old.imdb_link is null) 
	or (new.imdb_link is null and old.imdb_link is not null)
	or (new.imdb_link is not null and old.imdb_link is not null and old.imdb_link <> new.imdb_link));

	set classet := (select (new.classificacao_etaria_id is not null and old.classificacao_etaria_id is null) 
	or (new.classificacao_etaria_id is null and old.classificacao_etaria_id is not null)
	or (new.classificacao_etaria_id is not null and old.classificacao_etaria_id is not null 
    and old.classificacao_etaria_id <> new.classificacao_etaria_id));
    
	if new.service = 1 or (titpt = 0 and imdblink = 0 and classet = 0) then 
		set new.service := 0;
        set @service_meta := 1;
    end if;
end