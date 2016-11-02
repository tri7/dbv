CREATE TABLE `terms_media_rights_has_terms_packaging` (
  `terms_media_rights_id` mediumint(11) unsigned NOT NULL,
  `terms_packaging_id` mediumint(11) unsigned NOT NULL,
  PRIMARY KEY (`terms_media_rights_id`,`terms_packaging_id`),
  KEY `fk_terms_media_rights_has_terms_packaging_terms_packaging1_idx` (`terms_packaging_id`),
  CONSTRAINT `fk_terms_media_rights_has_terms_packaging_terms_media_rights1` FOREIGN KEY (`terms_media_rights_id`) REFERENCES `terms_media_rights` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_media_rights_has_terms_packaging_terms_packaging1` FOREIGN KEY (`terms_packaging_id`) REFERENCES `terms_packaging` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8