CREATE TABLE `servicosweb` (
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `descricao` varchar(500) DEFAULT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='tabela usada para diferenciar servicos como por exemplo updates_clientes e trigger_ot. Tem de estar populada:\ninsert into servicosweb values (1,"updates_clientes","envio periodico de updates aos clientes"),(2,"trigger_ot","tabela monitorizada por cron job. Tabela é populada qd ha un insert na datas_de_exploracao e deve activar a criacao de ot"),(3,"gmedia_out","envio de updates em assets p gmedia"),(4,"terms_out","envio de dados para terms")'