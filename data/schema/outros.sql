CREATE TABLE `outros` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `quem_criou_id` mediumint(11) DEFAULT NULL,
  `quando_criou` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `fk_quem_criou_idx` (`quem_criou_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8