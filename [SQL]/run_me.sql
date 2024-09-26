CREATE TABLE IF NOT EXISTS `players_xp` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(255) NOT NULL UNIQUE,
    `xp_data` LONGTEXT NOT NULL,
    PRIMARY KEY (`id`)
);