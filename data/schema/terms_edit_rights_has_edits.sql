CREATE TABLE `terms_edit_rights_has_edits` (
  `terms_edit_rights_id` mediumint(11) NOT NULL,
  `edits_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`terms_edit_rights_id`,`edits_id`),
  KEY `fk_terms_edit_rights_has_edits_edits1_idx` (`edits_id`),
  KEY `fk_terms_edit_rights_has_edits_terms_edit_rights1_idx` (`terms_edit_rights_id`),
  CONSTRAINT `fk_terms_edit_rights_has_edits_edits1` FOREIGN KEY (`edits_id`) REFERENCES `edits` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_edit_rights_has_edits_terms_edit_rights1` FOREIGN KEY (`terms_edit_rights_id`) REFERENCES `terms_edit_rights` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8