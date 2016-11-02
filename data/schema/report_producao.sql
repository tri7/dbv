CREATE TABLE `report_producao` (
  `id_report` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(6) NOT NULL,
  `table_name` varchar(45) NOT NULL,
  `entity_table` varchar(45) NOT NULL,
  `entity_id` varchar(45) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_report`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8