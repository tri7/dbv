CREATE TABLE `wsaux_assets` (
  `id` mediumint(11) unsigned NOT NULL AUTO_INCREMENT,
  `num_asset` varchar(15) DEFAULT NULL,
  `table_name` varchar(45) NOT NULL,
  `row_id` mediumint(11) NOT NULL,
  `owner` varchar(45) DEFAULT NULL,
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `sent_date` datetime DEFAULT NULL,
  `error` varchar(45) DEFAULT NULL,
  `error_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `status_idx` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que sera utilizada para GMEDIA'