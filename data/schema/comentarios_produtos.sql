CREATE TABLE `comentarios_produtos` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `produtos_id` int(10) unsigned NOT NULL,
  `parceiros_parceiro_id` mediumint(11) NOT NULL,
  `date` datetime NOT NULL,
  `comentario` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comentarios_produtos_parceiros1_idx` (`parceiros_parceiro_id`),
  KEY `fk_comentarios_produtos_produtos1_idx` (`produtos_id`),
  CONSTRAINT `fk_comentarios_produtos_parceiros1` FOREIGN KEY (`parceiros_parceiro_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentarios_produtos_produtos1` FOREIGN KEY (`produtos_id`) REFERENCES `produtos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8