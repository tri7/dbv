CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`produtos_AFTER_DELETE` AFTER DELETE ON `produtos` FOR EACH ROW
BEGIN
UPDATE produtos_hist set statusprod = 'APAGADO' WHERE id = old.id and statusprod <> 'APAGADO';
END