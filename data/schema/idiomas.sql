CREATE TABLE `idiomas` (
  `id` mediumint(10) unsigned NOT NULL AUTO_INCREMENT,
  `idioma` varchar(45) DEFAULT NULL,
  `idioma_en` varchar(45) DEFAULT NULL COMMENT '\n',
  PRIMARY KEY (`id`),
  KEY `idioma_idx` (`idioma`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8