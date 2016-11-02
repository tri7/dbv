CREATE TABLE `tipos_de_produtos` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `tipo` varchar(100) DEFAULT NULL,
  `plataforma_id` mediumint(11) NOT NULL,
  `cod_identificativo` varchar(50) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tipos_de_produtos_plataformas1_idx` (`plataforma_id`),
  CONSTRAINT `fk_tipos_de_produtos_plataformas1` FOREIGN KEY (`plataforma_id`) REFERENCES `plataformas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8