CREATE TABLE `registo_noutra_plataforma` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `ot_nodes_id` mediumint(8) unsigned NOT NULL,
  `num_material` varchar(45) DEFAULT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `observacao` text,
  PRIMARY KEY (`id`),
  KEY `fk_registo_noutra_plataforma_ot_nodes1_idx` (`ot_nodes_id`),
  CONSTRAINT `fk_registo_noutra_plataforma_ot_nodes1` FOREIGN KEY (`ot_nodes_id`) REFERENCES `ot_nodes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8