CREATE TABLE `premieres` (
  `metadados_obras_id` mediumint(11) NOT NULL,
  `paises_pais_id` mediumint(11) unsigned NOT NULL,
  `plataformas_id` mediumint(11) NOT NULL,
  `date` datetime NOT NULL,
  `boxoffice` varchar(45) DEFAULT NULL,
  `moedas_id` mediumint(11) DEFAULT NULL,
  `service` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Se tiver sido inserido/update por terms service = 1. ',
  PRIMARY KEY (`metadados_obras_id`,`paises_pais_id`,`plataformas_id`,`date`),
  KEY `fk_obras_ocm_has_premieres_metadados_obras1_idx` (`metadados_obras_id`),
  KEY `fk_premieres_paises1_idx` (`paises_pais_id`),
  KEY `fk_premieres_plataformas1_idx` (`plataformas_id`),
  KEY `fk_premieres_moedas1_idx` (`moedas_id`),
  CONSTRAINT `fk_obras_ocm_has_premieres_metadados_obras1` FOREIGN KEY (`metadados_obras_id`) REFERENCES `metadados_obras` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_premieres_moedas1` FOREIGN KEY (`moedas_id`) REFERENCES `moedas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_premieres_paises1` FOREIGN KEY (`paises_pais_id`) REFERENCES `paises` (`pais_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_premieres_plataformas1` FOREIGN KEY (`plataformas_id`) REFERENCES `plataformas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Envia para terms. Campos definidos nos triggers'