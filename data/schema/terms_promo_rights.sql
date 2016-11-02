CREATE TABLE `terms_promo_rights` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `promotions_id` mediumint(11) NOT NULL,
  `terms_direitos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_terms_promo_rights_promotions1_idx` (`promotions_id`),
  KEY `fk_terms_promo_rights_terms_direitos1_idx` (`terms_direitos_id`),
  CONSTRAINT `fk_terms_promo_rights_promotions1` FOREIGN KEY (`promotions_id`) REFERENCES `promotions` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_promo_rights_terms_direitos1` FOREIGN KEY (`terms_direitos_id`) REFERENCES `terms_direitos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8