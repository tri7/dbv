CREATE TABLE `ots_has_assets` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `ots_id` mediumint(11) NOT NULL,
  `num_de_material` varchar(12) DEFAULT NULL,
  `metadata` text COMMENT 'Campo onde se guarda toda e qualquer informação relacionada com o asset a ser trabalhado numa ot. Em geral mais utilizado para materais que não estão registados em sistema.\n',
  PRIMARY KEY (`id`),
  KEY `fk_ots_has_assets_ots1_idx` (`ots_id`),
  KEY `fk_ots_has_assets_assets1_idx` (`num_de_material`),
  CONSTRAINT `fk_ots_has_assets_ots1` FOREIGN KEY (`ots_id`) REFERENCES `ots` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que guarda os materiais iniciais a serem trabalhados pela ot\n'