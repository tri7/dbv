CREATE TABLE `report_nodes` (
  `node_id` mediumint(8) unsigned NOT NULL,
  `resp_id_old` mediumint(11) DEFAULT NULL,
  `resp_id_new` mediumint(11) DEFAULT NULL,
  `date` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`node_id`),
  KEY `fk_report_nodes_parceiros1_idx` (`resp_id_old`),
  KEY `fk_report_nodes_parceiros2_idx` (`resp_id_new`),
  CONSTRAINT `fk_report_nodes_ot_nodes1` FOREIGN KEY (`node_id`) REFERENCES `ot_nodes` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_nodes_parceiros1` FOREIGN KEY (`resp_id_old`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_report_nodes_parceiros2` FOREIGN KEY (`resp_id_new`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8