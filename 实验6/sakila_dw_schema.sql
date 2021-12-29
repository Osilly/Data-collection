/*
SQLyog Enterprise Trial - MySQL GUI v7.11 
MySQL - 5.7.31 : Database - sakila_dw
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`sakila_dw` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sakila_dw`;

/*Table structure for table `dim_actor` */

DROP TABLE IF EXISTS `dim_actor`;

CREATE TABLE `dim_actor` (
  `actor_key` int(10) NOT NULL AUTO_INCREMENT,
  `actor_last_update` datetime NOT NULL,
  `actor_last_name` varchar(45) NOT NULL,
  `actor_first_name` varchar(45) NOT NULL,
  `actor_id` int(11) NOT NULL,
  PRIMARY KEY (`actor_key`)
) ENGINE=MyISAM AUTO_INCREMENT=601 DEFAULT CHARSET=latin1;

/*Table structure for table `dim_customer` */

DROP TABLE IF EXISTS `dim_customer`;

CREATE TABLE `dim_customer` (
  `customer_key` int(8) NOT NULL AUTO_INCREMENT,
  `customer_last_update` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `customer_id` int(8) DEFAULT NULL,
  `customer_first_name` varchar(45) DEFAULT NULL,
  `customer_last_name` varchar(45) DEFAULT NULL,
  `customer_email` varchar(50) DEFAULT NULL,
  `customer_active` char(3) DEFAULT NULL,
  `customer_created` date DEFAULT NULL,
  `customer_address` varchar(64) DEFAULT NULL,
  `customer_district` varchar(20) DEFAULT NULL,
  `customer_postal_code` varchar(10) DEFAULT NULL,
  `customer_phone_number` varchar(20) DEFAULT NULL,
  `customer_city` varchar(50) DEFAULT NULL,
  `customer_country` varchar(50) DEFAULT NULL,
  `customer_version_number` smallint(5) DEFAULT NULL,
  `customer_valid_from` date DEFAULT NULL,
  `customer_valid_through` date DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `customer_id` (`customer_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4794 DEFAULT CHARSET=latin1;

/*Table structure for table `dim_date` */

DROP TABLE IF EXISTS `dim_date`;

CREATE TABLE `dim_date` (
  `date_key` int(8) NOT NULL,
  `date_value` date NOT NULL,
  `date_short` char(12) NOT NULL,
  `date_medium` char(16) NOT NULL,
  `date_long` char(24) NOT NULL,
  `date_full` char(32) NOT NULL,
  `day_in_year` smallint(5) NOT NULL,
  `day_in_month` tinyint(3) NOT NULL,
  `is_first_day_in_month` char(10) NOT NULL,
  `is_last_day_in_month` char(10) NOT NULL,
  `day_abbreviation` char(3) NOT NULL,
  `day_name` char(12) NOT NULL,
  `week_in_year` tinyint(3) NOT NULL,
  `week_in_month` tinyint(3) NOT NULL,
  `is_first_day_in_week` char(10) NOT NULL,
  `is_last_day_in_week` char(10) NOT NULL,
  `month_number` tinyint(3) NOT NULL,
  `month_abbreviation` char(3) NOT NULL,
  `month_name` char(12) NOT NULL,
  `year2` char(2) NOT NULL,
  `year4` smallint(5) NOT NULL,
  `quarter_name` char(2) NOT NULL,
  `quarter_number` tinyint(3) NOT NULL,
  `year_quarter` char(7) NOT NULL,
  `year_month_number` char(7) NOT NULL,
  `year_month_abbreviation` char(8) NOT NULL,
  PRIMARY KEY (`date_key`),
  UNIQUE KEY `date` (`date_value`) USING BTREE,
  UNIQUE KEY `date_value` (`date_value`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `dim_film` */

DROP TABLE IF EXISTS `dim_film`;

CREATE TABLE `dim_film` (
  `film_key` int(8) NOT NULL AUTO_INCREMENT,
  `film_last_update` datetime NOT NULL,
  `film_title` varchar(64) NOT NULL,
  `film_description` text NOT NULL,
  `film_release_year` smallint(5) NOT NULL,
  `film_language` varchar(20) NOT NULL,
  `film_original_language` varchar(20) NOT NULL,
  `film_rental_duration` tinyint(3) DEFAULT NULL,
  `film_rental_rate` decimal(4,2) DEFAULT NULL,
  `film_duration` int(8) DEFAULT NULL,
  `film_replacement_cost` decimal(5,2) DEFAULT NULL,
  `film_rating_code` char(5) DEFAULT NULL,
  `film_rating_text` varchar(30) DEFAULT NULL,
  `film_has_trailers` char(4) DEFAULT NULL,
  `film_has_commentaries` char(4) DEFAULT NULL,
  `film_has_deleted_scenes` char(4) DEFAULT NULL,
  `film_has_behind_the_scenes` char(4) DEFAULT NULL,
  `film_in_category_action` char(4) DEFAULT NULL,
  `film_in_category_animation` char(4) DEFAULT NULL,
  `film_in_category_children` char(4) DEFAULT NULL,
  `film_in_category_classics` char(4) DEFAULT NULL,
  `film_in_category_comedy` char(4) DEFAULT NULL,
  `film_in_category_documentary` char(4) DEFAULT NULL,
  `film_in_category_drama` char(4) DEFAULT NULL,
  `film_in_category_family` char(4) DEFAULT NULL,
  `film_in_category_foreign` char(4) DEFAULT NULL,
  `film_in_category_games` char(4) DEFAULT NULL,
  `film_in_category_horror` char(4) DEFAULT NULL,
  `film_in_category_music` char(4) DEFAULT NULL,
  `film_in_category_new` char(4) DEFAULT NULL,
  `film_in_category_scifi` char(4) DEFAULT NULL,
  `film_in_category_sports` char(4) DEFAULT NULL,
  `film_in_category_travel` char(4) DEFAULT NULL,
  `film_id` int(11) NOT NULL,
  PRIMARY KEY (`film_key`)
) ENGINE=MyISAM AUTO_INCREMENT=3001 DEFAULT CHARSET=latin1;

/*Table structure for table `dim_film_actor_bridge` */

DROP TABLE IF EXISTS `dim_film_actor_bridge`;

CREATE TABLE `dim_film_actor_bridge` (
  `film_key` int(8) NOT NULL,
  `actor_key` int(10) NOT NULL,
  `actor_weighting_factor` decimal(3,2) DEFAULT NULL,
  PRIMARY KEY (`film_key`,`actor_key`),
  KEY `dim_actor_dim_film_actor_bridge_fk` (`actor_key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `dim_staff` */

DROP TABLE IF EXISTS `dim_staff`;

CREATE TABLE `dim_staff` (
  `staff_key` int(8) NOT NULL AUTO_INCREMENT,
  `staff_last_update` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `staff_first_name` varchar(45) DEFAULT NULL,
  `staff_last_name` varchar(45) DEFAULT NULL,
  `staff_id` int(8) DEFAULT NULL,
  `staff_store_id` int(8) DEFAULT NULL,
  `staff_version_number` smallint(5) DEFAULT NULL,
  `staff_valid_from` date DEFAULT NULL,
  `staff_valid_through` date DEFAULT NULL,
  `staff_active` char(3) DEFAULT NULL,
  PRIMARY KEY (`staff_key`),
  KEY `staff_id` (`staff_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Table structure for table `dim_store` */

DROP TABLE IF EXISTS `dim_store`;

CREATE TABLE `dim_store` (
  `store_key` int(8) NOT NULL AUTO_INCREMENT,
  `store_last_update` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  `store_id` int(8) DEFAULT NULL,
  `store_address` varchar(64) DEFAULT NULL,
  `store_district` varchar(20) DEFAULT NULL,
  `store_postal_code` varchar(10) DEFAULT NULL,
  `store_phone_number` varchar(20) DEFAULT NULL,
  `store_city` varchar(50) DEFAULT NULL,
  `store_country` varchar(50) DEFAULT NULL,
  `store_manager_staff_id` int(8) DEFAULT NULL,
  `store_manager_first_name` varchar(45) DEFAULT NULL,
  `store_manager_last_name` varchar(45) DEFAULT NULL,
  `store_version_number` smallint(5) DEFAULT NULL,
  `store_valid_from` date DEFAULT NULL,
  `store_valid_through` date DEFAULT NULL,
  PRIMARY KEY (`store_key`),
  KEY `store_id` (`store_id`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Table structure for table `dim_time` */

DROP TABLE IF EXISTS `dim_time`;

CREATE TABLE `dim_time` (
  `time_key` int(8) NOT NULL,
  `time_value` time NOT NULL,
  `hours24` tinyint(3) NOT NULL,
  `hours12` tinyint(3) DEFAULT NULL,
  `minutes` tinyint(3) DEFAULT NULL,
  `seconds` tinyint(3) DEFAULT NULL,
  `am_pm` char(3) DEFAULT NULL,
  PRIMARY KEY (`time_key`),
  UNIQUE KEY `time_value` (`time_value`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `fact_rental` */

DROP TABLE IF EXISTS `fact_rental`;

CREATE TABLE `fact_rental` (
  `customer_key` int(8) NOT NULL,
  `staff_key` int(8) NOT NULL,
  `film_key` int(8) NOT NULL,
  `store_key` int(8) NOT NULL,
  `rental_date_key` int(8) NOT NULL,
  `return_date_key` int(10) NOT NULL,
  `rental_time_key` int(8) NOT NULL,
  `count_returns` int(10) NOT NULL,
  `count_rentals` int(8) NOT NULL,
  `rental_duration` int(11) DEFAULT NULL,
  `rental_last_update` datetime DEFAULT NULL,
  `rental_id` int(11) DEFAULT NULL,
  KEY `dim_store_fact_rental_fk` (`store_key`),
  KEY `dim_staff_fact_rental_fk` (`staff_key`),
  KEY `dim_time_fact_rental_fk` (`rental_time_key`),
  KEY `dim_film_fact_rental_fk` (`film_key`),
  KEY `dim_date_fact_rental_fk` (`rental_date_key`),
  KEY `dim_customer_fact_rental_fk` (`customer_key`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
