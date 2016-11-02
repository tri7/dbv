CREATE TABLE `privilegios` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `modulos_id` mediumint(11) NOT NULL,
  `tabs_id` mediumint(11) NOT NULL,
  `read` tinyint(4) DEFAULT NULL,
  `write` tinyint(4) DEFAULT NULL,
  `update` tinyint(4) DEFAULT NULL,
  `delete` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_privilegios_modulos1_idx` (`modulos_id`),
  KEY `fk_privilegios_tabs1_idx` (`tabs_id`),
  CONSTRAINT `fk_privilegios_modulos1` FOREIGN KEY (`modulos_id`) REFERENCES `modulos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_privilegios_tabs1` FOREIGN KEY (`tabs_id`) REFERENCES `tabs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='r- só leitura\nrw pode ler e escrever\n-- sem acesso\n'