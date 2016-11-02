CREATE TABLE `legendas` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `asset_id` mediumint(11) NOT NULL,
  `filename` varchar(256) DEFAULT NULL,
  `enviado` varchar(45) DEFAULT NULL,
  `film_speed_id` mediumint(11) DEFAULT NULL,
  `idiomas_id` mediumint(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_legendas_assets1_idx` (`asset_id`),
  KEY `fk_legendas_frame_rates1_idx` (`film_speed_id`),
  KEY `fk_legendas_idiomas1.idx` (`idiomas_id`),
  KEY `filename_legs_idx` (`filename`(100)),
  CONSTRAINT `fk_legendas_assets1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_legendas_frame_rates1` FOREIGN KEY (`film_speed_id`) REFERENCES `frame_rates` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_legendas_idiomas1` FOREIGN KEY (`idiomas_id`) REFERENCES `idiomas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8