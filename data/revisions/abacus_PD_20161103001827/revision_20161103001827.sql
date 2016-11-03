ALTER TABLE `abacus`.`historico` 
CHANGE COLUMN `testeoutra` `testeoutra` INT(10) UNSIGNED NULL DEFAULT '9';

ALTER TABLE `abacus`.`historico` 
ADD COLUMN `outra2` VARCHAR(45) NOT NULL AFTER `testeoutra`;