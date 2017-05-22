-- MySQL dump 10.13  Distrib 5.5.38, for Linux (i686)
--
-- Host: mysql    Database: u3mk
-- ------------------------------------------------------
-- Server version	5.5.38

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `ALL_SPEAKERS`
--

DROP TABLE IF EXISTS `ALL_SPEAKERS`;
/*!50001 DROP VIEW IF EXISTS `ALL_SPEAKERS`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `ALL_SPEAKERS` (
  `pno` tinyint NOT NULL,
  `fname` tinyint NOT NULL,
  `lname` tinyint NOT NULL,
  `confno` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `CONFERENCE_PAPERS`
--

DROP TABLE IF EXISTS `CONFERENCE_PAPERS`;
/*!50001 DROP VIEW IF EXISTS `CONFERENCE_PAPERS`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `CONFERENCE_PAPERS` (
  `date_from` tinyint NOT NULL,
  `no_papers_presented` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `attendee`
--

DROP TABLE IF EXISTS `attendee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendee` (
  `pno` int(11) NOT NULL,
  `fname` varchar(15) NOT NULL,
  `lname` varchar(15) NOT NULL,
  `university_no` int(11) NOT NULL,
  PRIMARY KEY (`pno`),
  KEY `university_no` (`university_no`),
  CONSTRAINT `attendee_ibfk_1` FOREIGN KEY (`university_no`) REFERENCES `university` (`unino`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendee`
--

LOCK TABLES `attendee` WRITE;
/*!40000 ALTER TABLE `attendee` DISABLE KEYS */;
INSERT INTO `attendee` VALUES (1,'Michael','Wooldridge',1),(2,'Paul','Dunne',1),(3,'Trevor','Bench-Capon',1),(4,'Philippe','Besnard',3),(5,'Anthony','Hunter',2),(6,'Sylvie','Doutre',3),(7,'Henry','Prakken',4),(8,'Phan','Min Dung',5),(9,'Pietro','Baroni',6),(10,'Guillermo','Simari',7),(11,'Massimiliano','Giacomin',6),(12,'Douglas','Walton',8),(13,'Gerhard','Brewka',9),(14,'Bart','Verheij',10),(15,'Stefan','Szeider',11),(16,'Stefan','Woltran',11),(17,'Erik','Krabe',10),(18,'Keith','Stenning',12),(19,'Simon','Parsons',1),(20,'Nir','Oren',13),(21,'Chris','Reed',14);
/*!40000 ALTER TABLE `attendee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attends`
--

DROP TABLE IF EXISTS `attends`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attends` (
  `conference_no` int(11) NOT NULL,
  `p_no` int(11) NOT NULL,
  `position` varchar(20) NOT NULL,
  KEY `conference_no` (`conference_no`),
  KEY `p_no` (`p_no`),
  CONSTRAINT `attends_ibfk_1` FOREIGN KEY (`conference_no`) REFERENCES `conference` (`confno`),
  CONSTRAINT `attends_ibfk_2` FOREIGN KEY (`p_no`) REFERENCES `attendee` (`pno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attends`
--

LOCK TABLES `attends` WRITE;
/*!40000 ALTER TABLE `attends` DISABLE KEYS */;
INSERT INTO `attends` VALUES (1,1,'Chair'),(1,2,'Chair'),(1,3,'Chair'),(2,4,'Chair'),(2,5,'Chair'),(2,6,'Chair'),(2,7,'Invited Speaker'),(2,8,'Invited Speaker'),(3,9,'Chair'),(3,10,'Chair'),(3,11,'Chair'),(3,12,'Invited Speaker'),(3,13,'Invited Speaker'),(4,14,'Chair'),(4,15,'Chair'),(4,16,'Chair'),(4,17,'Invited Speaker'),(4,18,'Invited Speaker'),(4,3,'Invited Speaker'),(5,19,'Chair'),(5,20,'Chair'),(5,21,'Chair'),(5,2,'Invited Speaker');
/*!40000 ALTER TABLE `attends` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `booking` (
  `tutorialID` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) NOT NULL DEFAULT '',
  `questions` text,
  PRIMARY KEY (`email`),
  KEY `tutorialID` (`tutorialID`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`tutorialID`) REFERENCES `tutorial` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conference`
--

DROP TABLE IF EXISTS `conference`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conference` (
  `confno` int(11) NOT NULL,
  `date_from` date NOT NULL,
  `date_to` date NOT NULL,
  `location_no` int(11) NOT NULL,
  `no_papers_presented` int(11) DEFAULT NULL,
  PRIMARY KEY (`confno`),
  KEY `location_no` (`location_no`),
  CONSTRAINT `conference_ibfk_1` FOREIGN KEY (`location_no`) REFERENCES `location` (`locno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conference`
--

LOCK TABLES `conference` WRITE;
/*!40000 ALTER TABLE `conference` DISABLE KEYS */;
INSERT INTO `conference` VALUES (1,'2006-09-11','2006-09-12',1,30),(2,'2008-05-28','2006-05-30',2,38),(3,'2010-09-08','2006-09-10',3,42),(4,'2012-09-10','2012-09-12',4,58),(5,'2014-09-09','2014-09-11',5,NULL);
/*!40000 ALTER TABLE `conference` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `dname` varchar(25) NOT NULL,
  `dnumber` int(4) NOT NULL DEFAULT '0',
  `mgrssn` char(9) NOT NULL,
  `mgrstartdate` date DEFAULT NULL,
  PRIMARY KEY (`dnumber`),
  KEY `dname` (`dname`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('Headquarters',1,'888665555','1971-06-19'),('Administration',4,'987654321','1985-01-01'),('Research',5,'333445555','1978-05-22'),('Software',6,'111111100','1999-05-15'),('Hardware',7,'444444400','1998-05-15'),('Sales',8,'555555500','1997-01-01');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dependent`
--

DROP TABLE IF EXISTS `dependent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dependent` (
  `essn` char(9) NOT NULL DEFAULT '',
  `dependent_name` varchar(15) NOT NULL DEFAULT '',
  `sex` char(1) DEFAULT NULL,
  `bdate` date DEFAULT NULL,
  `relationship` varchar(8) DEFAULT NULL,
  PRIMARY KEY (`essn`,`dependent_name`),
  CONSTRAINT `dependent_ibfk_1` FOREIGN KEY (`essn`) REFERENCES `employee` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dependent`
--

LOCK TABLES `dependent` WRITE;
/*!40000 ALTER TABLE `dependent` DISABLE KEYS */;
INSERT INTO `dependent` VALUES ('123456789','Alice','F','1978-12-31','Daughter'),('123456789','Elizabeth','F','0000-00-00','Spouse'),('123456789','Michael','M','1978-01-01','Son'),('333445555','Alice','F','1976-04-05','Daughter'),('333445555','Joy','F','1948-05-03','Spouse'),('333445555','Theodore','M','1973-10-25','Son'),('444444400','Johnny','M','1997-04-04','Son'),('444444400','Tommy','M','1999-06-07','Son'),('444444401','Chris','M','1969-04-19','Spouse'),('444444402','Sam','M','1964-02-14','Spouse'),('987654321','Abner','M','1932-02-29','Spouse');
/*!40000 ALTER TABLE `dependent` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dept_locations`
--

DROP TABLE IF EXISTS `dept_locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dept_locations` (
  `dnumber` int(4) NOT NULL DEFAULT '0',
  `dlocation` varchar(15) NOT NULL DEFAULT '',
  PRIMARY KEY (`dnumber`,`dlocation`),
  CONSTRAINT `dept_locations_ibfk_1` FOREIGN KEY (`dnumber`) REFERENCES `department` (`dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dept_locations`
--

LOCK TABLES `dept_locations` WRITE;
/*!40000 ALTER TABLE `dept_locations` DISABLE KEYS */;
INSERT INTO `dept_locations` VALUES (1,'Houston'),(4,'Stafford'),(5,'Bellaire'),(5,'Houston'),(5,'Sugarland'),(6,'Atlanta'),(6,'Sacramento'),(7,'Milwaukee'),(8,'Chicago'),(8,'Dallas'),(8,'Miami'),(8,'Philadephia'),(8,'Seattle');
/*!40000 ALTER TABLE `dept_locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employee` (
  `fname` varchar(15) NOT NULL,
  `minit` varchar(1) DEFAULT NULL,
  `lname` varchar(15) NOT NULL,
  `ssn` char(9) NOT NULL DEFAULT '',
  `bdate` date DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  `sex` char(1) DEFAULT NULL,
  `salary` decimal(10,2) DEFAULT NULL,
  `superssn` char(9) DEFAULT NULL,
  `dno` int(4) DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  KEY `superssn` (`superssn`),
  KEY `dno` (`dno`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`superssn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`dno`) REFERENCES `department` (`dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('Jared','D','James','111111100','1966-10-10','123 Peachtree, Atlanta, GA','M',85000.00,NULL,6),('Jon','C','Jones','111111101','1967-11-14','111 Allgood, Atlanta, GA','M',45000.00,'111111100',6),('Justin','n','Mark','111111102','1966-01-12','2342 May, Atlanta, GA','M',40000.00,'111111100',6),('Brad','C','Knight','111111103','1968-02-13','176 Main St., Atlanta, GA','M',44000.00,'111111100',6),('John','B','Smith','123456789','1955-01-09','731 Fondren, Houston, TX','M',30000.00,'333445555',5),('Evan','E','Wallis','222222200','1958-01-16','134 Pelham, Milwaukee, WI','M',92000.00,NULL,7),('Josh','U','Zell','222222201','1954-05-22','266 McGrady, Milwaukee, WI','M',56000.00,'222222200',7),('Andy','C','Vile','222222202','1944-06-21','1967 Jordan, Milwaukee, WI','M',53000.00,'222222200',7),('Tom','G','Brand','222222203','1966-12-16','112 Third St, Milwaukee, WI','M',62500.00,'222222200',7),('Jenny','F','Vos','222222204','1967-11-11','263 Mayberry, Milwaukee, WI','F',61000.00,'222222201',7),('Chris','A','Carter','222222205','1960-03-21','565 Jordan, Milwaukee, WI','F',43000.00,'222222201',7),('Kim','C','Grace','333333300','1970-10-23','6677 Mills Ave, Sacramento, CA','F',79000.00,NULL,6),('Jeff','H','Chase','333333301','1970-01-07','145 Bradbury, Sacramento, CA','M',44000.00,'333333300',6),('Franklin','T','Wong','333445555','1945-12-08','638 Voss, Houston, TX','M',40000.00,'888665555',5),('Alex','D','Freed','444444400','1950-10-09','4333 Pillsbury, Milwaukee, WI','M',89000.00,NULL,7),('Bonnie','S','Bays','444444401','1956-06-19','111 Hollow, Milwaukee, WI','F',70000.00,'444444400',7),('Alec','C','Best','444444402','1966-06-18','233 Solid, Milwaukee, WI','M',60000.00,'444444400',7),('Sam','S','Snedden','444444403','1977-07-31','987 Windy St, Milwaukee, WI','M',48000.00,'444444400',7),('Joyce','A','English','453453453','1962-07-31','5631 Rice, Houston, TX','F',25000.00,'333445555',5),('John','C','James','555555500','1975-06-30','7676 Bloomington, Sacramento, CA','M',81000.00,NULL,6),('Nandita','K','Ball','555555501','1969-04-16','222 Howard, Sacramento, CA','M',62000.00,'555555500',6),('Bob','B','Bender','666666600','1968-04-17','8794 Garfield, Chicago, IL','M',96000.00,NULL,8),('Jill','J','Jarvis','666666601','1966-01-14','6234 Lincoln, Chicago, IL','F',36000.00,'666666600',8),('Kate','W','King','666666602','1966-04-16','1976 Boone Trace, Chicago, IL','F',44000.00,'666666600',8),('Lyle','G','Leslie','666666603','1963-06-09','417 Hancock Ave, Chicago, IL','M',41000.00,'666666601',8),('Billie','J','King','666666604','1960-01-01','556 Washington, Chicago, IL','F',38000.00,'666666603',8),('Jon','A','Kramer','666666605','1964-08-22','1988 Windy Creek, Seattle, WA','M',41500.00,'666666603',8),('Ray','H','King','666666606','1949-08-16','213 Delk Road, Seattle, WA','M',44500.00,'666666604',8),('Gerald','D','Small','666666607','1962-05-15','122 Ball Street, Dallas, TX','M',29000.00,'666666602',8),('Arnold','A','Head','666666608','1967-05-19','233 Spring St, Dallas, TX','M',33000.00,'666666602',8),('Helga','C','Pataki','666666609','1969-03-11','101 Holyoke St, Dallas, TX','F',32000.00,'666666602',8),('Naveen','B','Drew','666666610','1970-05-23','198 Elm St, Philadelphia, PA','M',34000.00,'666666607',8),('Carl','E','Reedy','666666611','1977-06-21','213 Ball St, Philadelphia, PA','M',32000.00,'666666610',8),('Sammy','G','Hall','666666612','1970-01-11','433 Main Street, Miami, FL','M',37000.00,'666666611',8),('Red','A','Bacher','666666613','1980-05-21','196 Elm Street, Miami, FL','M',33500.00,'666666612',8),('Ramesh','K','Narayan','666884444','1952-09-15','971 Fire Oak, Humble, TX','M',38000.00,'333445555',5),('James','E','Borg','888665555','1927-11-10','450 Stone, Houston, TX','M',55000.00,NULL,1),('Jennifer','S','Wallace','987654321','1931-06-20','291 Berry, Bellaire, TX','F',43000.00,'888665555',4),('Ahmad','V','Jabbar','987987987','1959-03-29','980 Dallas, Houston, TX','M',25000.00,'987654321',4),('Alicia','J','Zelaya','999887777','1958-07-19','3321 Castle, Spring, TX','F',25000.00,'987654321',4);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `locno` int(11) NOT NULL,
  `city` varchar(40) NOT NULL,
  `country` varchar(20) NOT NULL,
  PRIMARY KEY (`locno`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES (1,'Liverpool','UK'),(2,'Toulouse','France'),(3,'Desenzano','Italy'),(4,'Vienna','Austria'),(5,'Pittlochry','UK');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meetings`
--

DROP TABLE IF EXISTS `meetings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meetings` (
  `slot` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`slot`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meetings`
--

LOCK TABLES `meetings` WRITE;
/*!40000 ALTER TABLE `meetings` DISABLE KEYS */;
INSERT INTO `meetings` VALUES (1,'Michael North','M.North@student.liverpool.ac.uk'),(5,'Jody Land','J.Land@student.liverpool.ac.uk'),(7,'Trish Shelby','T.Shelby@studnet.liverpool.ac.uk');
/*!40000 ALTER TABLE `meetings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `project`
--

DROP TABLE IF EXISTS `project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `project` (
  `pname` varchar(25) NOT NULL,
  `pnumber` int(4) NOT NULL DEFAULT '0',
  `plocation` varchar(15) DEFAULT NULL,
  `dnum` int(4) NOT NULL,
  PRIMARY KEY (`pnumber`),
  UNIQUE KEY `pname` (`pname`),
  KEY `dnum` (`dnum`),
  CONSTRAINT `project_ibfk_1` FOREIGN KEY (`dnum`) REFERENCES `department` (`dnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `project`
--

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;
INSERT INTO `project` VALUES ('ProductX',1,'Bellaire',5),('ProductY',2,'Sugarland',5),('ProductZ',3,'Houston',5),('Computerization',10,'Stafford',4),('Reorganization',20,'Houston',1),('Newbenefits',30,'Stafford',4),('OperatingSystems',61,'Jacksonville',6),('DatabaseSystems',62,'Birmingham',6),('Middleware',63,'Jackson',6),('InkjetPrinters',91,'Phoenix',7),('LaserPrinters',92,'LasVegas',7);
/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `num` int(11) NOT NULL,
  `name` varchar(15) DEFAULT NULL,
  `email` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'floriana','flo@liv.ac.uk'),(3,'Ladidadida','Ladidadida@liv.');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tutorial`
--

DROP TABLE IF EXISTS `tutorial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tutorial` (
  `id` int(11) NOT NULL,
  `day` varchar(20) DEFAULT NULL,
  `time` varchar(20) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tutorial`
--

LOCK TABLES `tutorial` WRITE;
/*!40000 ALTER TABLE `tutorial` DISABLE KEYS */;
INSERT INTO `tutorial` VALUES (1,'Monday','9:00-10:00',2),(2,'Monday','11:00-12:00',2),(3,'Tuesday','9:00-10:00',2),(4,'Tuesday','14:00-15:00',2),(5,'Wednesday','9:00-10:00',2);
/*!40000 ALTER TABLE `tutorial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `university`
--

DROP TABLE IF EXISTS `university`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `university` (
  `unino` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `country` varchar(20) NOT NULL,
  PRIMARY KEY (`unino`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `university`
--

LOCK TABLES `university` WRITE;
/*!40000 ALTER TABLE `university` DISABLE KEYS */;
INSERT INTO `university` VALUES (1,'University of Liverpool','UK'),(2,'UCL','UK'),(3,'IRIT Toulouse','France'),(4,'University of Utrecht','The Netherlands'),(5,'Asian Institute of Technologies','Thailand'),(6,'University of Brescia','Italy'),(7,'Universidad Nacional del Sur','Argentina'),(8,'University of Windsor','Canada'),(9,'University of Leipzig','Germany'),(10,'University of Groningen','The Netherlands'),(11,'Vienna University of Technology','Austria'),(12,'University of Edinburgh','UK'),(13,'University of Aberdeen','UK'),(14,'University of Dundee','UK');
/*!40000 ALTER TABLE `university` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `works_on`
--

DROP TABLE IF EXISTS `works_on`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `works_on` (
  `essn` char(9) NOT NULL DEFAULT '',
  `pno` int(4) NOT NULL DEFAULT '0',
  `hours` decimal(4,1) DEFAULT NULL,
  PRIMARY KEY (`essn`,`pno`),
  KEY `pno` (`pno`),
  CONSTRAINT `works_on_ibfk_1` FOREIGN KEY (`essn`) REFERENCES `employee` (`ssn`),
  CONSTRAINT `works_on_ibfk_2` FOREIGN KEY (`pno`) REFERENCES `project` (`pnumber`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `works_on`
--

LOCK TABLES `works_on` WRITE;
/*!40000 ALTER TABLE `works_on` DISABLE KEYS */;
INSERT INTO `works_on` VALUES ('111111100',61,40.0),('111111101',61,40.0),('111111102',61,40.0),('111111103',61,40.0),('123456789',1,32.5),('123456789',2,7.5),('222222200',62,40.0),('222222201',62,48.0),('222222202',62,40.0),('222222203',62,40.0),('222222204',62,40.0),('222222205',62,40.0),('333333300',63,40.0),('333333301',63,46.0),('333445555',2,10.0),('333445555',3,10.0),('333445555',10,10.0),('333445555',20,10.0),('444444400',91,40.0),('444444401',91,40.0),('444444402',91,40.0),('444444403',91,40.0),('453453453',1,20.0),('453453453',2,20.0),('555555500',92,40.0),('555555501',92,44.0),('666666601',91,40.0),('666666603',91,40.0),('666666604',91,40.0),('666666605',92,40.0),('666666606',91,40.0),('666666607',61,40.0),('666666608',62,40.0),('666666609',63,40.0),('666666610',61,40.0),('666666611',61,40.0),('666666612',61,40.0),('666666613',61,30.0),('666666613',62,10.0),('666666613',63,10.0),('666884444',3,40.0),('888665555',20,0.0),('987654321',20,15.0),('987654321',30,20.0),('987987987',10,35.0),('987987987',30,5.0),('999887777',10,10.0),('999887777',30,30.0);
/*!40000 ALTER TABLE `works_on` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `ALL_SPEAKERS`
--

/*!50001 DROP TABLE IF EXISTS `ALL_SPEAKERS`*/;
/*!50001 DROP VIEW IF EXISTS `ALL_SPEAKERS`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`u3mk`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `ALL_SPEAKERS` AS select `attendee`.`pno` AS `pno`,`attendee`.`fname` AS `fname`,`attendee`.`lname` AS `lname`,`conference`.`confno` AS `confno` from ((`attendee` left join `attends` on(((`attendee`.`pno` = `attends`.`p_no`) and (`attends`.`position` = 'Invited Speaker')))) left join `conference` on((`conference`.`confno` = `attends`.`conference_no`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CONFERENCE_PAPERS`
--

/*!50001 DROP TABLE IF EXISTS `CONFERENCE_PAPERS`*/;
/*!50001 DROP VIEW IF EXISTS `CONFERENCE_PAPERS`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`u3mk`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `CONFERENCE_PAPERS` AS select `conference`.`date_from` AS `date_from`,`conference`.`no_papers_presented` AS `no_papers_presented` from `conference` where (`conference`.`no_papers_presented` > 0) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-03-24 15:35:35
