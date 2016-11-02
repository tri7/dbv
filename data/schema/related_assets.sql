CREATE TABLE `related_assets` (
  `obras_ocm_id` mediumint(11) NOT NULL,
  `related_obra_terms_id` mediumint(11) NOT NULL,
  `tipo` varchar(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8