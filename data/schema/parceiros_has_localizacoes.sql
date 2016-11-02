CREATE TABLE `parceiros_has_localizacoes` (
  `parceiro_id` mediumint(11) NOT NULL,
  `localizacoes_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`parceiro_id`,`localizacoes_id`),
  KEY `fk_parceiros_has_localizacoes_localizacoes1_idx` (`localizacoes_id`),
  KEY `fk_parceiros_has_localizacoes_parceiros1_idx` (`parceiro_id`),
  CONSTRAINT `fk_parceiros_has_localizacoes_localizacoes1` FOREIGN KEY (`localizacoes_id`) REFERENCES `localizacoes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parceiros_has_localizacoes_parceiros1` FOREIGN KEY (`parceiro_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8