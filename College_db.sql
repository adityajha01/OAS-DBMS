-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 06, 2021 at 06:12 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `College_db`
--
CREATE DATABASE IF NOT EXISTS `College_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `College_db`;

-- --------------------------------------------------------

--
-- Table structure for table `Alogin`
--

DROP TABLE IF EXISTS `Alogin`;
CREATE TABLE `Alogin` (
  `UserID` int(40) NOT NULL,
  `Password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `Class`
--

DROP TABLE IF EXISTS `Class`;
CREATE TABLE `Class` (
  `name` varchar(45) NOT NULL,
  `meets_at` varchar(45) NOT NULL,
  `room` varchar(45) NOT NULL,
  `fid` int(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Class`
--

INSERT INTO `Class` (`name`, `meets_at`, `room`, `fid`) VALUES
('Air Quality Engineering', 'TuTh 10:30-11:45', 'R15', 11564812),
('American Political Parties', 'TuTh 2-3:15', '20 AVW', 619023588),
('Archaeology of the Incas', 'MWF 3-4:15', 'R128', 248965255),
('Aviation Accident Investigation', 'TuTh 1-2:50', 'Q3', 11564812),
('Communication Networks', 'MW 9:30-10:45', '20 AVW', 141582651),
('Dairy Herd Management', 'TuTh 12:30-1:45', 'R128', 356187925),
('Data Structures', 'MWF 10', 'R128', 489456522),
('Database Systems', 'MWF 12:30-1:45', '1320 DCL', 142519864),
('Intoduction to Math', 'TuTh 8-9:30', 'R128', 489221823),
('Introductory Latin', 'MWF 3-4:15', 'R12', 248965255),
('Marketing Research', 'MW 10-11:15', '1320 DCL', 489221823),
('Multivariate Analysis', 'TuTh 2-3:15', 'R15', 90873519),
('Operating System Design', 'TuTh 12-1:20', '20 AVW', 489456522),
('Optical Electronics', 'TuTh 12:30-1:45', 'R15', 254099823),
('Organic Chemistry', 'TuTh 12:30-1:45', 'R12', 489221823),
('Patent Law', 'F 1-2:50', 'R128', 90873519),
('Perception', 'MTuWTh 3', 'Q3', 489221823),
('Seminar in American Art', 'M 4', 'R15', 489221823),
('Social Cognition', 'Tu 6:30-8:40', 'R15', 159542516),
('Urban Economics', 'MWF 11', '20 AVW', 489221823);

--
-- Triggers `Class`
--
DROP TRIGGER IF EXISTS `threec`;
DELIMITER $$
CREATE TRIGGER `threec` AFTER INSERT ON `Class` FOR EACH ROW begin
DECLARE a int;
DECLARE b int;
set a=(select COUNT(*) from Class where fid=new.fid);
set b=(select deptid from Faculty where fid=new.fid);
if a > 3 AND b!=33
THEN
SIGNAL
SQLSTATE '45088' set MESSAGE_TEXT='teacher cannot take more than 3 courses in the department';
end IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Enrolled`
--

DROP TABLE IF EXISTS `Enrolled`;
CREATE TABLE `Enrolled` (
  `snum` int(25) NOT NULL,
  `cname` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Enrolled`
--

INSERT INTO `Enrolled` (`snum`, `cname`) VALUES
(112348546, 'Database Systems'),
(115987938, 'Database Systems'),
(348121549, 'Database Systems'),
(322654189, 'Database Systems'),
(552455318, 'Database Systems'),
(455798411, 'Operating System Design'),
(552455318, 'Operating System Design'),
(567354612, 'Operating System Design'),
(112348546, 'Operating System Design'),
(115987938, 'Operating System Design'),
(322654189, 'Operating System Design'),
(567354612, 'Data Structures'),
(552455318, 'Communication Networks'),
(301221823, 'Perception'),
(301221823, 'Social Cognition'),
(301221823, 'American Political Parties'),
(556784565, 'Air Quality Engineering'),
(99354543, 'Patent Law'),
(574489456, 'Urban Economics'),
(455798411, 'Optical Electronics'),
(455798411, 'Data Structures'),
(455798411, 'Patent Law'),
(455798411, 'Introductory Latin'),
(51135593, 'Organic Chemistry');

--
-- Triggers `Enrolled`
--
DROP TRIGGER IF EXISTS `math101`;
DELIMITER $$
CREATE TRIGGER `math101` BEFORE DELETE ON `Enrolled` FOR EACH ROW BEGIN
IF old.cname ='Math 101' THEN SIGNAL SQLSTATE '45088' set MESSAGE_TEXT=" Math 101 can not be dropped";
END IF;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `range30`;
DELIMITER $$
CREATE TRIGGER `range30` BEFORE INSERT ON `Enrolled` FOR EACH ROW BEGIN
DECLARE	a INT;
SET a = (SELECT COUNT(DISTINCT snum) FROM Enrolled WHERE cname= new.cname);
IF a >= 30 and new.cname <> 'Math 101'
THEN
SIGNAL
SQLSTATE '45088' set MESSAGE_TEXT = 'cannot Exceed 30 students ';
end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Faculty`
--

DROP TABLE IF EXISTS `Faculty`;
CREATE TABLE `Faculty` (
  `fid` int(25) NOT NULL,
  `fname` varchar(45) NOT NULL,
  `deptid` int(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Faculty`
--

INSERT INTO `Faculty` (`fid`, `fname`, `deptid`) VALUES
(11564812, 'John Williams', 68),
(90873519, 'Elizabeth Taylor', 11),
(141582651, 'Mary Johnson', 20),
(142519864, 'Ivana Teach', 20),
(159542516, 'William Moore', 33),
(242518965, 'James Smith', 68),
(248965255, 'Barbara Wilson', 12),
(254099823, 'Patricia Jones', 68),
(287321212, 'Michael Miller', 12),
(356187925, 'Robert Brown', 12),
(486512566, 'David Anderson', 20),
(489221823, 'Richard Jackson', 33),
(489456522, 'Linda Davis', 20),
(548977562, 'Ulysses Teach', 20),
(619023588, 'Jennifer Thomas', 11);

--
-- Triggers `Faculty`
--
DROP TRIGGER IF EXISTS `deaprtment`;
DELIMITER $$
CREATE TRIGGER `deaprtment` AFTER INSERT ON `Faculty` FOR EACH ROW BEGIN
DECLARE a int;
set a=(select COUNT(*) from Faculty where deptid =new.deptid);
if a >10
THEN SIGNAL
SQLSTATE '45088' SET MESSAGE_TEXT='Maximum limit(10) of faculty is reached in this department ';
end if;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Flogin`
--

DROP TABLE IF EXISTS `Flogin`;
CREATE TABLE `Flogin` (
  `UserID` int(35) NOT NULL,
  `Password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Flogin`
--

INSERT INTO `Flogin` (`UserID`, `Password`) VALUES
(11564812, 'John Williams'),
(90873519, 'Elizabeth Taylor'),
(141582651, 'Mary Johnson'),
(142519864, 'Ivana Teach'),
(159542516, 'William Moore'),
(242518965, 'James Smith'),
(248965255, 'Barbara Wilson'),
(254099823, 'Patricia Jones'),
(287321212, 'Michael Miller'),
(356187925, 'Robert Brown'),
(486512566, 'David Anderson'),
(489221823, 'Richard Jackson'),
(489456522, 'Linda Davis'),
(548977562, 'Ulysses Teach'),
(619023588, 'Jennifer Thomas');

-- --------------------------------------------------------

--
-- Table structure for table `Login`
--

DROP TABLE IF EXISTS `Login`;
CREATE TABLE `Login` (
  `UserID` int(50) NOT NULL,
  `Password` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Login`
--

INSERT INTO `Login` (`UserID`, `Password`) VALUES
(51135593, 'Maria White'),
(60839453, 'Charles Harris'),
(99354543, 'Susan Martin'),
(112348546, 'Joseph Thompson'),
(115987938, 'Christopher Garcia'),
(132977562, 'Angela Martinez'),
(269734834, 'Thomas Robinson'),
(280158572, 'Margaret Clark'),
(301221823, 'Juan Rodriguez'),
(318548912, 'Dorthy Lewis'),
(320874981, 'Daniel Lee'),
(322654189, 'Lisa Walker'),
(348121549, 'Paul Hall'),
(351565322, 'Nancy Allen'),
(451519864, 'Mark Young'),
(455798411, 'Luis Hernandez'),
(462156489, 'Donald King'),
(550156548, 'George Wright'),
(552455318, 'Ana Lopez'),
(556784565, 'Kenneth Hill'),
(567354612, 'Karen Scott'),
(573284895, 'Steven Green'),
(574489456, 'Betty Adams'),
(578875478, 'Edward Baker');

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
CREATE TABLE `Student` (
  `snum` int(25) NOT NULL,
  `sname` varchar(45) NOT NULL,
  `major` varchar(45) NOT NULL,
  `level` varchar(45) NOT NULL,
  `age` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `Student`
--

INSERT INTO `Student` (`snum`, `sname`, `major`, `level`, `age`) VALUES
(51135593, 'Maria White', 'English', 'SR', 21),
(60839453, 'Charles Harris', 'Architecture', 'SR', 22),
(99354543, 'Susan Martin', 'Law', 'JR', 20),
(112348546, 'Joseph Thompson', 'Computer Science', 'SO', 19),
(115987938, 'Christopher Garcia', 'Computer Science', 'JR', 20),
(132977562, 'Angela Martinez', 'History', 'SR', 20),
(269734834, 'Thomas Robinson', 'Psychology', 'SO', 18),
(280158572, 'Margaret Clark', 'Animal Science', 'FR', 18),
(301221823, 'Juan Rodriguez', 'Psychology', 'JR', 20),
(318548912, 'Dorthy Lewis', 'Finance', 'FR', 18),
(320874981, 'Daniel Lee', 'Electrical Engineering', 'FR', 17),
(322654189, 'Lisa Walker', 'Computer Science', 'SO', 17),
(348121549, 'Paul Hall', 'Computer Science', 'JR', 18),
(351565322, 'Nancy Allen', 'Accounting', 'JR', 19),
(451519864, 'Mark Young', 'Finance', 'FR', 18),
(455798411, 'Luis Hernandez', 'Electrical Engineering', 'FR', 17),
(462156489, 'Donald King', 'Mechanical Engineering', 'SO', 19),
(550156548, 'George Wright', 'Education', 'SR', 21),
(552455318, 'Ana Lopez', 'Computer Engineering', 'SR', 19),
(556784565, 'Kenneth Hill', 'Civil Engineering', 'SR', 21),
(567354612, 'Karen Scott', 'Computer Engineering', 'FR', 18),
(573284895, 'Steven Green', 'Kinesiology', 'SO', 19),
(574489456, 'Betty Adams', 'Economics', 'JR', 20),
(578875478, 'Edward Baker', 'Veterinary Medicine', 'SR', 21);

--
-- Triggers `Student`
--
DROP TRIGGER IF EXISTS `majorcs`;
DELIMITER $$
CREATE TRIGGER `majorcs` AFTER INSERT ON `Student` FOR EACH ROW BEGIN
declare a int;
DECLARE b int;
set a=(select COUNT(*) from Student where major ='Computer Science');
set b= (select COUNT(*) from Student where major ='Math');
if b>a 
THEN
SIGNAL
SQLSTATE '45088' set MESSAGE_TEXT='Math major can not be taken';
end if;
END
$$
DELIMITER ;
DROP TRIGGER IF EXISTS `stu`;
DELIMITER $$
CREATE TRIGGER `stu` AFTER INSERT ON `Student` FOR EACH ROW BEGIN
insert into Enrolled VALUES(new.snum, 'Math 101');
END
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Alogin`
--
ALTER TABLE `Alogin`
  ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `Class`
--
ALTER TABLE `Class`
  ADD PRIMARY KEY (`name`),
  ADD KEY `f_id` (`fid`);

--
-- Indexes for table `Enrolled`
--
ALTER TABLE `Enrolled`
  ADD KEY `s_num` (`snum`),
  ADD KEY `c_name` (`cname`);

--
-- Indexes for table `Faculty`
--
ALTER TABLE `Faculty`
  ADD PRIMARY KEY (`fid`);

--
-- Indexes for table `Login`
--
ALTER TABLE `Login`
  ADD PRIMARY KEY (`UserID`);

--
-- Indexes for table `Student`
--
ALTER TABLE `Student`
  ADD PRIMARY KEY (`snum`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Class`
--
ALTER TABLE `Class`
  ADD CONSTRAINT `Class_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `Faculty` (`fid`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Enrolled`
--
ALTER TABLE `Enrolled`
  ADD CONSTRAINT `Enrolled_ibfk_1` FOREIGN KEY (`snum`) REFERENCES `Student` (`snum`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Enrolled_ibfk_2` FOREIGN KEY (`cname`) REFERENCES `Class` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
