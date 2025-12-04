-- Database: stmik_ids
-- Created for PHP Native Dashboard Application

-- Create database
CREATE DATABASE IF NOT EXISTS `stmik_ids`;
USE `stmik_ids`;

-- Table structure for table `login`
CREATE TABLE `login` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `mahasiswa`
CREATE TABLE `mahasiswa` (
  `nim` varchar(20) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `jenis_kelamin` enum('L','P') NOT NULL,
  `kota_kelahiran` varchar(50) DEFAULT NULL,
  `tanggal_kelahiran` date DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `program_studi` varchar(50) DEFAULT NULL,
  `tahun_masuk` year(4) DEFAULT NULL,
  PRIMARY KEY (`nim`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `dosen`
CREATE TABLE `dosen` (
  `nidn` varchar(20) NOT NULL,
  `nama_dosen` varchar(100) NOT NULL,
  `jenkel_dosen` enum('L','P') NOT NULL,
  `alamat_dosen` text DEFAULT NULL,
  PRIMARY KEY (`nidn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `matakuliah`
CREATE TABLE `matakuliah` (
  `kode_matkul` varchar(20) NOT NULL,
  `nama_matkul` varchar(100) NOT NULL,
  `sks` int(11) NOT NULL,
  PRIMARY KEY (`kode_matkul`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `nilai`
CREATE TABLE `nilai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nim` varchar(20) NOT NULL,
  `kode_matkul` varchar(20) NOT NULL,
  `semester` int(11) NOT NULL,
  `nilai` varchar(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nim` (`nim`),
  KEY `kode_matkul` (`kode_matkul`),
  CONSTRAINT `nilai_ibfk_1` FOREIGN KEY (`nim`) REFERENCES `mahasiswa` (`nim`) ON DELETE CASCADE,
  CONSTRAINT `nilai_ibfk_2` FOREIGN KEY (`kode_matkul`) REFERENCES `matakuliah` (`kode_matkul`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- ====[ # CREATE TABLES END # ]====

-- Dumping data for table `login`
INSERT INTO `login` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin'),
(2, 'user', 'user');

-- Dumping data for table `mahasiswa`
INSERT INTO `mahasiswa` (`nim`, `nama`, `jenis_kelamin`, `kota_kelahiran`, `tanggal_kelahiran`, `alamat`, `program_studi`, `tahun_masuk`) VALUES
('2021001', 'Ahmad Rizki', 'L', 'Jakarta', '2000-05-15', 'Jl. Merdeka No. 123, Jakarta', 'Teknik Informatika', 2021),
('2021002', 'Siti Nurhaliza', 'P', 'Bandung', '2001-03-22', 'Jl. Sudirman No. 45, Bandung', 'Sistem Informasi', 2021),
('2022001', 'Budi Santoso', 'L', 'Surabaya', '2002-08-10', 'Jl. Gajah Mada No. 67, Surabaya', 'Teknik Informatika', 2022),
('2022002', 'Dewi Lestari', 'P', 'Yogyakarta', '2002-12-05', 'Jl. Malioboro No. 89, Yogyakarta', 'Sistem Informasi', 2022);

-- Dumping data for table `dosen`
INSERT INTO `dosen` (`nidn`, `nama_dosen`, `jenkel_dosen`, `alamat_dosen`) VALUES
('001', 'Dr. Heri Hermawan, S.Kom., M.Kom.', 'L', 'Jl. Pendidikan No. 1, Jakarta'),
('002', 'Dr. Siti Aminah, S.Kom., M.T.', 'P', 'Jl. Teknologi No. 2, Bandung'),
('003', 'Prof. Budi Prasetyo, S.Kom., Ph.D.', 'L', 'Jl. Informatika No. 3, Surabaya');

-- Dumping data for table `matakuliah`
INSERT INTO `matakuliah` (`kode_matkul`, `nama_matkul`, `sks`) VALUES
('MK001', 'Pemrograman Web', 3),
('MK002', 'Basis Data', 3),
('MK003', 'Algoritma dan Struktur Data', 4),
('MK004', 'Jaringan Komputer', 3),
('MK005', 'Sistem Operasi', 3),
('MK006', 'Pemrograman Mobile', 3),
('MK007', 'Kecerdasan Buatan', 3),
('MK008', 'Rekayasa Perangkat Lunak', 4);

-- Dumping data for table `nilai`
INSERT INTO `nilai` (`id`, `nim`, `kode_matkul`, `semester`, `nilai`) VALUES
(1, '2021001', 'MK001', 1, 'A'),
(2, '2021001', 'MK002', 1, 'B+'),
(3, '2021001', 'MK003', 1, 'A-'),
(4, '2021002', 'MK001', 1, 'B'),
(5, '2021002', 'MK002', 1, 'A'),
(6, '2021002', 'MK004', 2, 'B+'),
(7, '2022001', 'MK001', 1, 'A'),
(8, '2022001', 'MK003', 1, 'B'),
(9, '2022002', 'MK002', 1, 'A-'),
(10, '2022002', 'MK005', 2, 'B+');