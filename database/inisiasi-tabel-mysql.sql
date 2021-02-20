-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 20, 2021 at 07:32 AM
-- Server version: 10.2.36-MariaDB-log-cll-lve
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `opensmar_v1`
--

-- --------------------------------------------------------

--
-- Table structure for table `anggota_rombel`
--

CREATE TABLE `anggota_rombel` (
  `id_rombel` int(11) NOT NULL,
  `npm_mahasiswa` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `dosen`
--

CREATE TABLE `dosen` (
  `nip` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nik` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_pengguna` int(11) NOT NULL,
  `nama` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(240) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_kelamin` tinyint(4) NOT NULL COMMENT '1 = pria, 2 = wanita',
  `tanggal_lahir` date NOT NULL,
  `kode_jurusan` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gelar` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun_masuk` year(4) NOT NULL,
  `waktu_registrasi` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jurusan`
--

CREATE TABLE `jurusan` (
  `kode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` varchar(240) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(240) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kontak` varchar(240) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kegiatan`
--

CREATE TABLE `kegiatan` (
  `id` int(11) NOT NULL,
  `id_pertemuan` int(11) NOT NULL,
  `tipe` int(11) NOT NULL COMMENT '1 materi, 2 tugas, 3 uts, 4 uas',
  `judul` varchar(240) COLLATE utf8mb4_unicode_ci NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lampiran` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `waktu_mulai` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `waktu_selesai` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kehadiran`
--

CREATE TABLE `kehadiran` (
  `id_pertemuan` int(11) NOT NULL,
  `npm_mahasiswa` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `waktu_hadir` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mahasiswa`
--

CREATE TABLE `mahasiswa` (
  `npm` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nik` varchar(16) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id_pengguna` int(11) NOT NULL,
  `nama` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alamat` varchar(240) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jenis_kelamin` tinyint(4) NOT NULL COMMENT '1 = pria, 2 = wanita',
  `tanggal_lahir` date NOT NULL,
  `kode_jurusan` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun_masuk` year(4) NOT NULL,
  `waktu_registrasi` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `mata_kuliah`
--

CREATE TABLE `mata_kuliah` (
  `kode` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `kode_jurusan` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah_sks` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengerjaan_kegiatan`
--

CREATE TABLE `pengerjaan_kegiatan` (
  `id_kegiatan` int(11) NOT NULL,
  `npm_mahasiswa` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lampiran` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `nilai` int(11) NOT NULL,
  `waktu_kirim` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pengguna`
--

CREATE TABLE `pengguna` (
  `id` int(11) NOT NULL,
  `tipe` tinyint(4) NOT NULL DEFAULT 3 COMMENT '1 = admin, 2 = dosen, 3 = mahasiswa',
  `username` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_aktif` tinyint(4) NOT NULL DEFAULT 1,
  `waktu_registrasi` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pertemuan`
--

CREATE TABLE `pertemuan` (
  `id` int(11) NOT NULL,
  `id_rombel` int(11) NOT NULL,
  `id_ruangan` int(11) NOT NULL,
  `waktu` time NOT NULL,
  `tanggal` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rombel`
--

CREATE TABLE `rombel` (
  `id` int(11) NOT NULL,
  `kode_mata_kuliah` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nip_dosen` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun` year(4) NOT NULL,
  `semester` tinyint(4) NOT NULL,
  `deskripsi` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `bobot_absensi` int(11) NOT NULL COMMENT '%',
  `bobot_tugas` int(11) NOT NULL COMMENT '%',
  `bobot_uts` int(11) NOT NULL COMMENT '%',
  `bobot_uas` int(11) NOT NULL COMMENT '%'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `anggota_rombel`
--
ALTER TABLE `anggota_rombel`
  ADD PRIMARY KEY (`id_rombel`);

--
-- Indexes for table `dosen`
--
ALTER TABLE `dosen`
  ADD PRIMARY KEY (`nip`);

--
-- Indexes for table `jurusan`
--
ALTER TABLE `jurusan`
  ADD PRIMARY KEY (`kode`);

--
-- Indexes for table `kegiatan`
--
ALTER TABLE `kegiatan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mahasiswa`
--
ALTER TABLE `mahasiswa`
  ADD PRIMARY KEY (`npm`);

--
-- Indexes for table `mata_kuliah`
--
ALTER TABLE `mata_kuliah`
  ADD PRIMARY KEY (`kode`);

--
-- Indexes for table `pengerjaan_kegiatan`
--
ALTER TABLE `pengerjaan_kegiatan`
  ADD UNIQUE KEY `id_kegiatan-npm_mahasiswa` (`id_kegiatan`,`npm_mahasiswa`);

--
-- Indexes for table `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pertemuan`
--
ALTER TABLE `pertemuan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rombel`
--
ALTER TABLE `rombel`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kegiatan`
--
ALTER TABLE `kegiatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pertemuan`
--
ALTER TABLE `pertemuan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rombel`
--
ALTER TABLE `rombel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
