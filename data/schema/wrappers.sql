CREATE TABLE `wrappers` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `tipo_de_wrapper_id` mediumint(11) NOT NULL,
  `status_id` mediumint(11) DEFAULT NULL,
  `cod_de_barras` varchar(45) DEFAULT NULL,
  `num_de_material` varchar(45) DEFAULT NULL,
  `is_emprestado` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tipo_de_wrapper_id_idx` (`tipo_de_wrapper_id`),
  KEY `num_de_material` (`num_de_material`),
  CONSTRAINT `fk_tipo_de_wrapper_id` FOREIGN KEY (`tipo_de_wrapper_id`) REFERENCES `tipos_de_wrapper` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8