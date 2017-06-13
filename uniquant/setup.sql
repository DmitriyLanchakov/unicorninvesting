CREATE DATABASE IF NOT EXISTS `uniquant`;

USE `uniquant`;

DROP TABLE IF EXISTS `uniquant_holding_forex`;
DROP TABLE IF EXISTS `uniquant_holding`;
DROP TABLE IF EXISTS `uniquant_portfolio`;
DROP TABLE IF EXISTS `uniquant_users`;

CREATE TABLE `uniquant_users` (
  `ID`          BIGINT(20)     NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `username`    VARCHAR(50)    NOT NULL UNIQUE,
  `firstname`   VARCHAR(255)   NOT NULL,
  `lastname`    VARCHAR(255)   NOT NULL,
  `email`       VARCHAR(320)   NOT NULL UNIQUE,
  `password`    VARCHAR(255)   NOT NULL,
  `dob`         DATETIME       NOT NULL,
  `gender`      TINYINT	       NOT NULL
  -- `dor`         DATETIME     NOT NULL -- date of registration
);

CREATE TABLE `uniquant_portfolio` (
  `ID`          BIGINT(20)     NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `userID`      BIGINT(20)     NOT NULL,
  `name`        VARCHAR(255)   NOT NULL,
  FOREIGN KEY (`userID`)       REFERENCES `uniquant_users`(`ID`)
);

CREATE TABLE `uniquant_holding` (
  `ID`          BIGINT(20)      NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `portfolioID` BIGINT(20)      NOT NULL,
  `type`        VARCHAR(255)    NOT NULL,
  FOREIGN KEY (`portfolioID`)   REFERENCES `uniquant_portfolio`(`ID`)
);

CREATE TABLE `uniquant_holding_forex` (
  `ID`          BIGINT(20)     NOT NULL AUTO_INCREMENT PRIMARY KEY,
  `holdingID`   BIGINT(20)     NOT NULL,
  `from`        VARCHAR(3)     NOT NULL,
  `to`          VARCHAR(3)     NOT NULL,
  `amount`      DECIMAL(10, 2)
);
