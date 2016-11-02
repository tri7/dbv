CREATE TABLE `wrappers_has_contratos` (
  `wrapper_id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `contrato_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`wrapper_id`,`contrato_id`),
  KEY `fk_wrappers_has_contratos_wrappers1_idx` (`wrapper_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8