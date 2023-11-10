-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema user_dashboard_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema user_dashboard_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `user_dashboard_schema` DEFAULT CHARACTER SET utf8 ;
USE `user_dashboard_schema` ;

-- -----------------------------------------------------
-- Table `user_dashboard_schema`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_dashboard_schema`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(45) NULL,
  `description` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` TEXT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_dashboard_schema`.`messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_dashboard_schema`.`messages` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_messages_users_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_messages_users`
    FOREIGN KEY (`user_id`)
    REFERENCES `user_dashboard_schema`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_dashboard_schema`.`user_level`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_dashboard_schema`.`user_level` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `level` INT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_level_users1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_level_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user_dashboard_schema`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_dashboard_schema`.`reply`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `user_dashboard_schema`.`reply` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` TEXT NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `user_id` INT NOT NULL,
  `message_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reply_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_reply_messages1_idx` (`message_id` ASC) VISIBLE,
  CONSTRAINT `fk_reply_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user_dashboard_schema`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_reply_messages1`
    FOREIGN KEY (`message_id`)
    REFERENCES `user_dashboard_schema`.`messages` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
