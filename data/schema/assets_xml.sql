CREATE TABLE `assets_xml` (
  `id` mediumint(11) unsigned NOT NULL AUTO_INCREMENT,
  `xmlobj` mediumtext NOT NULL,
  `pedido_rececao_id` mediumint(11) NOT NULL,
  `identificador` varchar(50) NOT NULL,
  `nome_identificador` varchar(45) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_assets_xml_pedido_rececao1_idx` (`pedido_rececao_id`),
  CONSTRAINT `fk_assets_xml_pedido_rececao1` FOREIGN KEY (`pedido_rececao_id`) REFERENCES `pedido_rececao` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8