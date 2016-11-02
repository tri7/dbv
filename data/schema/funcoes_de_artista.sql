CREATE TABLE `funcoes_de_artista` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `funcao_de_artista` varchar(45) DEFAULT NULL COMMENT 'realizador\nprodutor\nactor\nargumentista\n',
  `funcao_de_artista_en` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `funcao_art_idx` (`funcao_de_artista`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8