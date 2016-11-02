CREATE TABLE `timecodes` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `tc_in` varchar(45) DEFAULT NULL,
  `tc_out` varchar(45) DEFAULT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8