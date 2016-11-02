CREATE TABLE `warnings` (
  `id` mediumint(10) unsigned NOT NULL AUTO_INCREMENT,
  `gcd` mediumint(10) unsigned NOT NULL,
  `descricao` varchar(100) NOT NULL,
  `type` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8