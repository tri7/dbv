CREATE TABLE `package_has_obras` (
  `package_id` mediumint(11) NOT NULL,
  `child_id` mediumint(11) NOT NULL,
  `feepercentage` double NOT NULL DEFAULT '0',
  `quantity` mediumint(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`child_id`,`package_id`),
  KEY `fk_obras_ocm_has_obras_ocm_obras_ocm2_idx` (`child_id`),
  KEY `fk_obras_ocm_has_obras_ocm_obras_ocm1_idx` (`package_id`),
  CONSTRAINT `fk_obras_ocm_has_obras_ocm_obras_ocm1` FOREIGN KEY (`package_id`) REFERENCES `obras_ocm` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_obras_ocm_has_obras_ocm_obras_ocm2` FOREIGN KEY (`child_id`) REFERENCES `obras_ocm` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8