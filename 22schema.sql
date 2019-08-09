CREATE DATABASE  IF NOT EXISTS `MirandaDatabase` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `MirandaDatabase`;
-- MySQL dump 10.13  Distrib 8.0.16, for macos10.14 (x86_64)
--
-- Host: Mydatabase.cputfd1eymsx.us-east-1.rds.amazonaws.com    Database: MirandaDatabase
-- ------------------------------------------------------
-- Server version	5.7.22-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `aircraft`
--

DROP TABLE IF EXISTS `aircraft`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `aircraft` (
  `FAAID` int(11) NOT NULL,
  `maxCapacity` int(11) NOT NULL,
  `name` varchar(45) NOT NULL,
  `ownedBy` varchar(2) NOT NULL,
  PRIMARY KEY (`FAAID`),
  KEY `ownedBy_idx` (`ownedBy`),
  CONSTRAINT `ownedBy` FOREIGN KEY (`ownedBy`) REFERENCES `airline` (`twoLetterID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `aircraft`
--

LOCK TABLES `aircraft` WRITE;
/*!40000 ALTER TABLE `aircraft` DISABLE KEYS */;
INSERT INTO `aircraft` VALUES (101,100,'Boeing 737','AA'),(102,100,'Airbus A380','AA'),(103,100,'Boeing 737','DL'),(104,100,'Airbus A380','DL'),(105,100,'Airbus A380','FA'),(106,100,'Boeing 737','FA'),(107,100,'Airbus A380','JB'),(108,100,'Boeing 737','JB'),(109,100,'Airbus A380','UA'),(110,100,'Boeing 737','UA'),(111,3,'Stealth Hawk','UA'),(112,120,'Boeing 737','UA');
/*!40000 ALTER TABLE `aircraft` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airline`
--

DROP TABLE IF EXISTS `airline`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `airline` (
  `twoLetterID` varchar(40) NOT NULL,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`twoLetterID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airline`
--

LOCK TABLES `airline` WRITE;
/*!40000 ALTER TABLE `airline` DISABLE KEYS */;
INSERT INTO `airline` VALUES ('AA','American Airlines'),('DL','Delta Airlines'),('FA','Frontier Airlines'),('JB','Jet Blue'),('UA','United Airlines');
/*!40000 ALTER TABLE `airline` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `airport`
--

DROP TABLE IF EXISTS `airport`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `airport` (
  `threeLetterID` char(3) NOT NULL,
  `name` varchar(45) NOT NULL,
  `city` varchar(45) NOT NULL,
  `state` varchar(2) NOT NULL,
  PRIMARY KEY (`threeLetterID`),
  KEY `city` (`city`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `airport`
--

LOCK TABLES `airport` WRITE;
/*!40000 ALTER TABLE `airport` DISABLE KEYS */;
INSERT INTO `airport` VALUES ('EWR','Newark International Airport','Newark','NJ'),('HKG','Hong Kong International Airport','Hong Kong','Ch'),('JFK','John F Kennedy International Airport','New York','NY'),('LAX','Los Angeles International Airport','Los Angeles','CA'),('MAD','Madrid-Barajas Adolfo Suarez Airport','Madrid','Sp'),('MCO','Orlando International Airport','Orlando','FL'),('SEA','Seattle-Tacoma International Airport','Seattle','WA');
/*!40000 ALTER TABLE `airport` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flight`
--

DROP TABLE IF EXISTS `flight`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `flight` (
  `FAAID` int(11) NOT NULL,
  `threeLetterID_Departs` char(3) NOT NULL,
  `threeLetterID_Arrives` char(3) NOT NULL,
  `flightNumber` int(11) NOT NULL,
  `currentCapacity` int(11) DEFAULT NULL,
  `isDomestic` int(11) NOT NULL,
  `daysOfWeek` varchar(45) NOT NULL,
  `departsDateTime` datetime NOT NULL,
  `arrivesDateTime` datetime NOT NULL,
  `departCity` varchar(45) NOT NULL,
  `arriveCity` varchar(45) NOT NULL,
  `price` varchar(45) NOT NULL,
  `numStops` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`FAAID`,`threeLetterID_Departs`,`threeLetterID_Arrives`,`flightNumber`),
  KEY `threeletterID_arrives_idx` (`threeLetterID_Arrives`),
  KEY `threeletterID_departs_idx` (`threeLetterID_Departs`),
  KEY `departCity_idx` (`departCity`),
  KEY `arrivesCity_idx` (`arriveCity`),
  KEY `flightNumber` (`flightNumber`),
  CONSTRAINT `FAAID` FOREIGN KEY (`FAAID`) REFERENCES `aircraft` (`FAAID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `arrivesCity` FOREIGN KEY (`arriveCity`) REFERENCES `airport` (`city`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `departCity` FOREIGN KEY (`departCity`) REFERENCES `airport` (`city`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `threeLetterID_Arrives` FOREIGN KEY (`threeLetterID_Arrives`) REFERENCES `airport` (`threeLetterID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `threeLetterID_Departs` FOREIGN KEY (`threeLetterID_Departs`) REFERENCES `airport` (`threeLetterID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flight`
--

LOCK TABLES `flight` WRITE;
/*!40000 ALTER TABLE `flight` DISABLE KEYS */;
INSERT INTO `flight` VALUES (101,'HKG','EWR',17,2,0,'Monday','2019-09-09 02:00:00','2019-09-09 18:00:00','Hong Kong','Newark','3000',2),(101,'HKG','LAX',14,0,0,'Friday','2019-09-06 06:00:00','2019-09-07 05:00:00','Hong Kong','Los Angeles','2270',0),(101,'JFK','LAX',1,0,1,'Tuesday','2019-09-03 12:00:00','2019-09-03 15:00:00','New York','Los Angeles','1500',1),(101,'LAX','MAD',15,0,0,'Saturday','2019-09-07 06:00:00','2019-09-08 02:00:00','Los Angeles','Madrid','3000',1),(101,'LAX','SEA',12,0,1,'Wednesday','2019-09-04 03:00:00','2019-09-04 05:30:00','Los Angeles','Seattle','400',0),(101,'MAD','HKG',16,0,0,'Sunday','2019-09-08 03:00:00','2019-09-08 22:00:00','Madrid','Hong Kong','2800',1),(101,'SEA','HKG',13,2,0,'Thursday','2019-09-05 01:00:00','2019-09-06 05:00:00','Seattle','Hong Kong','3500',0),(102,'EWR','HKG',2,0,0,'Tuesday','2019-09-03 10:00:00','2019-09-04 13:00:00','Newark','Hong Kong','3100',1),(102,'HKG','LAX',18,0,0,'Wednesday','2019-09-04 14:00:00','2019-09-05 13:00:00','Hong Kong','Los Angeles','2300',1),(102,'JFK','MCO',23,2,1,'Monday','2019-09-09 15:00:00','2019-09-09 17:30:00','New York','Orlando','500',0),(102,'LAX','MCO',19,0,1,'Thursday','2019-09-05 14:00:00','2019-09-05 22:00:00','Los Angeles','Orlando','2000',1),(102,'MAD','JFK',22,1,0,'Sunday','2019-09-08 04:00:00','2019-09-08 06:30:00','Madrid','New York','2800',1),(102,'MCO','SEA',20,100,1,'Friday','2019-09-06 17:00:00','2019-09-06 20:00:00','Orlando','Seattle','680',0),(102,'SEA','MAD',21,0,0,'Saturday','2019-09-07 01:00:00','2019-09-08 02:30:00','Seattle','Madrid','3500',2),(103,'HKG','LAX',29,0,0,'Monday','2019-09-08 13:00:00','2019-09-09 12:00:00','Hong Kong','Los Angeles','2700',0),(103,'JFK','MCO',26,0,1,'Friday','2019-09-06 16:00:00','2019-09-06 18:30:00','New York','Orlando','700',0),(103,'LAX','JFK',25,0,1,'Thursday','2019-09-05 01:00:00','2019-09-05 09:30:00','Los Angeles','New York','800',0),(103,'MAD','HKG',28,0,0,'Sunday','2019-09-08 17:00:00','2019-09-09 12:00:00','Madrid','Hong Kong','4000',0),(103,'MCO','MAD',27,0,0,'Saturday','2019-09-06 01:00:00','2019-09-07 16:00:00','Orlando','Madrid','3700',1),(103,'MCO','SEA',3,3,1,'Tuesday','2019-09-03 03:00:00','2019-09-03 06:00:00','Orlando','Seattle','500',1),(103,'SEA','LAX',24,0,1,'Wednesday','2019-09-04 04:00:00','2019-09-04 06:30:00','Seattle','Los Angeles','400',0),(104,'HKG','MAD',30,0,0,'Wednesday','2019-09-04 10:00:00','2019-09-05 01:30:00','Hong Kong','Madrid','3500',1),(104,'JFK','MCO',32,0,1,'Friday','2019-09-06 13:30:00','2019-09-06 16:00:00','New York','Orlando','450',0),(104,'LAX','JFK',35,0,1,'Monday','2019-09-09 06:00:00','2019-09-09 14:30:00','Los Angeles','New York','1000',0),(104,'MAD','JFK',31,0,0,'Thursday','2019-09-05 02:30:00','2019-09-05 05:00:00','Madrid','New York','2600',0),(104,'MCO','SEA',33,0,1,'Saturday','2019-09-07 17:00:00','2019-09-07 20:00:00','Orlando','Seattle','300',0),(104,'SEA','HKG',4,0,0,'Tuesday','2019-09-03 05:00:00','2019-09-04 09:00:00','Seattle','Hong Kong','4500',1),(104,'SEA','LAX',34,0,1,'Sunday','2019-09-08 16:30:00','2019-09-08 19:00:00','Seattle','Los Angeles','400',0),(105,'EWR','MCO',36,0,1,'Wednesday','2019-09-04 05:00:00','2019-09-04 07:30:00','Newark','Orlando','880',0),(105,'HKG','MAD',40,0,0,'Sunday','2019-09-08 15:30:00','2019-09-09 07:00:00','Hong Kong','Madrid','3500',0),(105,'JFK','LAX',38,0,1,'Friday','2019-09-06 12:00:00','2019-09-06 15:00:00','New York','Los Angeles','700',0),(105,'LAX','HKG',39,0,0,'Saturday','2019-09-07 09:00:00','2019-09-08 14:30:00','Los Angeles','Hong Kong','2200',0),(105,'MAD','EWR',5,0,0,'Tuesday','2019-09-03 01:00:00','2019-09-03 03:30:00','Madrid','Newark','2300',1),(105,'MAD','JFK',41,0,0,'Monday','2019-09-09 08:00:00','2019-09-09 10:30:00','Madrid','New York','2500',0),(105,'MCO','JFK',37,2,1,'Thursday','2019-09-05 19:00:00','2019-09-05 21:30:00','Orlando','New York','250',0),(106,'HKG','JFK',6,1,0,'Tuesday','2019-09-03 02:00:00','2019-09-03 18:00:00','Hong Kong','New York','2600',2),(106,'JFK','LAX',42,0,1,'Wednesday','2019-09-04 19:00:00','2019-09-04 22:00:00','New York','Los Angeles','1000',1),(106,'LAX','MCO',43,0,1,'Thursday','2019-09-05 07:30:00','2019-09-05 15:30:00','Los Angeles','Orlando','800',1),(106,'MAD','EWR',47,0,0,'Monday','2019-09-09 17:00:00','2019-09-09 19:30:00','Madrid','Newark','900',0),(106,'MCO','MAD',46,0,0,'Sunday','2019-09-08 01:00:00','2019-09-09 16:00:00','Orlando','Madrid','3400',0),(106,'MCO','SEA',44,2,1,'Friday','2019-09-06 05:30:00','2019-09-06 08:30:00','Orlando','Seattle','700',1),(106,'SEA','MCO',45,12,1,'Saturday','2019-09-07 01:30:00','2019-09-07 10:30:00','Seattle','Orlando','800',0),(107,'EWR','LAX',7,3,1,'Tuesday','2019-09-03 09:30:00','2019-09-03 12:30:00','Newark','Los Angeles','500',0),(107,'LAX','JFK',53,0,1,'Monday','2019-09-09 02:30:00','2019-09-09 11:00:00','Los Angeles','New York','700',0),(107,'LAX','MCO',50,0,1,'Friday','2019-09-06 07:00:00','2019-09-06 15:00:00','Los Angeles','Orlando','400',0),(107,'LAX','SEA',48,0,1,'Wednesday','2019-09-04 07:30:00','2019-09-04 10:00:00','Los Angeles','Seattle','200',0),(107,'MCO','SEA',51,0,1,'Saturday','2019-09-07 07:30:00','2019-09-07 10:30:00','Orlando','Seattle','300',0),(107,'SEA','LAX',49,0,1,'Thursday','2019-09-05 07:30:00','2019-09-05 10:00:00','Seattle','Los Angeles','200',0),(107,'SEA','LAX',52,0,1,'Sunday','2019-09-08 06:30:00','2019-09-08 09:00:00','Seattle','Los Angeles','300',0),(108,'EWR','MCO',57,0,1,'Saturday','2019-09-07 16:30:00','2019-09-07 19:00:00','Newark','Orlando','400',0),(108,'JFK','SEA',55,1,1,'Thursday','2019-09-05 07:00:00','2019-09-05 16:00:00','New York','Seattle','500',0),(108,'JFK','SEA',59,0,1,'Monday','2019-09-09 08:00:00','2019-09-09 11:00:00','New York','Seattle','600',1),(108,'LAX','MAD',8,0,0,'Tuesday','2019-09-03 15:00:00','2019-09-04 11:00:00','Los Angeles','Madrid','4000',2),(108,'MAD','JFK',54,0,0,'Wednesday','2019-09-04 09:30:00','2019-09-04 12:00:00','Madrid','New York','2400',0),(108,'MCO','JFK',58,0,1,'Sunday','2019-09-08 16:30:00','2019-09-08 19:00:00','Orlando','New York','210',0),(108,'SEA','EWR',56,0,1,'Friday','2019-09-06 08:30:00','2019-09-06 16:30:00','Seattle','Newark','324',0),(109,'EWR','MCO',61,0,1,'Thursday','2019-09-05 16:30:00','2019-09-05 19:00:00','Newark','Orlando','532',0),(109,'HKG','MAD',9,0,0,'Tuesday','2019-09-03 00:00:00','2019-09-03 15:30:00','Hong Kong','Madrid','4320',1),(109,'HKG','SEA',65,0,0,'Monday','2019-09-09 11:30:00','2019-09-09 20:30:00','Hong Kong','Seattle','3450',0),(109,'LAX','HKG',64,0,0,'Sunday','2019-09-08 05:00:00','2019-09-09 10:30:00','Los Angeles','Hong Kong','2300',0),(109,'MAD','EWR',60,0,0,'Wednesday','2019-09-04 10:00:00','2019-09-04 12:30:00','Madrid','Newark','2150',0),(109,'MCO','SEA',62,3,1,'Friday','2019-09-06 16:30:00','2019-09-06 19:30:00','Orlando','Seattle','350',2),(109,'SEA','LAX',63,0,1,'Saturday','2019-09-07 02:30:00','2019-09-07 05:00:00','Seattle','Los Angeles','340',0),(110,'EWR','MCO',10,0,1,'Tuesday','2019-09-03 15:00:00','2019-09-03 17:30:00','Newark','Orlando','250',0),(110,'JFK','LAX',67,0,1,'Thursday','2019-09-05 04:30:00','2019-09-05 07:30:00','New York','Los Angeles','1000',0),(110,'JFK','MAD',70,0,0,'Sunday','2019-09-08 01:00:00','2019-09-08 14:00:00','New York','Madrid','2300',1),(110,'LAX','MCO',68,0,1,'Friday','2019-09-06 01:30:00','2019-09-06 09:30:00','Los Angeles','Orlando','2300',1),(110,'MAD','LAX',71,0,0,'Monday','2019-09-09 15:30:00','2019-09-09 19:00:00','Madrid','Los Angeles','3000',1),(110,'MCO','JFK',66,1,1,'Wednesday','2019-09-04 04:00:00','2019-09-04 06:30:00','Orlando','New York','340',0),(110,'MCO','JFK',69,2,1,'Saturday','2019-09-07 04:30:00','2019-09-07 07:00:00','Orlando','New York','380',0),(111,'EWR','MCO',74,0,1,'Friday','2019-09-06 09:00:00','2019-09-06 11:30:00','Newark','Orlando','450',0),(111,'HKG','EWR',77,0,0,'Monday','2019-09-09 14:00:00','2019-09-10 06:00:00','Hong Kong','Newark','5000',2),(111,'HKG','LAX',72,0,0,'Wednesday','2019-09-04 23:30:00','2019-09-05 22:30:00','Hong Kong','Los Angeles','3500',1),(111,'JFK','HKG',11,0,0,'Tuesday','2019-09-03 18:00:00','2019-09-04 22:30:00','New York','Hong Kong','5400',2),(111,'LAX','EWR',73,0,1,'Thursday','2019-09-05 23:30:00','2019-09-06 08:00:00','Los Angeles','Newark','700',0),(111,'MAD','HKG',76,0,0,'Sunday','2019-09-08 18:00:00','2019-09-09 13:00:00','Madrid','Hong Kong','8000',0),(111,'MCO','MAD',75,0,0,'Saturday','2019-09-07 02:00:00','2019-09-08 17:00:00','Orlando','Madrid','3000',1),(112,'MCO','SEA',78,2,1,'Monday','2019-09-09 03:00:00','2019-09-09 06:00:00','Orlando','Seattle','1000',1);
/*!40000 ALTER TABLE `flight` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ticket` (
  `ticketNumber` int(11) NOT NULL AUTO_INCREMENT,
  `userID` varchar(45) NOT NULL,
  `name` varchar(45) NOT NULL,
  `flightNumberA` int(11) NOT NULL,
  `seatNumberA` int(11) NOT NULL,
  `flightNumberB` int(11) DEFAULT NULL,
  `seatNumberB` int(11) DEFAULT NULL,
  `class` varchar(45) NOT NULL,
  `meal` int(10) NOT NULL,
  `purchaseDateTime` datetime NOT NULL,
  `totalFare` varchar(45) NOT NULL,
  PRIMARY KEY (`ticketNumber`),
  KEY `userID_idx` (`userID`),
  KEY `flightNumberB_idx` (`flightNumberB`),
  KEY `fligthNumberA_idx` (`flightNumberA`),
  KEY `name` (`name`),
  CONSTRAINT `flightNumberA` FOREIGN KEY (`flightNumberA`) REFERENCES `flight` (`flightNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `flightNumberB` FOREIGN KEY (`flightNumberB`) REFERENCES `flight` (`flightNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `name` FOREIGN KEY (`name`) REFERENCES `user` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `userID` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (62,'Amazing','Yusdel',22,100,70,100,'First',0,'2019-08-07 19:21:02','5200'),(63,'Amazing','Yusdel',17,99,NULL,NULL,'Business',1,'2019-08-07 19:56:07','3065'),(69,'Amazing','Yusdel',20,100,NULL,NULL,'First',1,'2019-08-07 20:50:11','795'),(71,'Amazing','Yusdel',37,100,NULL,NULL,'First',0,'2019-08-07 21:07:23','350'),(74,'Amazing','Yusdel',66,100,NULL,NULL,'Business',0,'2019-08-07 22:34:16','390'),(82,'Kitty','Catherine Katz',45,96,NULL,NULL,'First',0,'2019-08-07 23:53:34','900'),(86,'v','Vee',45,94,78,120,'Business',0,'2019-08-08 14:55:42','1850'),(88,'Kitty','Catherine Katz',69,99,NULL,NULL,'Economy',0,'2019-08-08 15:00:24','380'),(89,'Kitty','Catherine Katz',45,92,NULL,NULL,'First',0,'2019-08-08 15:14:43','900'),(90,'Kitty','Catherine Katz',45,91,NULL,NULL,'Business',0,'2019-08-08 15:16:05','850'),(91,'Kitty','Catherine Katz',45,90,NULL,NULL,'First',0,'2019-08-08 15:18:48','900'),(92,'Flame','Fire',55,100,NULL,NULL,'First',0,'2019-08-08 15:21:22','600'),(93,'Spidey','Peter Parker',3,99,NULL,NULL,'First',0,'2019-08-08 15:22:28','600'),(94,'Kitty','Catherine Katz',45,89,NULL,NULL,'Business',0,'2019-08-08 15:23:41','850'),(98,'flame','Fire',7,100,73,3,'First',1,'2019-08-08 20:09:43','1315'),(99,'v','Vee',78,120,45,88,'Business',1,'2019-08-08 20:51:43','1865'),(100,'Flame','Fire',22,100,NULL,NULL,'First',1,'2019-08-08 21:51:04','2915'),(101,'v','Vee',6,100,NULL,NULL,'First',1,'2019-08-09 02:25:07','2715'),(103,'kitty','Catherine Katz',7,98,NULL,NULL,'First',1,'2019-08-09 02:46:13','615');
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `user` (
  `userID` varchar(12) NOT NULL,
  `password` varchar(12) NOT NULL,
  `name` varchar(45) NOT NULL,
  `isEmployee` int(11) DEFAULT '0',
  `isAdmin` int(11) DEFAULT '0',
  PRIMARY KEY (`userID`),
  KEY `name` (`name`),
  KEY `userID` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('a','b','a',0,0),('admin','10','admin',0,0),('Amazing','123','Yusdel',0,0),('cs336','Password','Bob',0,0),('cust','pass','cust rep',1,0),('custRep','Password','cust rep',1,0),('Flame','123','Fire',0,0),('FOOFOO','Fighters','Dave',0,0),('Frosty','123','Yusdel',0,0),('Harry','Potter','Harry',0,0),('hello','Pass','My name',0,0),('Hi','Bye','Mike',0,0),('kitty','Fluffy1234','Catherine Katz',0,0),('New','123','Yusdel',0,1),('NewOne','Test','Scott',0,0),('nyFootball','password','Eli Manning',1,0),('rjb348','myPass','Bob',1,1),('Rutgers','CS336','Jeff',0,0),('Spidey','Password','Peter Parker',1,0),('Test','Yusdel','Travis',0,0),('TomH','hello','Tom',0,0),('TomHHH','cat','Tommy',0,0),('v','v','Vee',0,0),('YusdelTest','123','Sherlock',0,0);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `waitingList`
--

DROP TABLE IF EXISTS `waitingList`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `waitingList` (
  `positionInLine` int(5) NOT NULL AUTO_INCREMENT,
  `userID` varchar(12) NOT NULL,
  `flightNumber` int(11) NOT NULL,
  PRIMARY KEY (`positionInLine`),
  KEY `flightID_idx` (`flightNumber`),
  KEY `userID` (`userID`),
  CONSTRAINT `flightNumber` FOREIGN KEY (`flightNumber`) REFERENCES `flight` (`flightNumber`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `waitingList_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `waitingList`
--

LOCK TABLES `waitingList` WRITE;
/*!40000 ALTER TABLE `waitingList` DISABLE KEYS */;
INSERT INTO `waitingList` VALUES (1,'Hi',20),(3,'Harry',20),(4,'v',20),(5,'v',20),(6,'v',20),(20,'Kitty',20),(21,'Kitty',20),(22,'Flame',20),(23,'Kitty',20),(24,'Flame',20),(25,'v',20),(26,'v',20),(27,'v',20);
/*!40000 ALTER TABLE `waitingList` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-08-09  0:21:33
