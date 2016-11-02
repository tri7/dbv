CREATE TABLE `calendario_prods_trimestres` (
  `stdate` date NOT NULL,
  `eddate` date NOT NULL,
  `trimestre` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`stdate`,`eddate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela usada para a extração de metadata. Devem ser populada.'