CREATE TABLE `cond_comerciais` (
  `id` mediumint(11) unsigned NOT NULL AUTO_INCREMENT,
  `fornecedor_nao_linear_id` mediumint(11) NOT NULL,
  `tipos_de_produtos_id` tinyint(3) unsigned NOT NULL,
  `data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `nome_de_dado` varchar(45) DEFAULT NULL,
  `valor_de_dado` decimal(4,2) DEFAULT NULL,
  `tipo_de_campo` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`,`fornecedor_nao_linear_id`,`tipos_de_produtos_id`),
  KEY `fk_cond_comerciais_tipos_de_produtos1_idx` (`tipos_de_produtos_id`),
  KEY `fk_cond_comerciais_parceiros1_idx` (`fornecedor_nao_linear_id`),
  KEY `extrair_idx` (`tipos_de_produtos_id`,`data`),
  KEY `extrair2_idx` (`fornecedor_nao_linear_id`,`tipos_de_produtos_id`),
  CONSTRAINT `fk_cond_comerciais_parceiros1` FOREIGN KEY (`fornecedor_nao_linear_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cond_comerciais_tipos_de_produtos1` FOREIGN KEY (`tipos_de_produtos_id`) REFERENCES `tipos_de_produtos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8