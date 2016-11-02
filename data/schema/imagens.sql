CREATE TABLE `imagens` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `asset_id` mediumint(11) NOT NULL,
  `height` mediumint(11) DEFAULT NULL,
  `width` mediumint(11) DEFAULT NULL,
  `formato_de_imagem_id` mediumint(11) NOT NULL,
  `filename` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_imagens_assets1_idx` (`asset_id`),
  KEY `fk_imagens_image_formats1_idx` (`formato_de_imagem_id`),
  KEY `filename_imgs_idx` (`filename`(100)),
  CONSTRAINT `fk_imagens_assets1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_imagens_image_formats1` FOREIGN KEY (`formato_de_imagem_id`) REFERENCES `formatos_de_imagem` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8