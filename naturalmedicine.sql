-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.20-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for naturalmedicine
CREATE DATABASE IF NOT EXISTS `naturalmedicine` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `naturalmedicine`;

-- Dumping structure for table naturalmedicine.herbs
CREATE TABLE IF NOT EXISTS `herbs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `Picture` blob,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- Dumping data for table naturalmedicine.herbs: ~11 rows (approximately)
/*!40000 ALTER TABLE `herbs` DISABLE KEYS */;
INSERT INTO `herbs` (`id`, `name`, `Picture`) VALUES
	(1, 'Ехинацея', NULL),
	(2, 'Плод от бъз', NULL),
	(3, 'Джинджифил', NULL),
	(4, 'Андрографис', NULL),
	(5, 'Еупаториум', NULL),
	(6, 'Лайка', NULL),
	(7, 'Евкалипт', NULL),
	(8, 'Слез', NULL),
	(9, 'Котешки нокът', NULL),
	(10, 'Хвойна', NULL),
	(13, 'Бор', NULL);
/*!40000 ALTER TABLE `herbs` ENABLE KEYS */;

-- Dumping structure for table naturalmedicine.herbs_viruses_symptoms
CREATE TABLE IF NOT EXISTS `herbs_viruses_symptoms` (
  `herb_id` int(11) NOT NULL DEFAULT '0',
  `virus_symptom_id` int(11) NOT NULL DEFAULT '0',
  KEY `herb_id` (`herb_id`),
  KEY `virus_symptom_id` (`virus_symptom_id`),
  CONSTRAINT `fk_herb_id` FOREIGN KEY (`herb_id`) REFERENCES `herbs` (`id`),
  CONSTRAINT `fk_virus_symptom_id` FOREIGN KEY (`virus_symptom_id`) REFERENCES `viruses_symptoms` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table naturalmedicine.herbs_viruses_symptoms: ~16 rows (approximately)
/*!40000 ALTER TABLE `herbs_viruses_symptoms` DISABLE KEYS */;
INSERT INTO `herbs_viruses_symptoms` (`herb_id`, `virus_symptom_id`) VALUES
	(6, 5),
	(7, 8),
	(4, 7),
	(13, 3),
	(6, 5),
	(7, 8),
	(4, 7),
	(13, 3),
	(6, 5),
	(7, 8),
	(4, 7),
	(13, 3),
	(6, 5),
	(7, 8),
	(4, 7),
	(13, 3);
/*!40000 ALTER TABLE `herbs_viruses_symptoms` ENABLE KEYS */;

-- Dumping structure for table naturalmedicine.symptoms
CREATE TABLE IF NOT EXISTS `symptoms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `medicaments_id` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;

-- Dumping data for table naturalmedicine.symptoms: ~19 rows (approximately)
/*!40000 ALTER TABLE `symptoms` DISABLE KEYS */;
INSERT INTO `symptoms` (`id`, `name`, `medicaments_id`) VALUES
	(1, 'Висока температура', NULL),
	(2, 'Болки в ставите и мускулите', NULL),
	(3, 'Чувство на умора', NULL),
	(4, 'Зачервена кожа', NULL),
	(5, 'Главоболие', NULL),
	(6, 'Суха кашлича', NULL),
	(7, 'Влажна кашлица', NULL),
	(8, 'Възпалено и болезнено гърло', NULL),
	(9, 'Запушен нос', NULL),
	(10, 'Повръщане', NULL),
	(11, 'Диария', NULL),
	(12, 'Болка в областта на бузите', NULL),
	(13, 'Зачервяване на носа', NULL),
	(14, 'Зачервяване на бузите', NULL),
	(15, 'Болки в областта на слепоочието', NULL),
	(16, 'Секреция от носа', NULL),
	(17, 'Дразнене на гърлото', NULL),
	(18, 'Болка в областта на лицето', NULL),
	(19, 'Намалено обоняние', NULL);
/*!40000 ALTER TABLE `symptoms` ENABLE KEYS */;

-- Dumping structure for table naturalmedicine.users
CREATE TABLE IF NOT EXISTS `users` (
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(100) DEFAULT NULL,
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table naturalmedicine.users: ~2 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`email`, `password`, `username`) VALUES
	('a@a', 'ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb', 'a'),
	('b@b.b', '3e23e8160039594a33894f6564e1b1348bbd7a0088d42c4acb73eeaed59c009d', 'b');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table naturalmedicine.viruses
CREATE TABLE IF NOT EXISTS `viruses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL DEFAULT '0',
  `medicaments_id` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- Dumping data for table naturalmedicine.viruses: ~1 rows (approximately)
/*!40000 ALTER TABLE `viruses` DISABLE KEYS */;
INSERT INTO `viruses` (`id`, `name`, `medicaments_id`) VALUES
	(1, 'Грип', NULL),
	(2, 'Синузит', NULL);
/*!40000 ALTER TABLE `viruses` ENABLE KEYS */;

-- Dumping structure for table naturalmedicine.viruses_symptoms
CREATE TABLE IF NOT EXISTS `viruses_symptoms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `virus_id` int(11) NOT NULL,
  `symptom_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `virus_id` (`virus_id`),
  KEY `symptom_id` (`symptom_id`),
  CONSTRAINT `viruses_symptoms_ibfk_1` FOREIGN KEY (`virus_id`) REFERENCES `viruses` (`id`),
  CONSTRAINT `viruses_symptoms_ibfk_2` FOREIGN KEY (`symptom_id`) REFERENCES `symptoms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8;

-- Dumping data for table naturalmedicine.viruses_symptoms: ~21 rows (approximately)
/*!40000 ALTER TABLE `viruses_symptoms` DISABLE KEYS */;
INSERT INTO `viruses_symptoms` (`id`, `virus_id`, `symptom_id`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 1, 3),
	(4, 1, 4),
	(5, 1, 5),
	(6, 1, 6),
	(7, 1, 8),
	(8, 1, 9),
	(9, 1, 10),
	(10, 1, 11),
	(11, 1, 16),
	(12, 2, 12),
	(13, 2, 13),
	(14, 2, 14),
	(15, 2, 15),
	(16, 2, 16),
	(17, 2, 17),
	(18, 2, 18),
	(19, 2, 19),
	(20, 2, 9),
	(21, 2, 6);
/*!40000 ALTER TABLE `viruses_symptoms` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
