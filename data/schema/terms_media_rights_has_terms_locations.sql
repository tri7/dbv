CREATE TABLE `terms_media_rights_has_terms_locations` (
  `terms_media_rights_id` mediumint(11) unsigned NOT NULL,
  `terms_locations_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`terms_media_rights_id`,`terms_locations_id`),
  KEY `fk_terms_media_rights_has_terms_locations_terms_locations1_idx` (`terms_locations_id`),
  CONSTRAINT `fk_terms_media_rights_has_terms_locations_terms_locations1` FOREIGN KEY (`terms_locations_id`) REFERENCES `terms_locations` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_media_rights_has_terms_locations_terms_media_rights1` FOREIGN KEY (`terms_media_rights_id`) REFERENCES `terms_media_rights` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8