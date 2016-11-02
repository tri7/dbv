CREATE TABLE `assets_has_canais_de_audio` (
  `assets_id` mediumint(11) NOT NULL,
  `canal_de_audio_id` mediumint(11) NOT NULL,
  `index` tinyint(4) NOT NULL,
  PRIMARY KEY (`assets_id`,`canal_de_audio_id`,`index`),
  KEY `fk_assets_has_canai_de_audio_canai_de_audio1_idx` (`canal_de_audio_id`),
  KEY `fk_assets_has_canai_de_audio_assets1_idx` (`assets_id`),
  CONSTRAINT `fk_assets_has_canai_de_audio_assets1` FOREIGN KEY (`assets_id`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_assets_has_canai_de_audio_canai_de_audio1` FOREIGN KEY (`canal_de_audio_id`) REFERENCES `canais_de_audio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que guarda a identificação e ordem dos canais de audio de um asset.'