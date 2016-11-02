CREATE TABLE `parceiros` (
  `parceiro_id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `foto` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`parceiro_id`),
  KEY `parceiro_id` (`parceiro_id`,`nome`,`foto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8