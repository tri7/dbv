CREATE TABLE `faturacao` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `ot_nodes_id` mediumint(8) unsigned NOT NULL,
  `observacao` text,
  PRIMARY KEY (`id`),
  KEY `fk_faturacao_ot_nodes1_idx` (`ot_nodes_id`),
  CONSTRAINT `fk_faturacao_ot_nodes1` FOREIGN KEY (`ot_nodes_id`) REFERENCES `ot_nodes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8