CREATE TABLE `ot_tipo` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `machine_name` varchar(45) NOT NULL,
  `machine_avgt` smallint(5) unsigned DEFAULT NULL,
  `human_name` varchar(45) NOT NULL,
  `human_avgt` smallint(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_ot_tipo_crs1_idx` (`human_name`),
  CONSTRAINT `fk_ot_tipo_crs1` FOREIGN KEY (`human_name`) REFERENCES `crs` (`name`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8