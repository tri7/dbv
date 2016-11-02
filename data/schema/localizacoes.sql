CREATE TABLE `localizacoes` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `localizacao` varchar(30) DEFAULT NULL,
  `morada` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8