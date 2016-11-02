CREATE TABLE `terms_runs` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `media_rights_id` mediumint(11) unsigned DEFAULT NULL,
  `total_runs` int(11) DEFAULT NULL,
  `product_scope` varchar(20) DEFAULT NULL,
  `unlimited` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_terms_runs_terms_media_rights1_idx` (`media_rights_id`),
  CONSTRAINT `fk_terms_runs_terms_media_rights1` FOREIGN KEY (`media_rights_id`) REFERENCES `terms_media_rights` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8