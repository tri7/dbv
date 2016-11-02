CREATE TABLE `premios` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `premio` varchar(500) NOT NULL,
  `metadados_obras_id` mediumint(11) NOT NULL,
  `num_de_nomiacoes` tinyint(2) DEFAULT NULL,
  `num_de_premio` tinyint(2) DEFAULT NULL,
  `service` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Se tiver sido inserido/update por terms service = 1. ',
  PRIMARY KEY (`id`),
  KEY `fk_premios_metadados_obras1_idx` (`metadados_obras_id`),
  CONSTRAINT `fk_premios_metadados_obras1` FOREIGN KEY (`metadados_obras_id`) REFERENCES `metadados_obras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Envia para terms. Campos definidos nos triggers'