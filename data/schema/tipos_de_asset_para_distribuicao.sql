CREATE TABLE `tipos_de_asset_para_distribuicao` (
  `plataformas_has_sub_plataforma_id` mediumint(11) NOT NULL COMMENT 'Configuração dos tipos de conteúdo a entregar para cada negócio\n',
  `tipos_de_conteudos_id` mediumint(11) NOT NULL,
  KEY `fk_tipos_de_asset_para distribuicao_plataformas_has_sub_pla_idx` (`plataformas_has_sub_plataforma_id`),
  KEY `fk_tipos_de_asset_para distribuicao_tipos_de_conteudos1_idx` (`tipos_de_conteudos_id`),
  CONSTRAINT `fk_tipos_de_asset_para distribuicao_plataformas_has_sub_plata1` FOREIGN KEY (`plataformas_has_sub_plataforma_id`) REFERENCES `plataformas_has_sub_plataforma` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipos_de_asset_para distribuicao_tipos_de_conteudos1` FOREIGN KEY (`tipos_de_conteudos_id`) REFERENCES `tipos_de_conteudos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8