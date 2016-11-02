CREATE TABLE `metadados_obras_has_idiomas` (
  `metadados_obras_id` mediumint(11) NOT NULL,
  `idiomas_id` mediumint(10) unsigned NOT NULL,
  `service` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Se tiver sido inserido/update por terms service = 1. ',
  PRIMARY KEY (`metadados_obras_id`,`idiomas_id`),
  KEY `fk_metadados_obras_has_idiomas_idiomas1_idx` (`idiomas_id`),
  KEY `fk_metadados_obras_has_idiomas_metadados_obras1_idx` (`metadados_obras_id`),
  CONSTRAINT `fk_metadados_obras_has_idiomas_idiomas1` FOREIGN KEY (`idiomas_id`) REFERENCES `idiomas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadados_obras_has_idiomas_metadados_obras1` FOREIGN KEY (`metadados_obras_id`) REFERENCES `metadados_obras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Envia para terms. Campos definidos nos triggers'