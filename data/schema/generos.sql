CREATE TABLE `generos` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `genero` varchar(45) NOT NULL,
  `genero_en` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gen_idx` (`genero`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8