CREATE TABLE `horarios` (
  `ano_mes` date NOT NULL COMMENT 'Devera ser introduzida como uma data sempre com o dia 1',
  `parceiro_id` mediumint(11) NOT NULL,
  `turno_id` varchar(20) NOT NULL,
  `dias` set('1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31') NOT NULL,
  `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ano_mes`,`parceiro_id`,`turno_id`),
  KEY `fk_horarios_turnos1_idx` (`turno_id`),
  KEY `fk_horarios_parceiros1_idx` (`parceiro_id`),
  CONSTRAINT `fk_horarios_parceiros1` FOREIGN KEY (`parceiro_id`) REFERENCES `parceiros` (`parceiro_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_horarios_turnos1` FOREIGN KEY (`turno_id`) REFERENCES `turnos` (`nome`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8