CREATE TABLE `pilat` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `pilat_id` mediumint(11) DEFAULT NULL,
  `data_de_criacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `quem_criou` mediumint(11) DEFAULT NULL,
  `status` enum('') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_quem_criou_1_idx` (`quem_criou`),
  CONSTRAINT `fk_pilat_parceiros1` FOREIGN KEY (`quem_criou`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8