-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8mb4 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Purchases`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Purchases` (
  `Purchase_ID` INT NOT NULL AUTO_INCREMENT,
  `Quantity_Tickets_child` TINYINT UNSIGNED NOT NULL,
  `Quantity_tickets_adult` TINYINT UNSIGNED NOT NULL,
  `Total_balance` FLOAT NOT NULL,
  `Date_of_purchase` DATE NOT NULL,
  PRIMARY KEY (`Purchase_ID`),
  UNIQUE INDEX `Purchase_ID_UNIQUE` (`Purchase_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Airline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Airline` (
  `Airline_ID` CHAR(45) NOT NULL,
  `Airline_Name` CHAR(45) NOT NULL,
  PRIMARY KEY (`Airline_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customers` (
  `Customer_ID` VARCHAR(45) NOT NULL,
  `last_name` CHAR(45) NOT NULL,
  `first_name` CHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Phone` INT NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`Customer_ID`),
  UNIQUE INDEX `Customer_ID_UNIQUE` (`Customer_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Airport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Airport` (
  `Airport_ID` INT NOT NULL,
  `name` CHAR(45) NULL,
  PRIMARY KEY (`Airport_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Flight`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Flight` (
  `Flight_ID` INT NOT NULL AUTO_INCREMENT,
  `Depart_city` CHAR(45) NOT NULL,
  `Depart_state` CHAR(45) NOT NULL,
  `Destination_city` CHAR(45) NOT NULL,
  `Destination_State` CHAR(45) NOT NULL,
  `date_of_departure` DATE NOT NULL,
  `Date_of_arrival` DATE NOT NULL,
  `Airline_confirmation_number` VARCHAR(45) NOT NULL,
  `Airport_ID_departure` VARCHAR(45) NOT NULL,
  `Airport_ID_arrival` VARCHAR(45) NOT NULL,
  `Travel Time (minutes)` INT NOT NULL,
  `Distance travel (miles)` INT NOT NULL,
  `Airport_Airport_ID` INT NOT NULL,
  `Airline_Airline_ID` CHAR(45) NOT NULL,
  PRIMARY KEY (`Flight_ID`),
  UNIQUE INDEX `Flight_ID_UNIQUE` (`Flight_ID` ASC) VISIBLE,
  INDEX `fk_Flight_Airport1_idx` (`Airport_Airport_ID` ASC) VISIBLE,
  INDEX `fk_Flight_Airline1_idx` (`Airline_Airline_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Flight_Airport1`
    FOREIGN KEY (`Airport_Airport_ID`)
    REFERENCES `mydb`.`Airport` (`Airport_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Flight_Airline1`
    FOREIGN KEY (`Airline_Airline_ID`)
    REFERENCES `mydb`.`Airline` (`Airline_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pricing`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pricing` (
  `Price_ID` INT NOT NULL,
  `Class` CHAR(45) NOT NULL,
  `Age` INT NOT NULL,
  `Departure_city` CHAR(45) NOT NULL,
  `Destination_city` CHAR(45) NOT NULL,
  `Season` CHAR(45) NOT NULL,
  `Price` FLOAT NOT NULL,
  PRIMARY KEY (`Price_ID`),
  UNIQUE INDEX `Price_ID_UNIQUE` (`Price_ID` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ticket`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ticket` (
  `Ticket_number` INT NOT NULL AUTO_INCREMENT,
  `Class` CHAR(45) NOT NULL,
  `Purchases_Purchase_ID` INT NOT NULL,
  `Customers_Customer_ID` VARCHAR(45) NOT NULL,
  `Flight_Flight_ID` INT NOT NULL,
  `Pricing_Price_ID` INT NOT NULL,
  PRIMARY KEY (`Ticket_number`),
  UNIQUE INDEX `Ticket_number_UNIQUE` (`Ticket_number` ASC) VISIBLE,
  INDEX `fk_Ticket_Purchases_idx` (`Purchases_Purchase_ID` ASC) VISIBLE,
  INDEX `fk_Ticket_Customers1_idx` (`Customers_Customer_ID` ASC) VISIBLE,
  INDEX `fk_Ticket_Flight1_idx` (`Flight_Flight_ID` ASC) VISIBLE,
  INDEX `fk_Ticket_Pricing1_idx` (`Pricing_Price_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Ticket_Purchases`
    FOREIGN KEY (`Purchases_Purchase_ID`)
    REFERENCES `mydb`.`Purchases` (`Purchase_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Customers1`
    FOREIGN KEY (`Customers_Customer_ID`)
    REFERENCES `mydb`.`Customers` (`Customer_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Flight1`
    FOREIGN KEY (`Flight_Flight_ID`)
    REFERENCES `mydb`.`Flight` (`Flight_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ticket_Pricing1`
    FOREIGN KEY (`Pricing_Price_ID`)
    REFERENCES `mydb`.`Pricing` (`Price_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
