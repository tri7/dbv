CREATE TABLE `paises` (
  `pais_id` mediumint(11) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(45) DEFAULT NULL,
  `pais_en` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`pais_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8