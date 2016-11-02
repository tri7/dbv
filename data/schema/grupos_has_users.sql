CREATE TABLE `grupos_has_users` (
  `grupo_id` mediumint(11) NOT NULL,
  `parceiro_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`grupo_id`,`parceiro_id`),
  KEY `fk_grupos_has_parceiros_grupos1_idx` (`grupo_id`),
  KEY `fk_grupos_has_parceiros_logins1_idx` (`parceiro_id`),
  CONSTRAINT `fk_grupos_has_parceiros_grupos1` FOREIGN KEY (`grupo_id`) REFERENCES `grupos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_grupos_has_parceiros_logins1` FOREIGN KEY (`parceiro_id`) REFERENCES `logins` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8