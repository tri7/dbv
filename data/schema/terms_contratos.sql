CREATE TABLE `terms_contratos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `alternate_id` varchar(50) DEFAULT NULL,
  `nome` varchar(150) DEFAULT NULL,
  `executed_date` datetime DEFAULT NULL,
  `contratos_terms_status_id` mediumint(11) DEFAULT NULL,
  `terms_groups_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_contratos_terms_contratos_terms_status1_idx` (`contratos_terms_status_id`),
  KEY `fk_terms_contratos_terms_groups1_idx` (`terms_groups_id`),
  CONSTRAINT `fk_contratos_terms_contratos_terms_status1` FOREIGN KEY (`contratos_terms_status_id`) REFERENCES `terms_contratos_status` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_contratos_terms_groups1` FOREIGN KEY (`terms_groups_id`) REFERENCES `terms_groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8