CREATE TABLE `majors_nao_linear` (
  `major_id` mediumint(11) NOT NULL,
  `parent_id` mediumint(11) DEFAULT NULL,
  `aka` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`major_id`),
  KEY `fk_majors_nao_linear_parceiros2_idx` (`parent_id`),
  CONSTRAINT `fk_majors_nao_linear_parceiros1` FOREIGN KEY (`major_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_majors_nao_linear_parceiros2` FOREIGN KEY (`parent_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8