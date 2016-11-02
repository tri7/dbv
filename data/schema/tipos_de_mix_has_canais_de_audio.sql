CREATE TABLE `tipos_de_mix_has_canais_de_audio` (
  `tipos_de_mix_id` mediumint(11) NOT NULL,
  `canais_de_audio_id` mediumint(11) NOT NULL,
  `index` tinyint(4) NOT NULL,
  KEY `fk_tipos_de_mix_has_canais_de_audio_tipos_de_mix1_idx` (`tipos_de_mix_id`),
  KEY `fk_tipos_de_mix_has_canais_de_audio_canais_de_audio1_idx` (`canais_de_audio_id`),
  CONSTRAINT `fk_tipos_de_mix_has_canais_de_audio_canais_de_audio1` FOREIGN KEY (`canais_de_audio_id`) REFERENCES `canais_de_audio` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipos_de_mix_has_canais_de_audio_tipos_de_mix1` FOREIGN KEY (`tipos_de_mix_id`) REFERENCES `tipos_de_mix` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8