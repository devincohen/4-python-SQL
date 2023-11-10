-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema normalization_schema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema normalization_schema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `normalization_schema` DEFAULT CHARACTER SET utf8 ;
USE `normalization_schema` ;

-- -----------------------------------------------------
-- Table `normalization_schema`.`cities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `normalization_schema`.`cities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `normalization_schema`.`zip_codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `normalization_schema`.`zip_codes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `zip_code` VARCHAR(45) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `city_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_zip_codes_city1_idx` (`city_id` ASC) VISIBLE,
  CONSTRAINT `fk_zip_codes_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `normalization_schema`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `normalization_schema`.`addresses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `normalization_schema`.`addresses` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street_address` VARCHAR(255) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  `city_id` INT NOT NULL,
  `zip_code_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_addresses_cities1_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_addresses_zip_codes1_idx` (`zip_code_id` ASC) VISIBLE,
  CONSTRAINT `fk_addresses_cities1`
    FOREIGN KEY (`city_id`)
    REFERENCES `normalization_schema`.`cities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_addresses_zip_codes1`
    FOREIGN KEY (`zip_code_id`)
    REFERENCES `normalization_schema`.`zip_codes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `normalization_schema`.`dojos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `normalization_schema`.`dojos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NULL,
  `created_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_dojos_addresses1_idx` (`address_id` ASC) VISIBLE,
  CONSTRAINT `fk_dojos_addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `normalization_schema`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `normalization_schema`.`students`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `normalization_schema`.`students` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(255) NULL,
  `last_name` VARCHAR(255) NULL,
  `address_id` INT NOT NULL,
  `dojo_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_students_addresses1_idx` (`address_id` ASC) VISIBLE,
  INDEX `fk_students_dojos1_idx` (`dojo_id` ASC) VISIBLE,
  CONSTRAINT `fk_students_addresses1`
    FOREIGN KEY (`address_id`)
    REFERENCES `normalization_schema`.`addresses` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_dojos1`
    FOREIGN KEY (`dojo_id`)
    REFERENCES `normalization_schema`.`dojos` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `normalization_schema`.`interests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `normalization_schema`.`interests` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `interest` VARCHAR(255) NULL,
  `created_at` DATETIME NULL,
  `updated_at` DATETIME NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `normalization_schema`.`student_interest`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `normalization_schema`.`student_interest` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `students_id` INT NOT NULL,
  `interests_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_students_has_interests_interests1_idx` (`interests_id` ASC) VISIBLE,
  INDEX `fk_students_has_interests_students1_idx` (`students_id` ASC) VISIBLE,
  CONSTRAINT `fk_students_has_interests_students1`
    FOREIGN KEY (`students_id`)
    REFERENCES `normalization_schema`.`students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_students_has_interests_interests1`
    FOREIGN KEY (`interests_id`)
    REFERENCES `normalization_schema`.`interests` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
