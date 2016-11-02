CREATE TABLE `crs` (
  `name` varchar(45) NOT NULL,
  `value` double unsigned NOT NULL,
  PRIMARY KEY (`name`),
  KEY `idx_val` (`value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8