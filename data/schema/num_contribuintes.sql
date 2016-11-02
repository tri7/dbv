CREATE TABLE `num_contribuintes` (
  `parceiro_id` mediumint(11) NOT NULL,
  `num_contribuinte` varchar(15) NOT NULL,
  PRIMARY KEY (`parceiro_id`),
  KEY `fk_Num_contribuintes_parceiros1_idx` (`parceiro_id`),
  CONSTRAINT `fk_num_contribuintes_parceiros1` FOREIGN KEY (`parceiro_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8