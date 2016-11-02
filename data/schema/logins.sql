CREATE TABLE `logins` (
  `parceiro_id` mediumint(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `status` tinyint(4) DEFAULT '1',
  PRIMARY KEY (`parceiro_id`),
  KEY `fk_logins_intervenientes1_idx` (`parceiro_id`),
  CONSTRAINT `fk_logins_parceiros1` FOREIGN KEY (`parceiro_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8