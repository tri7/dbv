CREATE TABLE `parentescos` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `tipo_de_parentesco` enum('pai','filho','irmao') NOT NULL,
  `asset_1_id` mediumint(11) NOT NULL,
  `asset_2_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_parentescos_assets1_idx` (`asset_1_id`),
  KEY `fk_parentescos_assets2_idx` (`asset_2_id`),
  CONSTRAINT `fk_parentescos_assets1` FOREIGN KEY (`asset_1_id`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parentescos_assets2` FOREIGN KEY (`asset_2_id`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8