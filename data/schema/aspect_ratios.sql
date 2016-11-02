CREATE TABLE `aspect_ratios` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `aspect_ratio` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que guarda todos aspect ratios.\nDeve ser populada por default.\n2,35 (35mm)\n1,85\n1,77 (HD)\n1,33 (SD)'