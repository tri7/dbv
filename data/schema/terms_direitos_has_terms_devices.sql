CREATE TABLE `terms_direitos_has_terms_devices` (
  `terms_direitos_id` int(11) NOT NULL,
  `terms_devices_id` int(11) NOT NULL,
  PRIMARY KEY (`terms_direitos_id`,`terms_devices_id`),
  KEY `fk_terms_direitos_has_terms_devices_terms_devices1_idx` (`terms_devices_id`),
  KEY `fk_terms_direitos_has_terms_devices_terms_direitos1_idx` (`terms_direitos_id`),
  CONSTRAINT `fk_terms_direitos_has_terms_devices_terms_devices1` FOREIGN KEY (`terms_devices_id`) REFERENCES `terms_devices` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_terms_direitos_has_terms_devices_terms_direitos1` FOREIGN KEY (`terms_direitos_id`) REFERENCES `terms_direitos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8