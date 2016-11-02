CREATE TABLE `datas_de_exploracao` (
  `date_exp_in` datetime DEFAULT NULL,
  `date_exp_out` datetime DEFAULT NULL,
  `produto_id` int(10) unsigned NOT NULL,
  `early_window` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`produto_id`),
  KEY `fk_datas_produtos1_idx` (`produto_id`),
  KEY `in_idx` (`date_exp_in`),
  KEY `out_idx` (`date_exp_out`),
  CONSTRAINT `fk_datas_de_exploracao_produtos1` FOREIGN KEY (`produto_id`) REFERENCES `produtos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8