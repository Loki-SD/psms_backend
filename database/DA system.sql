/*
SQLyog Community v13.3.1 (64 bit)
MySQL - 8.0.44 : Database - psms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`psms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `psms`;

/*Table structure for table `bpar_i_person` */

DROP TABLE IF EXISTS `bpar_i_person`;

CREATE TABLE `bpar_i_person` (
  `bpar_i_person_id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(150) DEFAULT NULL,
  `bpar_i_type_id` bigint DEFAULT NULL,
  `firstname` varchar(100) DEFAULT NULL,
  `middlename` varchar(100) DEFAULT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `tin` varchar(100) DEFAULT NULL,
  `email_add` varchar(150) DEFAULT NULL,
  `company_name` varchar(100) DEFAULT NULL,
  `sex` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `contact_number` varchar(15) DEFAULT NULL,
  `fax_number` varchar(50) DEFAULT NULL,
  `birthday` varchar(50) DEFAULT NULL,
  `identifiication_number` varchar(100) DEFAULT NULL,
  `marital_status` varchar(5) DEFAULT NULL,
  `description` text,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`bpar_i_person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `bpar_i_person` */

insert  into `bpar_i_person`(`bpar_i_person_id`,`name`,`bpar_i_type_id`,`firstname`,`middlename`,`lastname`,`tin`,`email_add`,`company_name`,`sex`,`contact_number`,`fax_number`,`birthday`,`identifiication_number`,`marital_status`,`description`,`date_created`,`created`,`date_updated`,`updated`,`is_active`) values 
(5,'admin',NULL,'admin','','Admin',NULL,NULL,NULL,'Female',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-21 00:00:00',NULL,NULL,NULL,1),
(6,'admin',NULL,'admin','','Admin',NULL,NULL,NULL,'Female',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-21 00:00:00',NULL,NULL,NULL,1),
(7,'admin',NULL,'admin','','Admin',NULL,NULL,NULL,'Female',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-21 10:02:23',NULL,NULL,NULL,1),
(8,'admin',NULL,'admin','','Admin',NULL,NULL,NULL,'Female',NULL,NULL,NULL,NULL,NULL,NULL,'2025-11-21 10:17:50',NULL,NULL,NULL,1);

/*Table structure for table `function` */

DROP TABLE IF EXISTS `function`;

CREATE TABLE `function` (
  `function_id` bigint NOT NULL AUTO_INCREMENT,
  `function_name` varchar(50) DEFAULT NULL,
  `description` text,
  `is_super_admin` tinyint(1) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`function_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `function` */

/*Table structure for table `function_logs` */

DROP TABLE IF EXISTS `function_logs`;

CREATE TABLE `function_logs` (
  `function_logs_id` bigint NOT NULL AUTO_INCREMENT,
  `function_id` bigint DEFAULT NULL,
  `function_name` varchar(100) DEFAULT NULL,
  `description` text,
  `is_super_admin` tinyint(1) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `logs_action` enum('ADD','UPDATE','DELETE','ACTIVATE','DEACTIVATE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `logs_status` enum('PENDING','APPROVED','REJECTED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bparIPersonIdMaker` bigint DEFAULT NULL,
  `bparIPersonIdChecker` bigint DEFAULT NULL,
  PRIMARY KEY (`function_logs_id`),
  KEY `function_id` (`function_id`),
  KEY `bparIPersonIdMaker` (`bparIPersonIdMaker`),
  KEY `bparIPersonIdChecker` (`bparIPersonIdChecker`),
  CONSTRAINT `function_logs_ibfk_1` FOREIGN KEY (`function_id`) REFERENCES `function` (`function_id`),
  CONSTRAINT `function_logs_ibfk_2` FOREIGN KEY (`bparIPersonIdMaker`) REFERENCES `bpar_i_person` (`bpar_i_person_id`),
  CONSTRAINT `function_logs_ibfk_3` FOREIGN KEY (`bparIPersonIdChecker`) REFERENCES `bpar_i_person` (`bpar_i_person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `function_logs` */

/*Table structure for table `reset_password` */

DROP TABLE IF EXISTS `reset_password`;

CREATE TABLE `reset_password` (
  `reset_password_id` bigint NOT NULL AUTO_INCREMENT,
  `old_password` text,
  `new_password` text,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `email` text,
  PRIMARY KEY (`reset_password_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `reset_password` */

/*Table structure for table `reset_password_logs` */

DROP TABLE IF EXISTS `reset_password_logs`;

CREATE TABLE `reset_password_logs` (
  `reset_password_logs_id` bigint NOT NULL AUTO_INCREMENT,
  `reset_password_id` bigint DEFAULT NULL,
  `old_password` text,
  `new_password` text,
  `logs_action` enum('ADD','UPDATE','DELETE','ACTIVATE','DEACTIVATE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `logs_status` enum('PENDING','APPROVED','REJECTED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bparIPersonIdMaker` bigint DEFAULT NULL,
  `bparIPersonIdChecker` bigint DEFAULT NULL,
  `email` text,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`reset_password_logs_id`),
  KEY `reset_password_id` (`reset_password_id`),
  KEY `bparIPersonIdMaker` (`bparIPersonIdMaker`),
  KEY `bparIPersonIdChecker` (`bparIPersonIdChecker`),
  CONSTRAINT `reset_password_logs_ibfk_1` FOREIGN KEY (`reset_password_id`) REFERENCES `reset_password` (`reset_password_id`),
  CONSTRAINT `reset_password_logs_ibfk_2` FOREIGN KEY (`bparIPersonIdMaker`) REFERENCES `bpar_i_person` (`bpar_i_person_id`),
  CONSTRAINT `reset_password_logs_ibfk_3` FOREIGN KEY (`bparIPersonIdChecker`) REFERENCES `bpar_i_person` (`bpar_i_person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `reset_password_logs` */

/*Table structure for table `role` */

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `role_id` bigint NOT NULL AUTO_INCREMENT,
  `role` varchar(150) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `role` */

insert  into `role`(`role_id`,`role`,`date_created`,`created`,`date_updated`,`updated`,`is_active`) values 
(1,'ADMIN','2025-11-20 00:00:00',NULL,NULL,NULL,1),
(2,'GUEST','2025-11-20 00:00:00',NULL,NULL,NULL,1);

/*Table structure for table `role_logs` */

DROP TABLE IF EXISTS `role_logs`;

CREATE TABLE `role_logs` (
  `role_logs_id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint DEFAULT NULL,
  `role` varchar(50) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `logs_action` enum('ADD','UPDATE','DELETE','ACTIVATE','DEACTIVATE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `logs_status` enum('PENDING','APPROVED','REJECTED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bparIPersonIdMaker` bigint DEFAULT NULL,
  `bparIPersonIdChecker` bigint DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`role_logs_id`),
  KEY `role_id` (`role_id`),
  KEY `bparIPersonIdMaker` (`bparIPersonIdMaker`),
  KEY `bparIPersonIdChecker` (`bparIPersonIdChecker`),
  CONSTRAINT `role_logs_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`),
  CONSTRAINT `role_logs_ibfk_2` FOREIGN KEY (`bparIPersonIdMaker`) REFERENCES `bpar_i_person` (`bpar_i_person_id`),
  CONSTRAINT `role_logs_ibfk_3` FOREIGN KEY (`bparIPersonIdChecker`) REFERENCES `bpar_i_person` (`bpar_i_person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `role_logs` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(150) DEFAULT NULL,
  `username` varchar(50) DEFAULT NULL,
  `password` text,
  `deactivated_date` datetime DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user` */

insert  into `user`(`user_id`,`email`,`username`,`password`,`deactivated_date`) values 
(4,'admin@example.com','admin','$2b$10$8SKJ74NTAUi6vARcGwR2GeOe7f7buRDuS3hceaq.s4is5K/NpvzV.',NULL),
(5,'admin@example.com','admin','$2b$10$.eJhlFjpdO1c39IzE7NrwuTNuvZZ7LIMmW1Ke1RcmjxIS2Lk.TX0W',NULL),
(6,'admin@example.com','admin','$2b$10$xhiagwD09NzdolGzQ6RyaO1SHf8kIRGcjSoY/QRj32zdFPolT2Dme',NULL),
(7,'admin@example.com','admin','$2b$10$0pQZ7WLbQuhp1hG1yf5y1exz1Nqi3TxwwrniW22DlrlJw4SKSmZqS',NULL);

/*Table structure for table `user_account` */

DROP TABLE IF EXISTS `user_account`;

CREATE TABLE `user_account` (
  `user_account_id` bigint NOT NULL AUTO_INCREMENT,
  `explanation` text,
  `date_registered` datetime DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_otp_approve` tinyint(1) DEFAULT NULL,
  `bpar_i_person_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`user_account_id`),
  KEY `bpar_i_person_id` (`bpar_i_person_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_account_ibfk_1` FOREIGN KEY (`bpar_i_person_id`) REFERENCES `bpar_i_person` (`bpar_i_person_id`),
  CONSTRAINT `user_account_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user_account` */

insert  into `user_account`(`user_account_id`,`explanation`,`date_registered`,`date_created`,`created`,`date_updated`,`updated`,`is_active`,`is_otp_approve`,`bpar_i_person_id`,`user_id`) values 
(4,NULL,'2025-11-21 00:00:00','2025-11-21 00:00:00',NULL,NULL,NULL,1,NULL,5,4),
(5,NULL,'2025-11-21 00:00:00','2025-11-21 00:00:00',NULL,NULL,NULL,1,NULL,6,5),
(6,NULL,'2025-11-21 10:02:24','2025-11-21 10:02:24',NULL,NULL,NULL,1,NULL,7,6),
(7,NULL,'2025-11-21 10:17:50','2025-11-21 10:17:50',NULL,NULL,NULL,1,NULL,8,7);

/*Table structure for table `user_account_logs` */

DROP TABLE IF EXISTS `user_account_logs`;

CREATE TABLE `user_account_logs` (
  `user_account_logs_id` bigint NOT NULL AUTO_INCREMENT,
  `user_account_id` bigint DEFAULT NULL,
  `explanation` text,
  `date_registered` datetime DEFAULT NULL,
  `is_otp_approve` tinyint(1) DEFAULT NULL,
  `bpar_i_person_id` bigint DEFAULT NULL,
  `logs_action` enum('NEW','UPDATE','DELETE','ACTIVATE','DEACTIVATE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `logs_status` enum('PENDING','APPROVED','REJECTED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bparIPersonIdMaker` bigint DEFAULT NULL,
  `bparIPersonIdChecker` bigint DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_account_logs_id`),
  KEY `user_account_id` (`user_account_id`),
  KEY `bparIPersonIdMaker` (`bparIPersonIdMaker`),
  KEY `bparIPersonIdChecker` (`bparIPersonIdChecker`),
  CONSTRAINT `user_account_logs_ibfk_1` FOREIGN KEY (`user_account_id`) REFERENCES `user_account` (`user_account_id`),
  CONSTRAINT `user_account_logs_ibfk_2` FOREIGN KEY (`bparIPersonIdMaker`) REFERENCES `bpar_i_person` (`bpar_i_person_id`),
  CONSTRAINT `user_account_logs_ibfk_3` FOREIGN KEY (`bparIPersonIdChecker`) REFERENCES `bpar_i_person` (`bpar_i_person_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user_account_logs` */

insert  into `user_account_logs`(`user_account_logs_id`,`user_account_id`,`explanation`,`date_registered`,`is_otp_approve`,`bpar_i_person_id`,`logs_action`,`logs_status`,`bparIPersonIdMaker`,`bparIPersonIdChecker`,`date_created`,`created`,`date_updated`,`updated`,`is_active`) values 
(1,4,NULL,'2025-11-21 00:00:00',NULL,5,'NEW','APPROVED',5,NULL,'2025-11-21 00:00:00',NULL,NULL,NULL,1),
(2,5,NULL,'2025-11-21 00:00:00',NULL,6,'NEW','APPROVED',6,NULL,'2025-11-21 00:00:00',NULL,NULL,NULL,1),
(3,6,NULL,'2025-11-21 10:02:24',NULL,7,'NEW','APPROVED',7,NULL,'2025-11-21 10:02:24',NULL,NULL,NULL,1),
(4,7,NULL,'2025-11-21 10:17:50',NULL,8,'NEW','APPROVED',8,NULL,'2025-11-21 10:17:50',NULL,NULL,NULL,1);

/*Table structure for table `user_role_matching` */

DROP TABLE IF EXISTS `user_role_matching`;

CREATE TABLE `user_role_matching` (
  `user_role_matching_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `is_active` bigint DEFAULT NULL,
  PRIMARY KEY (`user_role_matching_id`),
  KEY `user_id` (`user_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role_matching_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `user_role_matching_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user_role_matching` */

insert  into `user_role_matching`(`user_role_matching_id`,`user_id`,`role_id`,`date_created`,`created`,`date_updated`,`updated`,`is_active`) values 
(1,4,1,'2025-11-20 00:00:00',NULL,NULL,NULL,1),
(2,5,1,'2025-11-20 00:00:00',NULL,NULL,NULL,1),
(3,6,1,'2025-11-20 00:00:00',NULL,NULL,NULL,1),
(4,7,1,'2025-11-20 00:00:00',NULL,NULL,NULL,1),
(8,4,2,'2025-11-21 00:00:00',NULL,NULL,NULL,1),
(9,5,2,'2025-11-21 00:00:00',NULL,NULL,NULL,1),
(10,6,2,'2025-11-21 10:02:24',NULL,NULL,NULL,1),
(11,7,2,'2025-11-21 10:17:50',NULL,NULL,NULL,1);

/*Table structure for table `user_role_matching_logs` */

DROP TABLE IF EXISTS `user_role_matching_logs`;

CREATE TABLE `user_role_matching_logs` (
  `user_role_atching_logs_id` bigint NOT NULL AUTO_INCREMENT,
  `user_role_matching_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `role_id` bigint DEFAULT NULL,
  `role_function_matching_id` bigint DEFAULT NULL,
  `logs_action` enum('NEW','UPDATE','DELETE','ACTIVATE','DEACTIVATE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `logs_status` enum('PENDING','APPROVED','REJECTED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `bparIPersonIdMaker` bigint DEFAULT NULL,
  `bparIPersonIdChecker` bigint DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `created` varchar(50) DEFAULT NULL,
  `date_updated` datetime DEFAULT NULL,
  `updated` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_role_atching_logs_id`),
  KEY `user_role_matching_id` (`user_role_matching_id`),
  KEY `user_id` (`user_id`),
  KEY `bparIPersonIdMaker` (`bparIPersonIdMaker`),
  KEY `bparIPersonIdChecker` (`bparIPersonIdChecker`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_role_matching_logs_ibfk_1` FOREIGN KEY (`user_role_matching_id`) REFERENCES `user_role_matching` (`user_role_matching_id`),
  CONSTRAINT `user_role_matching_logs_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `user_role_matching_logs_ibfk_3` FOREIGN KEY (`bparIPersonIdMaker`) REFERENCES `bpar_i_person` (`bpar_i_person_id`),
  CONSTRAINT `user_role_matching_logs_ibfk_4` FOREIGN KEY (`bparIPersonIdChecker`) REFERENCES `bpar_i_person` (`bpar_i_person_id`),
  CONSTRAINT `user_role_matching_logs_ibfk_5` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user_role_matching_logs` */

insert  into `user_role_matching_logs`(`user_role_atching_logs_id`,`user_role_matching_id`,`user_id`,`role_id`,`role_function_matching_id`,`logs_action`,`logs_status`,`bparIPersonIdMaker`,`bparIPersonIdChecker`,`date_created`,`created`,`date_updated`,`updated`,`is_active`) values 
(1,8,4,2,NULL,'NEW','APPROVED',5,NULL,'2025-11-21 00:00:00',NULL,NULL,NULL,1),
(2,9,5,2,NULL,'NEW','APPROVED',6,NULL,'2025-11-21 00:00:00',NULL,NULL,NULL,1),
(3,10,6,2,NULL,'NEW','APPROVED',7,NULL,'2025-11-21 10:02:24',NULL,NULL,NULL,1),
(4,11,7,2,NULL,'NEW','APPROVED',8,NULL,'2025-11-21 10:17:50',NULL,NULL,NULL,1);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
