CREATE TABLE `assets_has_intervalos` (
  `asset_id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `timecode_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`asset_id`,`timecode_id`),
  KEY `fk_assets_has_timecodes1_timecodes1_idx` (`timecode_id`),
  KEY `fk_assets_has_timecodes1_assets1_idx` (`asset_id`),
  CONSTRAINT `fk_assets_has_timecodes1_assets1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_assets_has_timecodes1_timecodes1` FOREIGN KEY (`timecode_id`) REFERENCES `timecodes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tabela que guarda a definição de um ou mais intervalos de um asset.'