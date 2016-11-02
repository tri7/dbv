CREATE TABLE `pedido_rececao_has_assets` (
  `pedido_rececao_id` mediumint(11) NOT NULL,
  `assets_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`pedido_rececao_id`,`assets_id`),
  KEY `fk_pedido_rececao_has_assets_assets1_idx` (`assets_id`),
  KEY `fk_pedido_rececao_has_assets_pedido_rececao1_idx` (`pedido_rececao_id`),
  CONSTRAINT `fk_pedido_rececao_has_assets_assets1` FOREIGN KEY (`assets_id`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedido_rececao_has_assets_pedido_rececao1` FOREIGN KEY (`pedido_rececao_id`) REFERENCES `pedido_rececao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8