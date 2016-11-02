CREATE TABLE `plataformas_has_sub_plataforma` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `plataformas_id` mediumint(11) DEFAULT NULL,
  `sub_plataforma_id` mediumint(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_plataformas_has_sub_plataforma_sub_plataforma1_idx` (`sub_plataforma_id`),
  KEY `fk_plataformas_has_sub_plataforma_plataformas1_idx` (`plataformas_id`),
  CONSTRAINT `fk_plataformas_has_sub_plataforma_plataformas1` FOREIGN KEY (`plataformas_id`) REFERENCES `plataformas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_plataformas_has_sub_plataforma_sub_plataforma1` FOREIGN KEY (`sub_plataforma_id`) REFERENCES `sub_plataforma` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8