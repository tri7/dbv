CREATE TABLE `api_logs_ws` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `data_envio` datetime NOT NULL,
  `data_act` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `url` varchar(250) NOT NULL,
  `method` enum('PUT','POST') NOT NULL DEFAULT 'PUT',
  `json_file` mediumtext NOT NULL,
  `http_reply` varchar(150) NOT NULL,
  `error_code` varchar(10) NOT NULL DEFAULT '',
  `wsauxids` mediumint(9) DEFAULT NULL,
  `resolved` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela utilizada para logar o servico cpm->terms'