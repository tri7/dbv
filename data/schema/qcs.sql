CREATE TABLE `qcs` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `qc` varchar(45) DEFAULT NULL,
  `quando_deu` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `parceiros_parceiro_id` mediumint(11) NOT NULL,
  `obs` text,
  `cpm_filename` varchar(100) DEFAULT NULL,
  `tipo_qc_id` tinyint(4) DEFAULT NULL,
  `atualizado_por` mediumint(11) DEFAULT NULL,
  `atualizado_em` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_qcs_parceiros1_idx` (`parceiros_parceiro_id`),
  KEY `fk_qcs_tipo_qc1_idx` (`tipo_qc_id`),
  CONSTRAINT `fk_qcs_parceiros1` FOREIGN KEY (`parceiros_parceiro_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_qcs_tipo_qc1` FOREIGN KEY (`tipo_qc_id`) REFERENCES `tipo_qc` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Participa em GMEDIA'