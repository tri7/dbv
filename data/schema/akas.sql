CREATE TABLE `akas` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `obras_obra_id` mediumint(11) NOT NULL,
  `aka` varchar(250) DEFAULT NULL,
  `paises_pais_id` mediumint(11) unsigned NOT NULL,
  `service` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Se tiver sido inserido/update por terms service = 1. ',
  PRIMARY KEY (`id`),
  KEY `fk_akas_obras1_idx` (`obras_obra_id`),
  KEY `aka` (`aka`),
  KEY `aka_2` (`aka`),
  KEY `fk_akas_paises1_idx` (`paises_pais_id`),
  CONSTRAINT `fk_akas_obras1` FOREIGN KEY (`obras_obra_id`) REFERENCES `obras_ocm` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_akas_paises1` FOREIGN KEY (`paises_pais_id`) REFERENCES `paises` (`pais_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Envia para terms. Campos definidos nos triggers'