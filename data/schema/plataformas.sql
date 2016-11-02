CREATE TABLE `plataformas` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `plataforma` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plat_idx` (`plataforma`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8