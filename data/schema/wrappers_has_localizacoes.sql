CREATE TABLE `wrappers_has_localizacoes` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `wrapper_id` mediumint(11) NOT NULL,
  `responsavel_id` mediumint(11) DEFAULT NULL,
  `data_in` datetime DEFAULT NULL,
  `data_out` datetime DEFAULT NULL,
  `canal_de_entrega` varchar(45) DEFAULT NULL,
  `localizacao_id` mediumint(11) DEFAULT NULL,
  `guia_de_transporte` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_wrappers_has_localizacoes_localizacoes1_idx` (`localizacao_id`),
  KEY `fk_responsavel_id1_idx` (`responsavel_id`),
  KEY `fk_wrapper_id1_idx` (`wrapper_id`),
  CONSTRAINT `fk_wrappers_has_localizacoes_localizacoes1` FOREIGN KEY (`localizacao_id`) REFERENCES `localizacoes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_wrappers_has_localizacoes_parceiros1` FOREIGN KEY (`responsavel_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_wrapper_id1` FOREIGN KEY (`wrapper_id`) REFERENCES `wrappers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8