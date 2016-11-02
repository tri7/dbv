CREATE TABLE `slas_ingest` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `duracao` tinyint(4) DEFAULT NULL,
  `unidade` varchar(45) DEFAULT NULL,
  `is_preset` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8