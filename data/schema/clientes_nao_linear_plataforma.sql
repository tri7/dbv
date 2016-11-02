CREATE TABLE `clientes_nao_linear_plataforma` (
  `clientes_nao_linear_id` mediumint(11) unsigned NOT NULL,
  `plataformas_id` mediumint(11) NOT NULL,
  `feedback` tinyint(1) DEFAULT '0',
  `disabled` tinyint(1) DEFAULT '0',
  `req_cond_comerciais` tinyint(1) DEFAULT '0',
  `novidades` tinyint(1) unsigned NOT NULL DEFAULT '0',
  KEY `fk_clientes_nao_linear_plataforma_clientes_nao_linear1_idx` (`clientes_nao_linear_id`),
  KEY `fk_clientes_nao_linear_plataforma_plataformas1_idx` (`plataformas_id`),
  CONSTRAINT `fk_clientes_nao_linear_plataforma_clientes_nao_linear1` FOREIGN KEY (`clientes_nao_linear_id`) REFERENCES `clientes_nao_linear` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_nao_linear_plataforma_plataformas1` FOREIGN KEY (`plataformas_id`) REFERENCES `plataformas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8