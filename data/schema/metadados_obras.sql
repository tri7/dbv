CREATE TABLE `metadados_obras` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `nome_de_seguranca` varchar(45) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `studio` varchar(160) DEFAULT NULL,
  `titulo_pt` varchar(100) DEFAULT NULL,
  `titulo_pt_curto` varchar(45) DEFAULT NULL,
  `year_obra` year(4) DEFAULT NULL,
  `summary_short` varchar(100) DEFAULT NULL,
  `imdb_link` varchar(250) DEFAULT NULL,
  `imdb_classificacao` varchar(45) DEFAULT NULL,
  `link_oficial` varchar(250) DEFAULT NULL,
  `rating_id` mediumint(11) unsigned DEFAULT NULL,
  `classificacao_etaria_id` mediumint(11) unsigned DEFAULT NULL,
  `poster` varchar(250) DEFAULT NULL,
  `cor` tinyint(1) DEFAULT NULL,
  `duracao_estimada` smallint(3) DEFAULT NULL,
  `service` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Se tiver sido inserido/update por terms service = 1. ',
  PRIMARY KEY (`id`),
  KEY `fk_obras_classificacoes1_idx` (`rating_id`),
  KEY `fk_obras_classificacoes_etarias1_idx` (`classificacao_etaria_id`),
  KEY `title` (`title`),
  KEY `id` (`id`),
  CONSTRAINT `fk_obras_classificacoes1` FOREIGN KEY (`rating_id`) REFERENCES `ratings` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_obras_classificacoes_etarias1` FOREIGN KEY (`classificacao_etaria_id`) REFERENCES `classificacoes_etarias` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Envia para terms. Campos definidos nos triggers'