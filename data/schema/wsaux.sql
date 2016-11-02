CREATE TABLE `wsaux` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `table_name` varchar(55) NOT NULL,
  `oldfields` varchar(255) NOT NULL DEFAULT '' COMMENT 'campos actualizados separados por “,” e “;”',
  `newfields` varchar(255) NOT NULL,
  `row_id` varchar(45) NOT NULL DEFAULT '',
  `created_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `termsid` varchar(50) DEFAULT '0',
  `method` enum('PUT','POST') NOT NULL DEFAULT 'PUT',
  `trigger_com` varchar(45) NOT NULL DEFAULT 'UPDATE',
  PRIMARY KEY (`id`),
  KEY `ids_status1` (`status`,`termsid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8