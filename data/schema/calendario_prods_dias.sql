CREATE TABLE `calendario_prods_dias` (
  `dia` date NOT NULL,
  PRIMARY KEY (`dia`),
  UNIQUE KEY `dia_UNIQUE` (`dia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela usada para a extração de metadata. Devem ser populada.'