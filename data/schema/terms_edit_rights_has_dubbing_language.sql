CREATE TABLE `terms_edit_rights_has_dubbing_language` (
  `terms_edit_rights_id` mediumint(11) NOT NULL,
  `idiomas_id` mediumint(10) unsigned NOT NULL,
  PRIMARY KEY (`terms_edit_rights_id`,`idiomas_id`),
  KEY `fk_terms_edit_rights_has_idiomas1_idiomas1_idx` (`idiomas_id`),
  KEY `fk_terms_edit_rights_has_idiomas1_terms_edit_rights1_idx` (`terms_edit_rights_id`),
  CONSTRAINT `fk_terms_edit_rights_has_idiomas1_idiomas1` FOREIGN KEY (`idiomas_id`) REFERENCES `idiomas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_edit_rights_has_idiomas1_terms_edit_rights1` FOREIGN KEY (`terms_edit_rights_id`) REFERENCES `terms_edit_rights` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8