CREATE TABLE `obras_has_artistas` (
  `metadados_obras_id` mediumint(11) NOT NULL,
  `artista_id` mediumint(11) NOT NULL,
  `funcao_id` mediumint(11) NOT NULL,
  `service` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Se tiver sido inserido/update por terms service = 1. ',
  PRIMARY KEY (`metadados_obras_id`,`artista_id`,`funcao_id`),
  KEY `fk_obras_has_intervenientes_intervenientes1_idx` (`artista_id`),
  KEY `fk_obras_has_intervenientes_obras1_idx` (`metadados_obras_id`),
  KEY `fk_obras_has_intervenientes_tipos_de_intervenientes1_idx` (`funcao_id`),
  KEY `mdo_func_idx` (`metadados_obras_id`,`funcao_id`),
  CONSTRAINT `fk_obras_has_intervenientes_intervenientes1` FOREIGN KEY (`artista_id`) REFERENCES `artistas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_obras_has_intervenientes_obras1` FOREIGN KEY (`metadados_obras_id`) REFERENCES `metadados_obras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_obras_has_intervenientes_tipos_de_intervenientes1` FOREIGN KEY (`funcao_id`) REFERENCES `funcoes_de_artista` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Envia para terms. Campos definidos nos triggers'