CREATE TABLE `terms_direitos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `terms_contratos_id` int(11) NOT NULL,
  `obras_ocm_id` mediumint(11) NOT NULL,
  `tipo_de_direito` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_terms_direitos_terms_contratos1_idx` (`terms_contratos_id`),
  KEY `fk_terms_direitos_obras_ocm1_idx` (`obras_ocm_id`),
  CONSTRAINT `fk_terms_direitos_obras_ocm1` FOREIGN KEY (`obras_ocm_id`) REFERENCES `obras_ocm` (`terms_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_direitos_terms_contratos1` FOREIGN KEY (`terms_contratos_id`) REFERENCES `terms_contratos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8