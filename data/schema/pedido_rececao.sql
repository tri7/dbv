CREATE TABLE `pedido_rececao` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `criado_em` datetime DEFAULT NULL,
  `data_de_rececao` datetime DEFAULT NULL,
  `distribuidor_id` mediumint(11) DEFAULT NULL,
  `quem_fez` mediumint(11) NOT NULL,
  `tipos_de_conteudos_id` mediumint(11) NOT NULL,
  `plataforma_id` mediumint(11) NOT NULL,
  `obras_ocm_id` mediumint(11) NOT NULL,
  `recebido_por` mediumint(11) DEFAULT NULL,
  `batton` tinyint(1) DEFAULT NULL,
  `status` enum('-1','0','1','2') DEFAULT NULL,
  `ot_nodes_id` mediumint(8) unsigned DEFAULT NULL COMMENT 'Identifica o node, se for o caso, responsável pela criação do asset',
  PRIMARY KEY (`id`),
  KEY `fk_encomendas_parceiros1_idx` (`distribuidor_id`),
  KEY `fk_pedido_rececao_tipos_de_conteudos1_idx` (`tipos_de_conteudos_id`),
  KEY `fk_pedido_rececao_plataformas_has_sub_plataforma1_idx` (`plataforma_id`),
  KEY `fk_pedido_rececao_obras_ocm1_idx` (`obras_ocm_id`),
  KEY `fk_pedido_rececao_recebido_por_idx` (`recebido_por`),
  KEY `fk_pedido_rececao_parceiros1_idx` (`quem_fez`),
  KEY `fk_pedido_rececao_ot_nodes1_idx` (`ot_nodes_id`),
  CONSTRAINT `fk_pedido_rececao_obras_ocm1` FOREIGN KEY (`obras_ocm_id`) REFERENCES `obras_ocm` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_rececao_ot_nodes1` FOREIGN KEY (`ot_nodes_id`) REFERENCES `ot_nodes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_rececao_parceiros1` FOREIGN KEY (`quem_fez`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_rececao_parceiros2` FOREIGN KEY (`distribuidor_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_rececao_plataformas_has_sub_plataforma1` FOREIGN KEY (`plataforma_id`) REFERENCES `plataformas_has_sub_plataforma` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_rececao_tipos_de_conteudos1` FOREIGN KEY (`tipos_de_conteudos_id`) REFERENCES `tipos_de_conteudos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8