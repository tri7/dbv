CREATE TABLE `calendario_prods_semanas` (
  `stdate` date NOT NULL,
  `eddate` date NOT NULL,
  PRIMARY KEY (`stdate`,`eddate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela usada para a extração de metadata. Devem ser populada.'