CREATE TABLE `terms_direitos_has_idiomas` (
  `terms_direitos_id` int(11) NOT NULL,
  `idiomas_id` mediumint(10) unsigned NOT NULL,
  PRIMARY KEY (`terms_direitos_id`,`idiomas_id`),
  KEY `fk_terms_direitos_has_idiomas_idiomas1_idx` (`idiomas_id`),
  KEY `fk_terms_direitos_has_idiomas_terms_direitos1_idx` (`terms_direitos_id`),
  CONSTRAINT `fk_terms_direitos_has_idiomas_idiomas1` FOREIGN KEY (`idiomas_id`) REFERENCES `idiomas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_direitos_has_idiomas_terms_direitos1` FOREIGN KEY (`terms_direitos_id`) REFERENCES `terms_direitos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8