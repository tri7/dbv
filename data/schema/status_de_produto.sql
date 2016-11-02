CREATE TABLE `status_de_produto` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `status` varchar(10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nome_idx` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8