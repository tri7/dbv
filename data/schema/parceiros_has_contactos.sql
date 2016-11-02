CREATE TABLE `parceiros_has_contactos` (
  `parceiro_id` mediumint(11) NOT NULL,
  `contacto_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`parceiro_id`,`contacto_id`),
  KEY `fk_intervenientes_has_contactos_contactos1_idx` (`contacto_id`),
  KEY `fk_intervenientes_has_contactos_intervenientes1_idx` (`parceiro_id`),
  CONSTRAINT `fk_intervenientes_has_contactos_contactos1` FOREIGN KEY (`contacto_id`) REFERENCES `contactos` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_parceiros_has_contactos_parceiros1` FOREIGN KEY (`parceiro_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8