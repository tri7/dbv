CREATE TABLE `facturas` (
  `ots_id` mediumint(11) NOT NULL,
  `operador_id` mediumint(11) NOT NULL,
  `descricao` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`ots_id`,`operador_id`),
  KEY `fk_facturas_parceiros1_idx` (`operador_id`),
  CONSTRAINT `fk_facturas_ots1` FOREIGN KEY (`ots_id`) REFERENCES `ots` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturas_parceiros1` FOREIGN KEY (`operador_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8