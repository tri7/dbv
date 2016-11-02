CREATE TABLE `terms_media_rights_has_plataformas` (
  `media_rights_id` mediumint(11) unsigned NOT NULL,
  `plataformas_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`media_rights_id`,`plataformas_id`),
  KEY `fk_media_rights_has_plataformas_plataformas1_idx` (`plataformas_id`),
  CONSTRAINT `fk_media_rights_has_plataformas_plataformas1` FOREIGN KEY (`plataformas_id`) REFERENCES `plataformas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_media_rights_has_plataformas_terms_media_rights1` FOREIGN KEY (`media_rights_id`) REFERENCES `terms_media_rights` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8