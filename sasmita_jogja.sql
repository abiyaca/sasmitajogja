-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Des 2024 pada 11.23
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sasmita_jogja`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `destinations`
--

CREATE TABLE `destinations` (
  `id_destinasi` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `lokasi` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `jam_buka` varchar(255) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `destinations`
--

INSERT INTO `destinations` (`id_destinasi`, `nama`, `lokasi`, `deskripsi`, `jam_buka`, `image_url`, `created_at`) VALUES
(2, 'candi prambanan', 'Jl. Raya Solo - Yogyakarta No.16, Kranggan, Bokoharjo, Kec. Prambanan, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55571', 'Candi Prambanan adalah kompleks candi Hindu terbesar di Indonesia yang terletak di Sleman, Yogyakarta', '06.30', 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fprambanan.injourneydestination.id%2Fdestination-info%2F&psig=AOvVaw18q-Hf8xa74BvFgXSUGsAP&ust=1735294687210000&source=images&cd=vfe&opi=89978449&ved=0CBQQjRxqFwoTCIjX5tKaxYoDFQAAAAAdAAAAABAX', '2024-12-23 13:39:05'),
(4, 'asdafaasfa', 'asdaf', 'asfafa', '00.03', 'https://images.pexels.com/photos/7438803/pexels-photo-7438803.jpeg?auto=compress&cs=tinysrgb&w=600', '2024-12-23 13:58:34'),
(7, 'Lunaria', 'jogja', 'pw pol well ', '10.30', 'https://images.pexels.com/photos/5029884/pexels-photo-5029884.jpeg?auto=compress&cs=tinysrgb&w=600', '2024-12-23 14:48:02'),
(10, 'candi prambanan', 'Jl. Raya Solo - Yogyakarta No.16, Kranggan, Bokoharjo, Kec. Prambanan, Kabupaten Sleman, Daerah Istimewa Yogyakarta 55571', 'ada di jogja', '06.30', 'https://pin.it/27VoyoGjh', '2024-12-26 10:15:04');

-- --------------------------------------------------------

--
-- Struktur dari tabel `review`
--

CREATE TABLE `review` (
  `id_review` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `id_destinasi` int(11) NOT NULL,
  `review_text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id_user`, `username`, `email`, `password`, `created_at`) VALUES
(1, 'ben', 'albinrhamdaniwibowo27@gmail.com', 'scrypt:32768:8:1$z6E1DZ4DZ5ZlGsvV$e11c805513ca5f01cf4b850fb5522fcc972e685265592678c6324df4b7298a1b63a7a62ae3fcdd01e48735b17d83117651a34744983654ab2c2b9bbc3c58f261', '2024-12-23 13:33:07'),
(2, 'bam', 'rhamdanialbin@gmail.com', 'scrypt:32768:8:1$yhV16KuKY6wmIXjf$f293df8618464273c98cc383150f6c4cd8ef88268f49883428b36adb817181bb6ed4f7fd15174d05fafbada8dae770ba283c878e172a82af421daac493f3cca8', '2024-12-23 13:37:26'),
(3, 'ben.bennnn_', 'heho@gmail.com', 'scrypt:32768:8:1$EClm7wGfb200gnYx$4b16c8b9343340a85e656e04504240648c93c082fc66250aed1686875023e6ea81c22b02914ea732cbbd59746a1649180753ce207d1690a5052cf359502a13a1', '2024-12-23 14:17:11'),
(4, 'afra', 'afra@gmail.com', 'scrypt:32768:8:1$9Aeg3Flfcf7KJOML$7053d169047ddd0af45c5872f973759de55910c90e3608e68bfe0e4185b8ec0789d497503610b95a22dc4ac46ee27ec133428753a7267d6b2979bb0f56b4fa94', '2024-12-23 16:15:11'),
(5, 'najwasazaaa', 'najwashafira41@gmail.com', 'scrypt:32768:8:1$Ic48JpfJdGeZbiTh$4e9cc24d215529bc719c989a0627c4f673657704ef4147c7f286ec9efb104acbde9b8504ab928f8565795374e0bff602ad5feb9d6492d828568a454d52c6c65e', '2024-12-25 19:22:49');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `destinations`
--
ALTER TABLE `destinations`
  ADD PRIMARY KEY (`id_destinasi`);

--
-- Indeks untuk tabel `review`
--
ALTER TABLE `review`
  ADD PRIMARY KEY (`id_review`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `id_destinasi` (`id_destinasi`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `destinations`
--
ALTER TABLE `destinations`
  MODIFY `id_destinasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT untuk tabel `review`
--
ALTER TABLE `review`
  MODIFY `id_review` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `review_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `review_ibfk_2` FOREIGN KEY (`id_destinasi`) REFERENCES `destinations` (`id_destinasi`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
