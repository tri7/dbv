CREATE TABLE `dist_nao_linear_por_produto` (
  `produtos_id` int(10) unsigned NOT NULL,
  `cliente_id` mediumint(11) unsigned NOT NULL,
  `feedback` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`produtos_id`,`cliente_id`),
  KEY `fk_table1_produtos1_idx` (`produtos_id`),
  KEY `fk_table1_clientes_nao_linear_plataforma1_idx` (`cliente_id`),
  CONSTRAINT `fk_table1_clientes_nao_linear_plataforma1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes_nao_linear_plataforma` (`clientes_nao_linear_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_produtos1` FOREIGN KEY (`produtos_id`) REFERENCES `produtos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8