-- MySQL Script generated by MySQL Workbench
-- Thu May  4 21:01:08 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema shippingapplication
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `shippingapplication` ;

-- -----------------------------------------------------
-- Schema shippingapplication
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `shippingapplication` DEFAULT CHARACTER SET utf8 ;
USE `shippingapplication` ;

-- -----------------------------------------------------
-- Table `shippingapplication`.`truck`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`truck` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`truck` (
  `truckID` INT NOT NULL,
  `plateNum` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`truckID`))
ENGINE = InnoDB;

DESCRIBE truck;

INSERT INTO truck VALUES('001','825ZGC');
INSERT INTO truck VALUES('002','BH7281');
INSERT INTO truck VALUES('003','276VEG');
INSERT INTO truck VALUES('004','8627TS');
INSERT INTO truck VALUES('005','8AWS42');

SELECT * FROM truck;

-- -----------------------------------------------------
-- Table `shippingapplication`.`distribution`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`distribution` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`distribution` (
  `distributionID` INT NOT NULL,
  `centerName` VARCHAR(45) NOT NULL,
  `centerAddress` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`distributionID`))
ENGINE = InnoDB;

DESCRIBE distribution;

INSERT INTO distribution VALUES('001','ABR Distribution','441 Information Street');
INSERT INTO distribution VALUES('002','Walmart','8564 Cloud Boulevard');
INSERT INTO distribution VALUES('003','Cloud Sales','172 Computing Center');

SELECT * FROM distribution;

-- -----------------------------------------------------
-- Table `shippingapplication`.`warehouse`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`warehouse` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`warehouse` (
  `warehouseID` INT NOT NULL,
  `warehouseName` VARCHAR(45) NOT NULL,
  `warehouseAddress` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`warehouseID`))
ENGINE = InnoDB;

DESCRIBE warehouse;

INSERT INTO warehouse VALUES('001','ABR Warehouse','123 Bryant Avenue');
INSERT INTO warehouse VALUES('002','Cloud Storage','1150 ISA Lane');
INSERT INTO warehouse VALUES('003','Smithfield Store House','1150 Douglas Pike');

SELECT * FROM warehouse;

-- -----------------------------------------------------
-- Table `shippingapplication`.`weightLimit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`weightLimit` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`weightLimit` (
  `weightLimitID` INT NOT NULL,
  `weightLimit` INT NOT NULL,
  PRIMARY KEY (`weightLimitID`))
ENGINE = InnoDB;

DESCRIBE weightLimit;

INSERT INTO weightLimit VALUES('001','80');
INSERT INTO weightLimit VALUES('002','60');
INSERT INTO weightLimit VALUES('003','90');

SELECT * FROM weightLimit;

-- -----------------------------------------------------
-- Table `shippingapplication`.`shipment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`shipment` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`shipment` (
  `shipmentID` INT NOT NULL,
  `shipDate` DATE NULL,
  `deliverDate` DATE NULL,
  `transitTime` TIME NULL,
  `warehouseID` INT NOT NULL,
  `distributionID` INT NOT NULL,
  `weightLimitID` INT NOT NULL,
  PRIMARY KEY (`shipmentID`),
  INDEX `fk_shipment_warehouse_idx` (`warehouseID` ASC) VISIBLE,
  INDEX `fk_shipment_distribution1_idx` (`distributionID` ASC) VISIBLE,
  INDEX `fk_shipment_weightLimit1_idx` (`weightLimitID` ASC) VISIBLE,
  CONSTRAINT `fk_shipment_warehouse`
    FOREIGN KEY (`warehouseID`)
    REFERENCES `shippingapplication`.`warehouse` (`warehouseID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipment_distribution1`
    FOREIGN KEY (`distributionID`)
    REFERENCES `shippingapplication`.`distribution` (`distributionID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipment_weightLimit1`
    FOREIGN KEY (`weightLimitID`)
    REFERENCES `shippingapplication`.`weightLimit` (`weightLimitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DESCRIBE shipment;

INSERT INTO shipment VALUES('000001','2023-04-05','2023-04-13','190:08:32','001','003','001');
INSERT INTO shipment VALUES('000002','2023-04-07','2023-04-13','146:35:07','001','003','001');
INSERT INTO shipment VALUES('000003','2023-04-10','2023-04-17','167:50:12','003','002','002');
INSERT INTO shipment VALUES('000004','2023-04-15',NULL,NULL,'002','001','003');
INSERT INTO shipment VALUES('000005','2023-04-16',NULL,NULL,'003','002','002');

SELECT * FROM shipment;

-- -----------------------------------------------------
-- Table `shippingapplication`.`sizeOfBox`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`sizeOfBox` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`sizeOfBox` (
  `sizeOfBoxID` INT NOT NULL,
  `width` DECIMAL(4,2) NOT NULL,
  `depth` DECIMAL(4,2) NOT NULL,
  `height` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`sizeOfBoxID`))
ENGINE = InnoDB;

DESCRIBE sizeOfBox;

INSERT INTO sizeOfBox VALUES('001','24','36','12');
INSERT INTO sizeOfBox VALUES('002','12','18','6');
INSERT INTO sizeOfBox VALUES('003','24','24','12');
INSERT INTO sizeOfBox VALUES('004','12','8','2');
INSERT INTO sizeOfBox VALUES('005','36','36','24');

SELECT * FROM sizeOfBox;

-- -----------------------------------------------------
-- Table `shippingapplication`.`boxLabel`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`boxLabel` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`boxLabel` (
  `boxLabelID` INT NOT NULL,
  `boxQty` INT NOT NULL,
  `boxWeight` DECIMAL(4,2) NOT NULL,
  `sizeOfBoxID` INT NOT NULL,
  PRIMARY KEY (`boxLabelID`),
  INDEX `fk_boxLabel_sizeOfBox1_idx` (`sizeOfBoxID` ASC) VISIBLE,
  CONSTRAINT `fk_boxLabel_sizeOfBox1`
    FOREIGN KEY (`sizeOfBoxID`)
    REFERENCES `shippingapplication`.`sizeOfBox` (`sizeOfBoxID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DESCRIBE boxLabel;

INSERT INTO boxLabel VALUES('000001','2','4.5','004');
INSERT INTO boxLabel VALUES('000002','6','12','002');
INSERT INTO boxLabel VALUES('000003','3','26.75','001');
INSERT INTO boxLabel VALUES('000004','10','30','005');
INSERT INTO boxLabel VALUES('000005','1','3','004');
INSERT INTO boxLabel VALUES('000006','16','4.5','004');
INSERT INTO boxLabel VALUES('000007','6','19.25','003');
INSERT INTO boxLabel VALUES('000008','24','35','005');
INSERT INTO boxLabel VALUES('000009','8','14.55','001');
INSERT INTO boxLabel VALUES('000010','5','12','002');

SELECT * FROM boxLabel;

-- -----------------------------------------------------
-- Table `shippingapplication`.`boxContent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`boxContent` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`boxContent` (
  `boxContentID` INT NOT NULL,
  `item` INT NOT NULL,
  `qty` INT NOT NULL,
  `boxLabelID` INT NOT NULL,
  PRIMARY KEY (`boxContentID`),
  INDEX `fk_boxContent_boxLabel1_idx` (`boxLabelID` ASC) VISIBLE,
  CONSTRAINT `fk_boxContent_boxLabel1`
    FOREIGN KEY (`boxLabelID`)
    REFERENCES `shippingapplication`.`boxLabel` (`boxLabelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DESCRIBE boxContent;

INSERT INTO boxContent VALUES('000001','0001','1','000005');
INSERT INTO boxContent VALUES('000002','0002','3','000003');

SELECT * FROM boxContent;

-- -----------------------------------------------------
-- Table `shippingapplication`.`shipmentDetails`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`shipmentDetails` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`shipmentDetails` (
  `shipmentDetails` INT NOT NULL,
  `boxLabelID` INT NOT NULL,
  `shipmentID` INT NOT NULL,
  `truckID` INT NOT NULL,
  PRIMARY KEY (`shipmentDetails`),
  INDEX `fk_shipment_truck1_idx` (`truckID` ASC) VISIBLE,
  INDEX `fk_shipment_boxLabel1_idx` (`boxLabelID` ASC) VISIBLE,
  INDEX `fk_shipmentDetails_shipment1_idx` (`shipmentID` ASC) VISIBLE,
  CONSTRAINT `fk_shipment_truck1`
    FOREIGN KEY (`truckID`)
    REFERENCES `shippingapplication`.`truck` (`truckID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipment_boxLabel1`
    FOREIGN KEY (`boxLabelID`)
    REFERENCES `shippingapplication`.`boxLabel` (`boxLabelID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_shipmentDetails_shipment1`
    FOREIGN KEY (`shipmentID`)
    REFERENCES `shippingapplication`.`shipment` (`shipmentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DESCRIBE shipmentDetails;

INSERT INTO shipmentDetails VALUES('000001','000001','001','000001');
INSERT INTO shipmentDetails VALUES('000002','000002','001','000001');
INSERT INTO shipmentDetails VALUES('000003','000003','003','000002');
INSERT INTO shipmentDetails VALUES('000004','000004','003','000003');
INSERT INTO shipmentDetails VALUES('000005','000005','001','000004');
INSERT INTO shipmentDetails VALUES('000006','000006','002','000005');
INSERT INTO shipmentDetails VALUES('000007','000007','002','000005');

SELECT * FROM shipmentDetails;

-- -----------------------------------------------------
-- Table `shippingapplication`.`shipmentTracking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`shipmentTracking` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`shipmentTracking` (
  `shipmentTrackingID` INT NOT NULL,
  `boxLoaded` TINYINT NOT NULL,
  `boxReceived` TINYINT NOT NULL,
  `shipmentDetailsID` INT NOT NULL,
  PRIMARY KEY (`shipmentTrackingID`),
  INDEX `fk_shipmentTracking_shipmentDetails1_idx` (`shipmentDetailsID` ASC) VISIBLE,
  CONSTRAINT `fk_shipmentTracking_shipmentDetails1`
    FOREIGN KEY (`shipmentDetailsID`)
    REFERENCES `shippingapplication`.`shipmentDetails` (`shipmentDetails`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

DESCRIBE shipmentTracking;

INSERT INTO shipmentTracking VALUES('000001','1','1','000001');
INSERT INTO shipmentTracking VALUES('000002','1','0','000007');

SELECT * FROM shipmentTracking;

-- -----------------------------------------------------
-- Table `shippingapplication`.`shipment_audit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `shippingapplication`.`shipment_audit` ;

CREATE TABLE IF NOT EXISTS `shippingapplication`.`shipment_audit` (
  `shipmentID` INT NOT NULL,
  `shipDate` DATE NULL,
  `deliverDate` DATE NULL,
  `transitTime` TIME NULL,
  `warehouseID` INT NOT NULL,
  `distributionID` INT NOT NULL,
  `weightLimitID` INT NOT NULL,
  `action` VARCHAR(10) NOT NULL,
  `date_time` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- -----------------------------------------------------
-- Trigger `shippingapplication`.`shipment_audit_trigger`
-- -----------------------------------------------------

DELIMITER //
CREATE TRIGGER `shipment_audit_trigger`
AFTER INSERT ON `shippingapplication`.`shipment`
FOR EACH ROW
BEGIN
  INSERT INTO `shippingapplication`.`shipment_audit` 
    (`shipmentID`, `shipDate`, `deliverDate`, `transitTime`, `warehouseID`, `distributionID`, `weightLimitID`, `action`)
  VALUES 
    (NEW.`shipmentID`, NEW.`shipDate`, NEW.`deliverDate`, NEW.`transitTime`, NEW.`warehouseID`, NEW.`distributionID`, NEW.`weightLimitID`, 'INSERT');
END; //

-- -----------------------------------------------------
-- Trigger `shippingapplication`.`shipment_audit_trigger_update`
-- -----------------------------------------------------

CREATE TRIGGER `shipment_audit_trigger_update`
AFTER UPDATE ON `shippingapplication`.`shipment`
FOR EACH ROW
BEGIN
  INSERT INTO `shippingapplication`.`shipment_audit` 
    (`shipmentID`, `shipDate`, `deliverDate`, `transitTime`, `warehouseID`, `distributionID`, `weightLimitID`, `action`)
  VALUES 
    (NEW.`shipmentID`, NEW.`shipDate`, NEW.`deliverDate`, NEW.`transitTime`, NEW.`warehouseID`, NEW.`distributionID`, NEW.`weightLimitID`, 'UPDATE');
END; //

-- -----------------------------------------------------
-- Trigger `shippingapplication`.`shipment_audit_trigger_delete`
-- -----------------------------------------------------

CREATE TRIGGER `shipment_audit_trigger_delete`
AFTER DELETE ON `shippingapplication`.`shipment`
FOR EACH ROW
BEGIN
  INSERT INTO `shippingapplication`.`shipment_audit` 
    (`shipmentID`, `shipDate`, `deliverDate`, `transitTime`, `warehouseID`, `distributionID`, `weightLimitID`, `action`)
  VALUES 
    (OLD.`shipmentID`, OLD.`shipDate`, OLD.`deliverDate`, OLD.`transitTime`, OLD.`warehouseID`, OLD.`distributionID`, OLD.`weightLimitID`, 'DELETE');
END; //
DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
