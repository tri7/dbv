CREATE TABLE `terms_plays` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `runs_id` mediumint(11) NOT NULL,
  `runs` tinyint(2) DEFAULT NULL,
  `nplays` varchar(9) DEFAULT NULL,
  `day_scope` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`,`runs_id`),
  KEY `fk_plays_runs1_idx` (`runs_id`),
  CONSTRAINT `fk_plays_runs1` FOREIGN KEY (`runs_id`) REFERENCES `terms_runs` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8