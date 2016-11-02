CREATE TABLE `terms_edit_rights` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `terms_direitos_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_terms_edit_rights_terms_direitos1_idx` (`terms_direitos_id`),
  CONSTRAINT `fk_terms_edit_rights_terms_direitos1` FOREIGN KEY (`terms_direitos_id`) REFERENCES `terms_direitos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8