CREATE TABLE `distribuicao` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `ot_nodes_id` mediumint(8) unsigned NOT NULL,
  `num_de_material` varchar(45) DEFAULT NULL,
  `transcodificacao` varchar(45) DEFAULT NULL,
  `nome_a_entregar` varchar(45) DEFAULT NULL,
  `local_a_entregar` varchar(45) DEFAULT NULL,
  `observacao` text,
  PRIMARY KEY (`id`),
  KEY `fk_distribuicao_ot_nodes1_idx` (`ot_nodes_id`),
  CONSTRAINT `fk_distribuicao_ot_nodes1` FOREIGN KEY (`ot_nodes_id`) REFERENCES `ot_nodes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8