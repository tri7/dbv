CREATE TABLE `contactos` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `tipo_de_contacto_id` mediumint(11) DEFAULT NULL,
  `contacto` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_tipo_de_contacto_id_idx` (`tipo_de_contacto_id`),
  CONSTRAINT `fk_tipo_de_contacto_id` FOREIGN KEY (`tipo_de_contacto_id`) REFERENCES `tipos_de_contactos` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8