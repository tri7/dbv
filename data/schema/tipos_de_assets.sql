CREATE TABLE `tipos_de_assets` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT COMMENT 'video\naudio\nlegendas',
  `tipo` varchar(45) DEFAULT NULL,
  `metadados` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='video \ncapa \nlegendas \nsom\n'