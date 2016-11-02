CREATE TABLE `obras_has_genres` (
  `metadados_obras_id` mediumint(11) NOT NULL,
  `genre_id` mediumint(11) NOT NULL,
  `service` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Se tiver sido inserido/update por terms service = 1. ',
  PRIMARY KEY (`metadados_obras_id`,`genre_id`),
  KEY `fk_obras_has_generos_generos1_idx` (`genre_id`),
  KEY `fk_obras_has_generos_obras1_idx` (`metadados_obras_id`),
  CONSTRAINT `fk_obras_has_generos_generos1` FOREIGN KEY (`genre_id`) REFERENCES `generos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_obras_has_generos_obras1` FOREIGN KEY (`metadados_obras_id`) REFERENCES `metadados_obras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Envia para terms. Campos definidos nos triggers'