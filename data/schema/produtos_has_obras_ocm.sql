CREATE TABLE `produtos_has_obras_ocm` (
  `produtos_id` int(10) unsigned NOT NULL,
  `obras_ocm_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`produtos_id`,`obras_ocm_id`),
  KEY `fk_produtos_has_obras_ocm_obras_ocm1_idx` (`obras_ocm_id`),
  KEY `fk_produtos_has_obras_ocm_produtos1_idx` (`produtos_id`),
  CONSTRAINT `fk_produtos_has_obras_ocm_obras_ocm1` FOREIGN KEY (`obras_ocm_id`) REFERENCES `obras_ocm` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_produtos_has_obras_ocm_produtos1` FOREIGN KEY (`produtos_id`) REFERENCES `produtos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8