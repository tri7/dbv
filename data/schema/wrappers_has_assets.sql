CREATE TABLE `wrappers_has_assets` (
  `wrapper_id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `asset_id` mediumint(11) NOT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`wrapper_id`,`asset_id`),
  KEY `fk_wrappers_has_assets_assets1_idx` (`asset_id`),
  KEY `fk_wrappers_has_assets_wrappers1_idx` (`wrapper_id`),
  CONSTRAINT `fk_wrappers_has_assets_assets1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_wrapper_id` FOREIGN KEY (`wrapper_id`) REFERENCES `wrappers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8