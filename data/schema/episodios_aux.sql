CREATE TABLE `episodios_aux` (
  `id` mediumint(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Utilizada na procedure ot_dist. Deve estar populada com numeros consecutivos pelo menos ate 2000'