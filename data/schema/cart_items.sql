CREATE TABLE `cart_items` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  `tipo_de_objecto` varchar(45) DEFAULT NULL,
  `id_obj` mediumint(11) DEFAULT NULL,
  `selected` tinyint(1) DEFAULT NULL,
  `parceiro_id` mediumint(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cart_items_parceiros1_idx` (`parceiro_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8