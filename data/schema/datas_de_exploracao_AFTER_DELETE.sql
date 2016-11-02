CREATE DEFINER=`root`@`localhost` TRIGGER `cpm`.`datas_de_exploracao_AFTER_DELETE` AFTER DELETE ON `datas_de_exploracao` FOR EACH ROW
BEGIN
UPDATE datas_de_exploracao_hist set statusprod = 'APAGADO' WHERE produto_id = old.produto_id and statusprod <> 'APAGADO';
END