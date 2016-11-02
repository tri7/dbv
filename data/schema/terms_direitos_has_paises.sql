CREATE TABLE `terms_direitos_has_paises` (
  `terms_direitos_id` int(11) NOT NULL,
  `paises_pais_id` mediumint(11) unsigned NOT NULL,
  PRIMARY KEY (`terms_direitos_id`,`paises_pais_id`),
  KEY `fk_terms_direitos_has_paises_paises1_idx` (`paises_pais_id`),
  KEY `fk_terms_direitos_has_paises_terms_direitos1_idx` (`terms_direitos_id`),
  CONSTRAINT `fk_terms_direitos_has_paises_paises1` FOREIGN KEY (`paises_pais_id`) REFERENCES `paises` (`pais_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_direitos_has_paises_terms_direitos1` FOREIGN KEY (`terms_direitos_id`) REFERENCES `terms_direitos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8