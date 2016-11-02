CREATE TABLE `metadados_obras_has_paises` (
  `metadados_obras_id` mediumint(11) NOT NULL,
  `paises_pais_id` mediumint(11) unsigned NOT NULL,
  `service` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Se tiver sido inserido/update por terms service = 1. ',
  PRIMARY KEY (`metadados_obras_id`,`paises_pais_id`),
  KEY `fk_metadados_obras_has_paises_paises1_idx` (`paises_pais_id`),
  KEY `fk_metadados_obras_has_paises_metadados_obras1_idx` (`metadados_obras_id`),
  CONSTRAINT `fk_metadados_obras_has_paises_metadados_obras1` FOREIGN KEY (`metadados_obras_id`) REFERENCES `metadados_obras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_metadados_obras_has_paises_paises1` FOREIGN KEY (`paises_pais_id`) REFERENCES `paises` (`pais_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Envia para terms. Campos definidos nos triggers'