CREATE TABLE `terms_media_rights_has_mediums` (
  `terms_media_rights_id` mediumint(11) unsigned NOT NULL,
  `mediums_id` mediumint(11) unsigned NOT NULL,
  PRIMARY KEY (`terms_media_rights_id`,`mediums_id`),
  KEY `fk_terms_media_rights_has_mediums_mediums1_idx` (`mediums_id`),
  CONSTRAINT `fk_terms_media_rights_has_mediums_mediums1` FOREIGN KEY (`mediums_id`) REFERENCES `terms_mediums` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_media_rights_has_mediums_terms_media_rights1` FOREIGN KEY (`terms_media_rights_id`) REFERENCES `terms_media_rights` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8