CREATE TABLE `tipos_de_parceiro` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) DEFAULT NULL,
  `tipo_empresa_id` mediumint(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tipos_de_parceiro_tipos_empresa1_idx` (`tipo_empresa_id`),
  CONSTRAINT `fk_tipos_de_parceiro_tipos_empresa1` FOREIGN KEY (`tipo_empresa_id`) REFERENCES `tipos_empresa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8