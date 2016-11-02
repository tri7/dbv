CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`synopsis_AFTER_UPDATE`
AFTER UPDATE ON `cpm`.`synopsis`
FOR EACH ROW
BEGIN
declare productId varchar(45);
declare new_fields varchar(250);
declare old_fields varchar(250);
declare new_fieldsid varchar(45);
declare mdoid mediumint(11);
declare done boolean default false;


DECLARE cur1 CURSOR FOR SELECT DISTINCT metadados_obras_id FROM metadados_obras_has_synopsis as mdohs where mdohs.synopsis_id = new.id;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done := TRUE;

OPEN cur1;

read_loop: LOOP
  
FETCH cur1 INTO mdoid;

IF done THEN
	LEAVE read_loop;
END IF;

	set productId = (select ifnull(terms_id,0) from obras_ocm where metadados_individual_id = mdoid);

	set new_fields := concat_ws(' ### ',new.synopsis_short, new.synopsis_long);
    
    set old_fields := concat_ws(' ### ',old.synopsis_short, old.synopsis_long);
		
	set new_fieldsid := new.id;

	insert into wsaux set row_id = new_fieldsid, table_name = 'synopsis', 
				oldfields = old_fields, newfields = new_fields, termsid = productId, method = 'PUT', trigger_com = 'UPDATE';


END LOOP read_loop;


CLOSE cur1;

END