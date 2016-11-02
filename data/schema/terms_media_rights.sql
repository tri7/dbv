CREATE TABLE `terms_media_rights` (
  `id` mediumint(11) unsigned NOT NULL AUTO_INCREMENT,
  `term_from` date DEFAULT NULL,
  `term_to` date DEFAULT NULL,
  `terms_direitos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_terms_media_rights_terms_direitos1_idx` (`terms_direitos_id`),
  KEY `terms_from_to_idx` (`term_from`),
  CONSTRAINT `fk_terms_media_rights_terms_direitos1` FOREIGN KEY (`terms_direitos_id`) REFERENCES `terms_direitos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8