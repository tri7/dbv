CREATE TABLE `qc_visual_sem_ft` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `ot_nodes_id` mediumint(8) unsigned NOT NULL,
  `num_de_material` varchar(45) DEFAULT NULL,
  `tipo_de_qc` varchar(45) DEFAULT NULL,
  `observacao` text,
  PRIMARY KEY (`id`),
  KEY `fk_qc_visual_sem_ft_ot_nodes1_idx` (`ot_nodes_id`),
  CONSTRAINT `fk_qc_visual_sem_ft_ot_nodes1` FOREIGN KEY (`ot_nodes_id`) REFERENCES `ot_nodes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8