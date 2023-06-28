-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 28, 2023 at 12:17 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `checkin_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `tbl_checkin`
--

CREATE TABLE `tbl_checkin` (
  `checkin_id` int(5) NOT NULL,
  `employee_id` int(5) NOT NULL,
  `checkin_lat` varchar(20) NOT NULL,
  `checkin_long` varchar(20) NOT NULL,
  `checkin_state` varchar(20) NOT NULL,
  `checkin_locality` varchar(20) NOT NULL,
  `checkin_date` date NOT NULL DEFAULT current_timestamp(),
  `checkin_time` time NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_checkin`
--

INSERT INTO `tbl_checkin` (`checkin_id`, `employee_id`, `checkin_lat`, `checkin_long`, `checkin_state`, `checkin_locality`, `checkin_date`, `checkin_time`) VALUES
(0, 1, '6.2697136', '100.4088969', 'Kedah', 'Jitra', '2023-06-28', '18:12:06');

-- --------------------------------------------------------

--
-- Table structure for table `tbl_employee`
--

CREATE TABLE `tbl_employee` (
  `employee_id` int(11) NOT NULL,
  `employee_email` varchar(50) NOT NULL,
  `employee_name` varchar(50) NOT NULL,
  `employee_department` varchar(50) NOT NULL,
  `employee_phone` varchar(15) NOT NULL,
  `employee_password` varchar(140) NOT NULL,
  `employee_otp` int(5) NOT NULL,
  `employee_datereg` datetime(5) NOT NULL DEFAULT current_timestamp(5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tbl_employee`
--

INSERT INTO `tbl_employee` (`employee_id`, `employee_email`, `employee_name`, `employee_department`, `employee_phone`, `employee_password`, `employee_otp`, `employee_datereg`) VALUES
(1, 'richard@gmail.com', 'Richard', 'Customer Service', '0149632598', '320bca71fc381a4a025636043ca86e734e31cf8b', 59699, '2023-06-28 18:11:47.25834');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tbl_employee`
--
ALTER TABLE `tbl_employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD UNIQUE KEY `employee _email` (`employee_email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tbl_employee`
--
ALTER TABLE `tbl_employee`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
