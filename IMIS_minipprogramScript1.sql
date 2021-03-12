-- MySQL Script generated by MySQL Workbench
-- Fri Mar 12 23:55:13 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema IMIS_Vision2.0
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema IMIS_Vision2.0
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `IMIS_Vision2.0` DEFAULT CHARACTER SET utf8 ;
USE `IMIS_Vision2.0` ;

-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`Activities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`Activities` (
  `idActivities` INT NOT NULL,
  `FromUser_ID` INT NOT NULL,
  `ReleaseTime` DATE NOT NULL,
  `Content` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idActivities`),
  INDEX `Initiator_idx` (`FromUser_ID` ASC) VISIBLE,
  CONSTRAINT `Initiator`
    FOREIGN KEY (`FromUser_ID`)
    REFERENCES `IMIS_Vision2.0`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`ActivityParticipants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`ActivityParticipants` (
  `idActivityParticipants` INT NOT NULL AUTO_INCREMENT,
  `ActivityID` INT NOT NULL,
  `ParticipantID` INT NOT NULL,
  `ActivityParticipantscol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idActivityParticipants`),
  INDEX `FromActivity_idx` (`ActivityID` ASC) VISIBLE,
  INDEX `FromUser_idx` (`ParticipantID` ASC) VISIBLE,
  CONSTRAINT `FromActivity`
    FOREIGN KEY (`ActivityID`)
    REFERENCES `IMIS_Vision2.0`.`Activities` (`idActivities`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FromUser`
    FOREIGN KEY (`ParticipantID`)
    REFERENCES `IMIS_Vision2.0`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`Collections`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`Collections` (
  `idCollections` INT NOT NULL,
  `FromUser_ID` INT NOT NULL,
  `FromPosts_ID` INT NOT NULL,
  PRIMARY KEY (`idCollections`),
  INDEX `CollectingUser_idx` (`FromUser_ID` ASC) VISIBLE,
  INDEX `PostsID_idx` (`FromPosts_ID` ASC) VISIBLE,
  CONSTRAINT `CollectingUser`
    FOREIGN KEY (`FromUser_ID`)
    REFERENCES `IMIS_Vision2.0`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PostsID`
    FOREIGN KEY (`FromPosts_ID`)
    REFERENCES `IMIS_Vision2.0`.`Posts` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`Comments_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`Comments_table` (
  `comment_id` INT NOT NULL AUTO_INCREMENT,
  `Post_id` INT NOT NULL,
  `From_userid` INT NOT NULL,
  `Contents` VARCHAR(200) NULL,
  PRIMARY KEY (`comment_id`),
  INDEX `Post_id_idx` (`Post_id` ASC) VISIBLE,
  INDEX `From_userid_idx` (`From_userid` ASC) VISIBLE,
  CONSTRAINT `Post_id`
    FOREIGN KEY (`Post_id`)
    REFERENCES `IMIS_Vision2.0`.`Posts` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `From_userid`
    FOREIGN KEY (`From_userid`)
    REFERENCES `IMIS_Vision2.0`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comments_table_Posts1`
    FOREIGN KEY (`From_userid`)
    REFERENCES `IMIS_Vision2.0`.`Posts` (`PosterID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`Competitions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`Competitions` (
  `idCompetitions` INT NOT NULL,
  `FromUser_ID` INT NOT NULL,
  `Contents` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idCompetitions`),
  INDEX `Belonger_idx` (`FromUser_ID` ASC) VISIBLE,
  CONSTRAINT `Belonger`
    FOREIGN KEY (`FromUser_ID`)
    REFERENCES `IMIS_Vision2.0`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`Interships`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`Interships` (
  `idInterships` INT NOT NULL,
  `FromUser_ID` INT NOT NULL,
  `Contents` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`idInterships`),
  INDEX `Attributer_idx` (`FromUser_ID` ASC) VISIBLE,
  CONSTRAINT `Attributer`
    FOREIGN KEY (`FromUser_ID`)
    REFERENCES `IMIS_Vision2.0`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`Posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`Posts` (
  `PostID` INT NOT NULL AUTO_INCREMENT,
  `PosterID` INT NOT NULL,
  `PostTime` DATE NOT NULL,
  `Contents` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`PostID`),
  INDEX `PosterID_idx` (`PosterID` ASC) VISIBLE,
  CONSTRAINT `PosterID`
    FOREIGN KEY (`PosterID`)
    REFERENCES `IMIS_Vision2.0`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`Reply_table`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`Reply_table` (
  `Reply_tableID` INT NOT NULL,
  `Comment_id` INT NOT NULL,
  `ReplyTarget_id` INT NOT NULL,
  `Content` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`Reply_tableID`),
  INDEX `Comment_ID_idx` (`Comment_id` ASC) VISIBLE,
  INDEX `TargetUser_ID_idx` (`ReplyTarget_id` ASC) VISIBLE,
  CONSTRAINT `Comment_ID`
    FOREIGN KEY (`Comment_id`)
    REFERENCES `IMIS_Vision2.0`.`Comments_table` (`comment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `TargetUser_ID`
    FOREIGN KEY (`ReplyTarget_id`)
    REFERENCES `IMIS_Vision2.0`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`Tunmb_up_tabe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`Tunmb_up_tabe` (
  `Tunmb_upID` INT NOT NULL,
  `User_ID` INT NOT NULL,
  `Comment_ID` INT NULL,
  `Post_ID` INT NULL,
  `Type(CommentOrPost)` INT NOT NULL COMMENT '0 represents Post thumb, 1 represents Comment thumb ',
  PRIMARY KEY (`Tunmb_upID`),
  UNIQUE INDEX `User_ID_UNIQUE` (`User_ID` ASC) VISIBLE,
  INDEX `CommentID_idx` (`Comment_ID` ASC) VISIBLE,
  INDEX `PostID_idx` (`Post_ID` ASC) VISIBLE,
  CONSTRAINT `UserID`
    FOREIGN KEY (`User_ID`)
    REFERENCES `IMIS_Vision2.0`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `PostID`
    FOREIGN KEY (`Post_ID`)
    REFERENCES `IMIS_Vision2.0`.`Posts` (`PostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `CommentID`
    FOREIGN KEY (`Comment_ID`)
    REFERENCES `IMIS_Vision2.0`.`Comments_table` (`comment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`Users` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Grade` INT NOT NULL,
  `Major` VARCHAR(45) NOT NULL,
  `Gender` INT NOT NULL,
  `AverageMark` INT NULL,
  `City` VARCHAR(45) NULL,
  `Image` MEDIUMBLOB NULL,
  `FollowingUserID` VARCHAR(100) NULL,
  `Specialties` VARCHAR(100) NULL,
  `Userscol` VARCHAR(45) NULL,
  `nickName` VARCHAR(45) NULL,
  `mail` VARCHAR(45) NULL,
  `skills` VARCHAR(100) NULL,
  `experience` VARCHAR(200) NULL,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `nickName_UNIQUE` (`nickName` ASC) VISIBLE,
  UNIQUE INDEX `mail_UNIQUE` (`mail` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`experience`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`experience` (
  `idexperience` INT NOT NULL AUTO_INCREMENT,
  `date` DATE NOT NULL,
  `contents` VARCHAR(200) NOT NULL,
  `fromUser` INT NOT NULL,
  PRIMARY KEY (`idexperience`),
  INDEX `fromUser_idx` (`fromUser` ASC) VISIBLE,
  CONSTRAINT `fromUser`
    FOREIGN KEY (`fromUser`)
    REFERENCES `IMIS_Vision2.0`.`Users` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`user` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);


-- -----------------------------------------------------
-- Table `IMIS_Vision2.0`.`user_1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IMIS_Vision2.0`.`user_1` (
  `username` VARCHAR(16) NOT NULL,
  `email` VARCHAR(255) NULL,
  `password` VARCHAR(32) NOT NULL,
  `create_time` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
