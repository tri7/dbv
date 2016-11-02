CREATE TABLE `assets_status` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que guarda os status dos assets.\nDeve ser populaça por default com os seguintes dados:\nRX ready\nNao Apto\nTX ready'