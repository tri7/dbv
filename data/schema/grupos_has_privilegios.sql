CREATE TABLE `grupos_has_privilegios` (
  `grupos_id` mediumint(11) NOT NULL,
  `privilegios_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`grupos_id`,`privilegios_id`),
  KEY `fk_grupos_has_privilegios_privilegios1_idx` (`privilegios_id`),
  KEY `fk_grupos_has_privilegios_grupos1_idx` (`grupos_id`),
  CONSTRAINT `fk_grupos_has_privilegios_grupos1` FOREIGN KEY (`grupos_id`) REFERENCES `grupos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupos_has_privilegios_privilegios1` FOREIGN KEY (`privilegios_id`) REFERENCES `privilegios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8