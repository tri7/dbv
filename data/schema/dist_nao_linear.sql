CREATE TABLE `dist_nao_linear` (
  `fornecedor_id` mediumint(11) NOT NULL,
  `cliente_id` mediumint(11) unsigned NOT NULL,
  `tipo_de_produto_id` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`fornecedor_id`,`cliente_id`,`tipo_de_produto_id`),
  KEY `fk_dist_nao_linear_tipos_de_produtos1_idx` (`tipo_de_produto_id`),
  KEY `fk_dist_nao_linear_clientes_nao_linear1_idx` (`cliente_id`),
  KEY `fk_dist_nao_linear_parceiros1_idx` (`fornecedor_id`),
  CONSTRAINT `fk_dist_nao_linear_clientes_nao_linear1` FOREIGN KEY (`cliente_id`) REFERENCES `clientes_nao_linear` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dist_nao_linear_parceiros1` FOREIGN KEY (`fornecedor_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_dist_nao_linear_tipos_de_produtos1` FOREIGN KEY (`tipo_de_produto_id`) REFERENCES `tipos_de_produtos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8