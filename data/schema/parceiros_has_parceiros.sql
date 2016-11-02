CREATE TABLE `parceiros_has_parceiros` (
  `parceiro_1_id` mediumint(11) NOT NULL,
  `parceiro_2_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`parceiro_1_id`,`parceiro_2_id`),
  KEY `fk_rel_entre_intervenientes_intervenientes1_idx` (`parceiro_1_id`),
  KEY `fk_rel_entre_intervenientes_intervenientes2_idx` (`parceiro_2_id`),
  CONSTRAINT `fk_parceiros_has_parceiros_parceiros1` FOREIGN KEY (`parceiro_1_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_parceiros_has_parceiros_parceiros2` FOREIGN KEY (`parceiro_2_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='como na tabela parceiros vamos ter empresas e pessoas, esta tabela serve para registar a relação entre empresas e pessoas'