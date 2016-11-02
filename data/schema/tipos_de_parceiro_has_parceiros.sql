CREATE TABLE `tipos_de_parceiro_has_parceiros` (
  `tipo_de_parceiro_id` mediumint(11) NOT NULL,
  `parceiro_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`tipo_de_parceiro_id`,`parceiro_id`),
  KEY `fk_tipos_de_parceiro_has_parceiros_tipos_de_parceiro1_idx` (`tipo_de_parceiro_id`),
  KEY `fk_tipos_de_parceiro_has_parceiros_parceiros1_idx` (`parceiro_id`),
  CONSTRAINT `fk_tipos_de_parceiro_has_parceiros_parceiros1` FOREIGN KEY (`parceiro_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipos_de_parceiro_has_parceiros_tipos_de_parceiro1` FOREIGN KEY (`tipo_de_parceiro_id`) REFERENCES `tipos_de_parceiro` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8