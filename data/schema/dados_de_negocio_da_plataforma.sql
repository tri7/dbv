CREATE TABLE `dados_de_negocio_da_plataforma` (
  `id` mediumint(11) unsigned NOT NULL AUTO_INCREMENT,
  `plataforma_id` mediumint(11) DEFAULT NULL,
  `dado_de_negocio` varchar(100) DEFAULT NULL,
  `tipo_de_dado` enum('VARCHAR','BOOLEAN') DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_caracteristicas_de_produtos_plataformas1_idx` (`plataforma_id`),
  CONSTRAINT `fk_caracteristicas_de_produtos_plataformas1` FOREIGN KEY (`plataforma_id`) REFERENCES `plataformas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8