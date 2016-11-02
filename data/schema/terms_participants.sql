CREATE TABLE `terms_participants` (
  `terms_contratos_id` int(11) NOT NULL,
  `parceiros_parceiro_id` mediumint(11) NOT NULL,
  `terms_participants_types_id` mediumint(11) NOT NULL,
  KEY `fk_terms_participants_parceiros1_idx` (`parceiros_parceiro_id`),
  KEY `fk_terms_participants_terms_participants_types1_idx` (`terms_participants_types_id`),
  KEY `fk_terms_participants_terms_contratos1_idx` (`terms_contratos_id`),
  CONSTRAINT `fk_terms_participants_parceiros1` FOREIGN KEY (`parceiros_parceiro_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_participants_terms_contratos1` FOREIGN KEY (`terms_contratos_id`) REFERENCES `terms_contratos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_participants_terms_participants_types1` FOREIGN KEY (`terms_participants_types_id`) REFERENCES `terms_participants_types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8