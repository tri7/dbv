CREATE TABLE `tipos_de_conteudos` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT COMMENT 'trailer\nfilme\n',
  `tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tipo_idx` (`tipo`(20))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='trailer\nfilme\nmaking of\nentrevistas\ncapa\nartwork\nscript\n\n'