-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 26, 2025 at 07:31 AM
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
-- Database: `sport_registration`
--

-- --------------------------------------------------------

--
-- Table structure for table `applicants`
--

CREATE TABLE `applicants` (
  `id` int(11) NOT NULL,
  `application_number` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `age` int(11) DEFAULT NULL,
  `birthdate` date DEFAULT NULL,
  `height` double DEFAULT NULL,
  `weight` double DEFAULT NULL,
  `nationality` varchar(100) DEFAULT NULL,
  `religion` varchar(100) DEFAULT NULL,
  `father_name` varchar(255) DEFAULT NULL,
  `father_occupation` varchar(255) DEFAULT NULL,
  `father_nationality` varchar(100) DEFAULT NULL,
  `father_religion` varchar(100) DEFAULT NULL,
  `father_is_athlete` tinyint(1) DEFAULT 0,
  `father_athlete_level` varchar(255) DEFAULT NULL,
  `father_height` double DEFAULT NULL,
  `father_weight` double DEFAULT NULL,
  `mother_name` varchar(255) DEFAULT NULL,
  `mother_occupation` varchar(255) DEFAULT NULL,
  `mother_nationality` varchar(100) DEFAULT NULL,
  `mother_religion` varchar(100) DEFAULT NULL,
  `mother_is_athlete` tinyint(1) DEFAULT 0,
  `mother_athlete_level` varchar(255) DEFAULT NULL,
  `mother_height` double DEFAULT NULL,
  `mother_weight` double DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `village` varchar(50) DEFAULT NULL,
  `road` varchar(100) DEFAULT NULL,
  `sub_district` varchar(100) DEFAULT NULL,
  `district` varchar(100) DEFAULT NULL,
  `province` varchar(100) DEFAULT NULL,
  `postal_code` varchar(10) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `current_education` varchar(50) DEFAULT NULL,
  `education_year` varchar(20) DEFAULT NULL,
  `school_name` varchar(255) DEFAULT NULL,
  `sport_type` varchar(100) NOT NULL,
  `applied_level` varchar(50) DEFAULT NULL,
  `has_education_cert` tinyint(1) DEFAULT 0,
  `education_cert_count` int(11) DEFAULT NULL,
  `has_house_reg` tinyint(1) DEFAULT 0,
  `house_reg_count` int(11) DEFAULT NULL,
  `has_id_card` tinyint(1) DEFAULT 0,
  `id_card_count` int(11) DEFAULT NULL,
  `has_athlete_cert` tinyint(1) DEFAULT 0,
  `athlete_cert_count` int(11) DEFAULT NULL,
  `has_name_change_cert` tinyint(1) DEFAULT 0,
  `name_change_cert_count` int(11) DEFAULT NULL,
  `has_other_docs` tinyint(1) DEFAULT 0,
  `other_docs_desc` varchar(255) DEFAULT NULL,
  `other_docs_count` int(11) DEFAULT NULL,
  `photo_path` varchar(255) DEFAULT NULL,
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL,
  `exam_application_number` varchar(50) DEFAULT NULL,
  `father_sport` varchar(100) DEFAULT NULL,
  `mother_sport` varchar(100) DEFAULT NULL,
  `school_code` varchar(50) DEFAULT NULL,
  `target_school` varchar(255) DEFAULT NULL,
  `status` varchar(50) NOT NULL DEFAULT 'รอสัมภาษณ์',
  `father_race` varchar(100) DEFAULT NULL,
  `mother_race` varchar(100) DEFAULT NULL,
  `race` varchar(100) DEFAULT NULL,
  `school_district` varchar(100) DEFAULT NULL,
  `school_postal_code` varchar(10) DEFAULT NULL,
  `school_province` varchar(100) DEFAULT NULL,
  `school_sub_district` varchar(100) DEFAULT NULL,
  `sport_code` varchar(50) DEFAULT NULL,
  `athlete_cert_path` varchar(255) DEFAULT NULL,
  `education_cert_path` varchar(255) DEFAULT NULL,
  `house_reg_path` varchar(255) DEFAULT NULL,
  `id_card_path` varchar(255) DEFAULT NULL,
  `name_change_cert_path` varchar(255) DEFAULT NULL,
  `other_docs_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `applicants`
--

INSERT INTO `applicants` (`id`, `application_number`, `name`, `gender`, `age`, `birthdate`, `height`, `weight`, `nationality`, `religion`, `father_name`, `father_occupation`, `father_nationality`, `father_religion`, `father_is_athlete`, `father_athlete_level`, `father_height`, `father_weight`, `mother_name`, `mother_occupation`, `mother_nationality`, `mother_religion`, `mother_is_athlete`, `mother_athlete_level`, `mother_height`, `mother_weight`, `address`, `village`, `road`, `sub_district`, `district`, `province`, `postal_code`, `phone`, `current_education`, `education_year`, `school_name`, `sport_type`, `applied_level`, `has_education_cert`, `education_cert_count`, `has_house_reg`, `house_reg_count`, `has_id_card`, `id_card_count`, `has_athlete_cert`, `athlete_cert_count`, `has_name_change_cert`, `name_change_cert_count`, `has_other_docs`, `other_docs_desc`, `other_docs_count`, `photo_path`, `created_at`, `updated_at`, `exam_application_number`, `father_sport`, `mother_sport`, `school_code`, `target_school`, `status`, `father_race`, `mother_race`, `race`, `school_district`, `school_postal_code`, `school_province`, `school_sub_district`, `sport_code`, `athlete_cert_path`, `education_cert_path`, `house_reg_path`, `id_card_path`, `name_change_cert_path`, `other_docs_path`) VALUES
(11, '2568-0001', 'เด็กชายสมชาย สุขใจ', 'male', 18, '2006-05-28', 156, 61, 'ไทย', 'พุทธ', 'นายพงศ์ สุขใจ', 'รับจ้าง', 'ไทย', 'พุทธ', 1, 'ระดับจังหวัด', 179, NULL, 'นางวรรณา สุขใจ', 'ธุรกิจส่วนตัว', 'ไทย', 'พุทธ', 0, '', 158, NULL, '178/85', '10', 'สุขุมวิท', 'แสนสุข', 'เมืองระยอง', 'ระยอง', '24021', '0835344249', 'secondary', '6', 'โรงเรียนบ้านสวนรักเรียน', 'ว่ายน้ำ', 'มัธยมศึกษาปีที่ 4', 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, NULL, 1, '/uploads/applicants/applicant-2e000a39-0c92-4b72-abcc-1a654a3e304a.JPG', '2025-12-23 00:05:57.757', '2025-12-23 00:05:57.757', '67-9935', 'บาสเกตบอล', '', 'SB408', 'โรงเรียนกีฬาจังหวัดระยอง', 'รอสัมภาษณ์', 'ไทย', 'ไทย', 'ไทย', 'เมือง', '20210', 'ระยอง', 'บ้านสวน', 'SP92', NULL, NULL, NULL, NULL, NULL, NULL),
(12, '2568-0002', 'เด็กหญิงสุดา รักเรียน', 'female', 12, '2012-06-09', 157, 50, 'ไทย', 'พุทธ', 'นายธนา รักเรียน', 'รับราชการ', 'ไทย', 'พุทธ', 1, 'ระดับจังหวัด', 171, NULL, 'นางสุดา รักเรียน', 'พนักงานบริษัท', 'ไทย', 'พุทธ', 0, '', 158, NULL, '647/16', '15', 'ลาดพร้าว', 'แสนสุข', 'เมืองฉะเชิงเทรา', 'ฉะเชิงเทรา', '20652', '0867201704', 'primary', '3', 'โรงเรียนบ้านสวนเรียนดี', 'ฟุตบอล', 'ประถมศึกษาปีที่ 6', 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, NULL, 1, '/uploads/applicants/applicant-534aa06f-48eb-4fa9-a8e8-105b700125de.jpg', '2025-12-23 00:06:54.602', '2025-12-23 00:06:58.712', '67-2681', 'วอลเลย์บอล', '', 'SB446', 'โรงเรียนกีฬาจังหวัดฉะเชิงเทรา', 'ผ่านการคัดเลือก', 'ไทย', 'ไทย', 'ไทย', 'เมือง', '29743', 'ฉะเชิงเทรา', 'บ้านสวน', 'SP41', NULL, NULL, NULL, NULL, NULL, NULL),
(13, '2568-0003', 'เด็กชายสมชาย อุตสาหะ', 'male', 16, '2008-05-21', 171, 47, 'ไทย', 'พุทธ', 'นายวรรณา อุตสาหะ', 'พนักงานบริษัท', 'ไทย', 'พุทธ', 1, 'ระดับจังหวัด', 165, NULL, 'นางธนา อุตสาหะ', 'เกษตรกร', 'ไทย', 'พุทธ', 0, '', 162, NULL, '823/4', '15', 'ลาดพร้าว', 'แสนสุข', 'เมืองปราจีนบุรี', 'ปราจีนบุรี', '25279', '0898530212', 'secondary', '5', 'โรงเรียนบ้านสวนอุตสาหะ', 'วอลเลย์บอล', 'มัธยมศึกษาปีที่ 4', 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, NULL, 1, NULL, '2025-12-23 00:07:30.208', '2025-12-23 00:07:34.007', '67-3809', 'ฟุตบอล', '', 'SB948', 'โรงเรียนกีฬาจังหวัดปราจีนบุรี', 'ไม่ผ่าน', 'ไทย', 'ไทย', 'ไทย', 'เมือง', '24026', 'ปราจีนบุรี', 'บ้านสวน', 'SP40', NULL, NULL, NULL, NULL, NULL, NULL),
(14, '2568-0004', 'เด็กชายสมชาย อุตสาหะ', 'male', 13, '2011-04-09', 155, 50, 'ไทย', 'พุทธ', 'นายพงศ์ อุตสาหะ', 'ธุรกิจส่วนตัว', 'ไทย', 'พุทธ', 0, '', 176, NULL, 'นางสมหญิง อุตสาหะ', 'รับราชการ', 'ไทย', 'พุทธ', 0, '', 158, NULL, '495/32', '14', 'พัทยา', 'แสนสุข', 'เมืองชลบุรี', 'ชลบุรี', '21001', '0833555683', 'primary', '5', 'โรงเรียนบ้านสวนเรียนดี', 'มวยไทย', 'ประถมศึกษาปีที่ 6', 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, NULL, 1, NULL, '2025-12-23 00:07:39.946', '2025-12-23 00:07:43.404', '67-0933', '', '', 'SB223', 'โรงเรียนกีฬาจังหวัดชลบุรี', 'สละสิทธิ์', 'ไทย', 'ไทย', 'ไทย', 'เมือง', '25144', 'ชลบุรี', 'บ้านสวน', 'SP44', NULL, NULL, NULL, NULL, NULL, NULL),
(15, '2568-0005', 'เด็กหญิงสมชาย เรียนดี', 'female', 12, '2012-02-22', 183, 61, 'ไทย', 'พุทธ', 'นายสมหญิง เรียนดี', 'ธุรกิจส่วนตัว', 'ไทย', 'พุทธ', 1, '', 174, NULL, 'นางรักษ์ เรียนดี', 'ธุรกิจส่วนตัว', 'ไทย', 'พุทธ', 0, '', 169, NULL, '199/69', '13', 'สุขุมวิท', 'แสนสุข', 'เมืองจันทบุรี', 'จันทบุรี', '29461', '0860148703', 'primary', '1', 'โรงเรียนบ้านสวนกีฬาเก่ง', 'แบดมินตัน', 'ประถมศึกษาปีที่ 6', 1, 1, 1, 1, 1, 1, 0, 1, 0, 1, 0, NULL, 1, NULL, '2025-12-23 01:24:58.255', '2025-12-23 01:24:58.255', '67-2101', 'บาสเกตบอล', '', 'SB824', 'โรงเรียนกีฬาจังหวัดจันทบุรี', 'รอสัมภาษณ์', 'ไทย', 'ไทย', 'ไทย', 'เมือง', '26241', 'จันทบุรี', 'บ้านสวน', 'SP76', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `audit_logs`
--

CREATE TABLE `audit_logs` (
  `id` int(11) NOT NULL,
  `action` varchar(50) NOT NULL,
  `resource` varchar(50) NOT NULL,
  `resource_id` varchar(100) DEFAULT NULL,
  `details` text DEFAULT NULL,
  `performed_by` varchar(100) DEFAULT NULL,
  `ip_address` varchar(50) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'SUCCESS',
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `role` varchar(50) NOT NULL DEFAULT 'admin',
  `created_at` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updated_at` datetime(3) NOT NULL,
  `image` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `name`, `role`, `created_at`, `updated_at`, `image`) VALUES
(1, 'admin', '$2b$10$dmpnkUI9afEuZe/tuaO9Wu3wnMXBtylKl8W397agNCSZn6t6xj66q', 'ผู้ดูแลระบบ', 'admin', '2025-12-22 10:42:49.670', '2025-12-23 01:23:21.877', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `applicants`
--
ALTER TABLE `applicants`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `applicants_application_number_key` (`application_number`);

--
-- Indexes for table `audit_logs`
--
ALTER TABLE `audit_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_key` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `applicants`
--
ALTER TABLE `applicants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `audit_logs`
--
ALTER TABLE `audit_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
