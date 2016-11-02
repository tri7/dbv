CREATE TABLE `tipos_de_wrapper` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) NOT NULL,
  `is_ficheiro` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8