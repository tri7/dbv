CREATE TABLE `external_owners` (
  `obras_ocm_id` mediumint(11) NOT NULL,
  `terms_groups_id` mediumint(11) NOT NULL,
  `internal_id` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`obras_ocm_id`,`terms_groups_id`),
  KEY `fk_owners_obras_ocm1_idx` (`obras_ocm_id`),
  KEY `fk_owners_terms_groups1_idx` (`terms_groups_id`),
  CONSTRAINT `fk_owners_obras_ocm1` FOREIGN KEY (`obras_ocm_id`) REFERENCES `obras_ocm` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_owners_terms_groups1` FOREIGN KEY (`terms_groups_id`) REFERENCES `terms_groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela usada pelo GMEDIA. ACTUALIZAR COM NOME DO SERVICO!'