CREATE TABLE `hist_correct` (
  `id` mediumint(11) unsigned NOT NULL AUTO_INCREMENT,
  `tabela` varchar(25) NOT NULL,
  `elem_id` mediumint(11) unsigned NOT NULL,
  `old_obraid` mediumint(11) unsigned NOT NULL,
  `new_obraid` mediumint(11) unsigned NOT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8