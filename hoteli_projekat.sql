-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 25, 2023 at 12:19 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hoteli_projekat`
--
CREATE DATABASE IF NOT EXISTS `hoteli_projekat` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hoteli_projekat`;

-- --------------------------------------------------------

--
-- Table structure for table `administrator`
--

CREATE TABLE `administrator` (
  `korisnik_id` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `administrator`
--

INSERT INTO `administrator` (`korisnik_id`) VALUES
('A1001');

-- --------------------------------------------------------

--
-- Table structure for table `hotel`
--

CREATE TABLE `hotel` (
  `hotel_id` varchar(20) NOT NULL,
  `menadzer_id` varchar(20) DEFAULT NULL,
  `naziv` varchar(40) NOT NULL,
  `drzava` varchar(30) NOT NULL,
  `grad` varchar(30) NOT NULL,
  `broj_zvezdica` int(11) NOT NULL,
  `broj_parking_mesta` int(11) NOT NULL,
  `opis` varchar(500) NOT NULL,
  `naziv_slike` varchar(50) DEFAULT NULL,
  `datum_dodavanja` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotel`
--

INSERT INTO `hotel` (`hotel_id`, `menadzer_id`, `naziv`, `drzava`, `grad`, `broj_zvezdica`, `broj_parking_mesta`, `opis`, `naziv_slike`, `datum_dodavanja`) VALUES
('H11', 'M1001', 'Kontinental Alps', 'France', 'Tignes', 4, 150, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur porta lorem eu tempor commodo. Nunc gravida rutrum urna, vel cursus nunc ultricies ut. Ut vehicula id nibh et tincidunt. Nunc ac commodo nunc. Aenean ultrices ex sed ante vehicula, consequat molestie arcu vestibulum. Maecenas viverra molestie leo, eu luctus odio ullamcorper vel.', 'hotelAlps.webp', '2023-06-08 13:08:57'),
('H12', 'M1002', 'Kontinental Beach', 'France', 'Nice', 5, 350, 'Sed sodales elit a suscipit egestas. Fusce non ligula vitae nibh feugiat condimentum. Nulla nec mi libero. Quisque placerat euismod lectus, eget imperdiet sapien dapibus sit amet. Nunc vel faucibus erat, non gravida velit. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'hotelBeach.jpg', '2023-06-08 13:09:07'),
('H13', 'M1003', 'Kontinental Paris', 'France', 'Paris', 4, 250, 'Aliquam blandit neque eget tincidunt vulputate. Phasellus non nulla egestas, pretium felis a, feugiat ipsum. Nunc porttitor rhoncus erat a tincidunt. Quisque ac varius mauris, in aliquet purus. Sed in interdum erat.', 'hotelParis.jpg', '2023-06-08 13:09:16'),
('H14', 'M1004', 'Kontinental Venice', 'Italy', 'Venice', 5, 175, 'test', 'hotelVenice.webp', '2023-06-25 10:03:50');

-- --------------------------------------------------------

--
-- Table structure for table `klijent`
--

CREATE TABLE `klijent` (
  `korisnik_id` varchar(20) NOT NULL,
  `broj_poena` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `klijent`
--

INSERT INTO `klijent` (`korisnik_id`, `broj_poena`) VALUES
('K1002', 2),
('K1003', 2),
('K1004', 4),
('K1005', 6);

-- --------------------------------------------------------

--
-- Table structure for table `korisnik`
--

CREATE TABLE `korisnik` (
  `korisnik_id` varchar(20) NOT NULL,
  `ime` varchar(20) NOT NULL,
  `prezime` varchar(20) NOT NULL,
  `email` varchar(50) NOT NULL,
  `sifra` varchar(100) NOT NULL,
  `drzava` varchar(50) NOT NULL,
  `grad` varchar(30) NOT NULL,
  `adresa` varchar(50) NOT NULL,
  `broj_telefona` varchar(20) NOT NULL,
  `datum_rodjenja` date NOT NULL,
  `datum_dodavanja` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `korisnik`
--

INSERT INTO `korisnik` (`korisnik_id`, `ime`, `prezime`, `email`, `sifra`, `drzava`, `grad`, `adresa`, `broj_telefona`, `datum_rodjenja`, `datum_dodavanja`) VALUES
('A1001', 'Vladan', 'Tešić', 'vladan9820@its.edu.rs', '*D72C49EA7EB45A77CBF04EA0E9A1E3A4170F108D', 'Serbia', 'Belgrade', 'Španskih boraca 34', '0694202344', '2001-09-02', '2023-06-08 12:55:51'),
('K1002', 'Janko', 'Jankovic', 'janko@gmail.com', '*6B3CF3A1C118945BE0142F2A7DA1FA701A2B5407', 'France', 'Paris', 'Address 32', '1928374650', '1993-07-13', '2023-06-08 12:56:21'),
('K1003', 'Stefan', 'Stefanovic', 'stefan@gmail.com', '*E69971147131949BF275B60B199DE22130239E38', 'Norway', 'Oslo', 'Address 76', '1234598760', '1996-03-12', '2023-06-08 12:56:34'),
('K1004', 'Milica', 'Mihajlovic', 'milica@gmail.com', '*AE50418D8C3888CE4F402B2A752110F23E69782E', 'United States', 'New York', 'Address 98', '2095602936', '1990-06-23', '2023-06-08 12:56:44'),
('K1005', 'testKlijent', 'testKlijent', 'testKlijent@gmail.com', '*94BDCEBE19083CE2A1F959FD02F964C7AF4CFC29', 'Chad', 'test', 'test', 'test', '2023-06-08', '2023-06-08 13:23:15'),
('M1001', 'Marko', 'Markovic', 'marko@gmail.com', '*B883F9B747DEAD2F31DAC857EEEF3CDC58691C63', 'Germany', 'Munich', 'Adresa 62', '0612345678', '1995-06-12', '2023-06-08 12:57:07'),
('M1002', 'Jana', 'Janic', 'jana@gmail.com', '*3A6B98B98C8DF0510796253778DBCBA66A99938B', 'Italy', 'Rome', 'Adresa 83', '0698765432', '1997-04-28', '2023-06-08 12:57:23'),
('M1003', 'Petar', 'Petrovic', 'petar@gmail.com', '*1EC4AE268D26AB8FFCDC6D73AD077E5DFE2B6423', 'Netherlands', 'Amsterdam', 'Adresa 112', '0631245678', '1999-08-15', '2023-06-08 12:57:33'),
('M1004', 'Katarina', 'Katic', 'katarina@gmail.com', '*E30818699678915C753ADA650BAD0346994CA2A4', 'Italy', 'Rome', 'Address 75', '123456789', '1990-05-18', '2023-06-08 12:58:49'),
('M1005', 'testMenadzer', 'testMenadzer', 'testMenadzer@gmail.com', '*94BDCEBE19083CE2A1F959FD02F964C7AF4CFC29', 'test', 'test', 'test', 'test', '2023-06-07', '2023-06-08 12:59:03');

-- --------------------------------------------------------

--
-- Table structure for table `menadzer`
--

CREATE TABLE `menadzer` (
  `korisnik_id` varchar(20) NOT NULL,
  `hotel_id` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menadzer`
--

INSERT INTO `menadzer` (`korisnik_id`, `hotel_id`) VALUES
('M1005', NULL),
('M1001', 'H11'),
('M1002', 'H12'),
('M1003', 'H13'),
('M1004', 'H14');

-- --------------------------------------------------------

--
-- Table structure for table `radnik`
--

CREATE TABLE `radnik` (
  `korisnik_id` varchar(20) NOT NULL,
  `plata` float NOT NULL,
  `datum_zaposlenja` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `radnik`
--

INSERT INTO `radnik` (`korisnik_id`, `plata`, `datum_zaposlenja`) VALUES
('A1001', 120000, '2016-04-15'),
('M1001', 90000, '2018-06-03'),
('M1002', 85000, '2019-01-23'),
('M1003', 75000, '2020-07-14'),
('M1004', 75000, '2022-01-20'),
('M1005', 123456, '2023-06-06');

-- --------------------------------------------------------

--
-- Table structure for table `rezervacija`
--

CREATE TABLE `rezervacija` (
  `rezervacija_id` varchar(50) NOT NULL,
  `klijent_id` varchar(20) DEFAULT NULL,
  `soba_id` varchar(20) DEFAULT NULL,
  `datum_pocetka` date NOT NULL,
  `datum_isteka` date NOT NULL,
  `cena` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rezervacija`
--

INSERT INTO `rezervacija` (`rezervacija_id`, `klijent_id`, `soba_id`, `datum_pocetka`, `datum_isteka`, `cena`) VALUES
('K1002-H11S101-R11', 'K1002', 'H11S101', '2023-06-05', '2023-06-11', 480),
('K1003-H11S106-R11', 'K1003', 'H11S106', '2023-06-12', '2023-06-18', 540),
('K1004-H11S305-R11', 'K1004', 'H11S305', '2023-06-19', '2023-06-25', 840),
('K1004-H12S800-R11', 'K1004', 'H12S800', '2023-07-24', '2023-07-30', 2400),
('K1005-H11S308-R11', 'K1005', 'H11S308', '2023-06-26', '2023-07-02', 960),
('K1005-H12S800-R11', 'K1005', 'H12S800', '2023-07-03', '2023-07-09', 2400),
('K1005-H13S501-R11', 'K1005', 'H13S501', '2023-06-05', '2023-06-11', 1080);

-- --------------------------------------------------------

--
-- Table structure for table `soba`
--

CREATE TABLE `soba` (
  `soba_id` varchar(20) NOT NULL,
  `hotel_id` varchar(20) NOT NULL,
  `tip_sobe_id` varchar(20) DEFAULT NULL,
  `broj_sobe` int(3) NOT NULL,
  `dnevna_cena` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `soba`
--

INSERT INTO `soba` (`soba_id`, `hotel_id`, `tip_sobe_id`, `broj_sobe`, `dnevna_cena`) VALUES
('H11S101', 'H11', 'TS1S0KShw1TV', 101, 80),
('H11S102', 'H11', 'TS1S0KShw1TV', 102, 80),
('H11S103', 'H11', 'TS1S0KShw1TV', 103, 80),
('H11S104', 'H11', 'TS1S0KShw1TV', 104, 80),
('H11S105', 'H11', 'TS1S0KShw1TV', 105, 80),
('H11S106', 'H11', 'TS1D1KBth1TV', 106, 90),
('H11S107', 'H11', 'TS1D1KBth1TV', 107, 90),
('H11S108', 'H11', 'TS1D1KBth1TV', 108, 90),
('H11S109', 'H11', 'TS1D1KBth1TV', 109, 90),
('H11S110', 'H11', 'TS1D1KBth1TV', 110, 90),
('H11S201', 'H11', 'TS2S2KShw0TV', 201, 100),
('H11S202', 'H11', 'TS2S2KShw0TV', 202, 100),
('H11S203', 'H11', 'TS2S2KShw0TV', 203, 100),
('H11S204', 'H11', 'TS2S2KShw0TV', 204, 100),
('H11S205', 'H11', 'TS2S2KShw0TV', 205, 100),
('H11S206', 'H11', 'TS1SD1KShw0TV', 206, 110),
('H11S207', 'H11', 'TS1SD1KShw0TV', 207, 110),
('H11S208', 'H11', 'TS1SD1KShw0TV', 208, 110),
('H11S209', 'H11', 'TS1SD1KShw0TV', 209, 110),
('H11S210', 'H11', 'TS1SD1KShw0TV', 210, 110),
('H11S301', 'H11', 'TS2D2KBth1TV', 301, 120),
('H11S302', 'H11', 'TS2D2KBth1TV', 302, 120),
('H11S303', 'H11', 'TS2D2KBth1TV', 303, 120),
('H11S304', 'H11', 'TS2D2KBth1TV', 304, 120),
('H11S305', 'H11', 'TS1Q2KBth1TV', 305, 140),
('H11S306', 'H11', 'TS1Q2KBth1TV', 306, 140),
('H11S307', 'H11', 'TS1Q2KBth1TV', 307, 140),
('H11S308', 'H11', 'TS1K2KBth1TV', 308, 160),
('H11S309', 'H11', 'TS1K2KBth1TV', 309, 160),
('H11S310', 'H11', 'TS1K2KBth1TV', 310, 160),
('H11S400', 'H11', 'TS2K2KBth1TV', 400, 300),
('H12S101', 'H12', 'TS1S0KShw1TV', 101, 130),
('H12S102', 'H12', 'TS1S0KShw1TV', 102, 130),
('H12S103', 'H12', 'TS1S0KShw1TV', 103, 130),
('H12S104', 'H12', 'TS1S0KShw1TV', 104, 130),
('H12S105', 'H12', 'TS1S0KShw1TV', 105, 130),
('H12S201', 'H12', 'TS2S2KShw0TV', 201, 140),
('H12S202', 'H12', 'TS2S2KShw0TV', 202, 140),
('H12S203', 'H12', 'TS2S2KShw0TV', 203, 140),
('H12S204', 'H12', 'TS2S2KShw0TV', 204, 140),
('H12S205', 'H12', 'TS2S2KShw0TV', 205, 140),
('H12S301', 'H12', 'TS1D1KBth1TV', 301, 150),
('H12S302', 'H12', 'TS1D1KBth1TV', 302, 150),
('H12S303', 'H12', 'TS1D1KBth1TV', 303, 150),
('H12S304', 'H12', 'TS1D1KBth1TV', 304, 150),
('H12S305', 'H12', 'TS1D1KBth1TV', 305, 150),
('H12S401', 'H12', 'TS1SD1KShw0TV', 401, 160),
('H12S402', 'H12', 'TS1SD1KShw0TV', 402, 160),
('H12S403', 'H12', 'TS1SD1KShw0TV', 403, 160),
('H12S404', 'H12', 'TS1SD1KShw0TV', 404, 160),
('H12S405', 'H12', 'TS1SD1KShw0TV', 405, 160),
('H12S501', 'H12', 'TS2D2KBth1TV', 501, 170),
('H12S502', 'H12', 'TS2D2KBth1TV', 502, 170),
('H12S503', 'H12', 'TS2D2KBth1TV', 503, 170),
('H12S504', 'H12', 'TS2D2KBth1TV', 504, 170),
('H12S601', 'H12', 'TS1Q2KBth1TV', 601, 190),
('H12S602', 'H12', 'TS1Q2KBth1TV', 602, 190),
('H12S603', 'H12', 'TS1Q2KBth1TV', 603, 190),
('H12S701', 'H12', 'TS1K2KBth1TV', 701, 210),
('H12S702', 'H12', 'TS1K2KBth1TV', 702, 210),
('H12S703', 'H12', 'TS1K2KBth1TV', 703, 210),
('H12S800', 'H12', 'TS2K2KBth1TV', 800, 400),
('H13S101', 'H13', 'TS1S0KShw1TV', 101, 100),
('H13S102', 'H13', 'TS1SD1KShw0TV', 102, 100),
('H13S103', 'H13', 'TS1S0KShw1TV', 103, 100),
('H13S104', 'H13', 'TS1S0KShw1TV', 104, 100),
('H13S105', 'H13', 'TS1S0KShw1TV', 105, 100),
('H13S106', 'H13', 'TS1S0KShw1TV', 106, 100),
('H13S107', 'H13', 'TS1S0KShw1TV', 107, 100),
('H13S108', 'H13', 'TS1S0KShw1TV', 108, 100),
('H13S109', 'H13', 'TS1S0KShw1TV', 109, 100),
('H13S110', 'H13', 'TS1S0KShw1TV', 110, 100),
('H13S201', 'H13', 'TS2S2KShw0TV', 201, 110),
('H13S202', 'H13', 'TS2S2KShw0TV', 202, 110),
('H13S203', 'H13', 'TS2S2KShw0TV', 203, 110),
('H13S204', 'H13', 'TS2S2KShw0TV', 204, 110),
('H13S205', 'H13', 'TS2S2KShw0TV', 205, 110),
('H13S206', 'H13', 'TS2S2KShw0TV', 206, 110),
('H13S207', 'H13', 'TS2S2KShw0TV', 207, 110),
('H13S208', 'H13', 'TS2S2KShw0TV', 208, 110),
('H13S209', 'H13', 'TS2S2KShw0TV', 209, 110),
('H13S210', 'H13', 'TS2S2KShw0TV', 210, 110),
('H13S301', 'H13', 'TS1D1KBth1TV', 301, 120),
('H13S302', 'H13', 'TS1D1KBth1TV', 302, 120),
('H13S303', 'H13', 'TS1D1KBth1TV', 303, 120),
('H13S304', 'H13', 'TS1D1KBth1TV', 304, 120),
('H13S305', 'H13', 'TS1D1KBth1TV', 305, 120),
('H13S306', 'H13', 'TS1SD1KShw0TV', 306, 130),
('H13S307', 'H13', 'TS1SD1KShw0TV', 307, 130),
('H13S308', 'H13', 'TS1SD1KShw0TV', 308, 130),
('H13S309', 'H13', 'TS1SD1KShw0TV', 309, 130),
('H13S310', 'H13', 'TS1SD1KShw0TV', 310, 130),
('H13S401', 'H13', 'TS2D2KBth1TV', 401, 140),
('H13S402', 'H13', 'TS2D2KBth1TV', 402, 140),
('H13S403', 'H13', 'TS2D2KBth1TV', 403, 140),
('H13S404', 'H13', 'TS2D2KBth1TV', 404, 140),
('H13S405', 'H13', 'TS2D2KBth1TV', 405, 140),
('H13S406', 'H13', 'TS1Q2KBth1TV', 406, 160),
('H13S407', 'H13', 'TS1Q2KBth1TV', 407, 160),
('H13S408', 'H13', 'TS1Q2KBth1TV', 408, 160),
('H13S409', 'H13', 'TS1Q2KBth1TV', 409, 160),
('H13S410', 'H13', 'TS1Q2KBth1TV', 410, 160),
('H13S501', 'H13', 'TS1K2KBth1TV', 501, 180),
('H13S502', 'H13', 'TS1K2KBth1TV', 502, 180),
('H13S503', 'H13', 'TS1K2KBth1TV', 503, 180),
('H13S504', 'H13', 'TS1K2KBth1TV', 504, 180),
('H13S505', 'H13', 'TS1K2KBth1TV', 505, 180),
('H13S600', 'H13', 'TS2K2KBth1TV', 600, 350);

-- --------------------------------------------------------

--
-- Table structure for table `tip_sobe`
--

CREATE TABLE `tip_sobe` (
  `tip_sobe_id` varchar(50) NOT NULL,
  `naziv` varchar(100) NOT NULL,
  `broj_kreveta` int(11) NOT NULL,
  `tip_kreveta` enum('Single','Double','Queen','King','Single + Double') NOT NULL,
  `kuhinja` enum('None','Semi-furnished','Fully-furnished') NOT NULL,
  `kupatilo` enum('Shower','Bath') NOT NULL,
  `televizor` bit(1) NOT NULL,
  `opis` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tip_sobe`
--

INSERT INTO `tip_sobe` (`tip_sobe_id`, `naziv`, `broj_kreveta`, `tip_kreveta`, `kuhinja`, `kupatilo`, `televizor`, `opis`) VALUES
('TS1D1KBth1TV', '1x Double Bed | Semi-furnished Kitchen | Bath', 2, 'Double', 'Semi-furnished', 'Bath', b'1', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur id fermentum ligula. Phasellus in fringilla mi, non varius ex. Cras ut ligula auctor, volutpat dolor at, pretium urna.'),
('TS1K2KBth1TV', '1x King Size Bed | Fully-furnished Kitchen | Bath', 2, 'King', 'Fully-furnished', 'Bath', b'1', 'Duis sagittis vitae nisi ut vehicula. Nullam at orci auctor, euismod elit nec, fermentum justo. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.'),
('TS1Q2KBth1TV', '1x Queen Size Bed | Fully-furnished Kitchen | Bath', 2, 'Queen', 'Fully-furnished', 'Bath', b'1', 'Aenean ullamcorper tellus eu lectus ullamcorper ullamcorper. Donec eget laoreet est.'),
('TS1S0KShw1TV', '1x Single Bed | No Kitchen | Shower', 1, 'Single', 'None', 'Shower', b'1', 'Vestibulum accumsan augue in eros pretium, vel ullamcorper erat bibendum. Vivamus vitae risus vel felis volutpat scelerisque sed eget erat. Vivamus egestas risus vel ante rhoncus vulputate.'),
('TS1SD1KShw0TV', '1x Single/Double Combo | Semi-furnished Kitchen | Shower', 3, 'Single + Double', 'Semi-furnished', 'Shower', b'0', 'Mauris a lectus in mauris pellentesque venenatis vitae nec ante. In vehicula erat non dolor vestibulum, ut mattis est sagittis. Morbi velit ex, porta sit amet lorem et, viverra bibendum dolor.'),
('TS2D2KBth1TV', '2x Double Beds | Fully-furnished Kitchen | Bath', 4, 'Double', 'Fully-furnished', 'Bath', b'1', 'Phasellus hendrerit facilisis purus, vitae feugiat enim placerat sed. Sed eget dapibus nisl, ut vehicula augue. Aliquam erat volutpat.'),
('TS2K2KBth1TV', '2x King Size Beds | Fully-furnished Kitchen | Bath', 4, 'King', 'Fully-furnished', 'Bath', b'1', 'Vestibulum ex erat, iaculis rhoncus tortor et, posuere consectetur magna. Ut ullamcorper nibh massa. Nunc quis vehicula orci.'),
('TS2S2KShw0TV', '2x Single Beds | Fully-furnished Kitchen | Shower', 2, 'Single', 'Fully-furnished', 'Shower', b'0', 'Praesent eu viverra augue. Nullam non elit vulputate, dignissim nisl ac, dignissim nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrator`
--
ALTER TABLE `administrator`
  ADD PRIMARY KEY (`korisnik_id`);

--
-- Indexes for table `hotel`
--
ALTER TABLE `hotel`
  ADD PRIMARY KEY (`hotel_id`),
  ADD KEY `fk_hotel_menadzer` (`menadzer_id`);

--
-- Indexes for table `klijent`
--
ALTER TABLE `klijent`
  ADD PRIMARY KEY (`korisnik_id`);

--
-- Indexes for table `korisnik`
--
ALTER TABLE `korisnik`
  ADD PRIMARY KEY (`korisnik_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `menadzer`
--
ALTER TABLE `menadzer`
  ADD PRIMARY KEY (`korisnik_id`),
  ADD KEY `fk_menadzer_hotel` (`hotel_id`);

--
-- Indexes for table `radnik`
--
ALTER TABLE `radnik`
  ADD PRIMARY KEY (`korisnik_id`);

--
-- Indexes for table `rezervacija`
--
ALTER TABLE `rezervacija`
  ADD PRIMARY KEY (`rezervacija_id`),
  ADD KEY `fk_rezervacija_klijent` (`klijent_id`),
  ADD KEY `fk_rezervacija_soba` (`soba_id`);

--
-- Indexes for table `soba`
--
ALTER TABLE `soba`
  ADD PRIMARY KEY (`soba_id`),
  ADD KEY `fk_soba_hotel` (`hotel_id`),
  ADD KEY `fk_soba_tip_sobe` (`tip_sobe_id`);

--
-- Indexes for table `tip_sobe`
--
ALTER TABLE `tip_sobe`
  ADD PRIMARY KEY (`tip_sobe_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `administrator`
--
ALTER TABLE `administrator`
  ADD CONSTRAINT `fk_administrator_radnik` FOREIGN KEY (`korisnik_id`) REFERENCES `radnik` (`korisnik_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `hotel`
--
ALTER TABLE `hotel`
  ADD CONSTRAINT `fk_hotel_menadzer` FOREIGN KEY (`menadzer_id`) REFERENCES `menadzer` (`korisnik_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `klijent`
--
ALTER TABLE `klijent`
  ADD CONSTRAINT `fk_klijent_korisnik` FOREIGN KEY (`korisnik_id`) REFERENCES `korisnik` (`korisnik_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menadzer`
--
ALTER TABLE `menadzer`
  ADD CONSTRAINT `fk_menadzer_hotel` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_menadzer_radnik` FOREIGN KEY (`korisnik_id`) REFERENCES `radnik` (`korisnik_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `radnik`
--
ALTER TABLE `radnik`
  ADD CONSTRAINT `fk_radnik_korisnik` FOREIGN KEY (`korisnik_id`) REFERENCES `korisnik` (`korisnik_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `rezervacija`
--
ALTER TABLE `rezervacija`
  ADD CONSTRAINT `fk_rezervacija_klijent` FOREIGN KEY (`klijent_id`) REFERENCES `klijent` (`korisnik_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_rezervacija_soba` FOREIGN KEY (`soba_id`) REFERENCES `soba` (`soba_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `soba`
--
ALTER TABLE `soba`
  ADD CONSTRAINT `fk_soba_hotel` FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_soba_tip_sobe` FOREIGN KEY (`tip_sobe_id`) REFERENCES `tip_sobe` (`tip_sobe_id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
