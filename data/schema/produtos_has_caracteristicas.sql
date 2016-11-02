CREATE TABLE `produtos_has_caracteristicas` (
  `produto_id` int(10) unsigned NOT NULL,
  `caracteristica_id` mediumint(11) unsigned NOT NULL,
  `valor` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`produto_id`,`caracteristica_id`),
  KEY `fk_caracteristicas_de_produtos_has_produtos_produtos1_idx` (`produto_id`),
  KEY `fk_caracteristicas_de_produtos_has_produtos_caracteristicas_idx` (`caracteristica_id`),
  CONSTRAINT `fk_caracteristicas_de_produtos_has_produtos_caracteristicas_d1` FOREIGN KEY (`caracteristica_id`) REFERENCES `dados_de_negocio_da_plataforma` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_caracteristicas_de_produtos_has_produtos_produtos1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8