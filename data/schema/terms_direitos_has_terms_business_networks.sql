CREATE TABLE `terms_direitos_has_terms_business_networks` (
  `terms_direitos_id` int(11) NOT NULL,
  `terms_business_networks_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`terms_direitos_id`,`terms_business_networks_id`),
  KEY `fk_terms_direitos_has_terms_business_networks_terms_busines_idx` (`terms_business_networks_id`),
  KEY `fk_terms_direitos_has_terms_business_networks_terms_direito_idx` (`terms_direitos_id`),
  CONSTRAINT `fk_terms_direitos_has_terms_business_networks_terms_business_1` FOREIGN KEY (`terms_business_networks_id`) REFERENCES `terms_business_networks` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_direitos_has_terms_business_networks_terms_direitos1` FOREIGN KEY (`terms_direitos_id`) REFERENCES `terms_direitos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8