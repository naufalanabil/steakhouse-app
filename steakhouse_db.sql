-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 20 Sep 2026 pada 15.45
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `steakhouse_db`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `bank_accounts`
--

CREATE TABLE `bank_accounts` (
  `id` int(11) NOT NULL,
  `nama_bank` varchar(50) NOT NULL,
  `nomor_rekening` varchar(50) NOT NULL,
  `atas_nama` varchar(100) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `bank_accounts`
--

INSERT INTO `bank_accounts` (`id`, `nama_bank`, `nomor_rekening`, `atas_nama`, `is_active`) VALUES
(1, 'BCA', '8830123456', 'PT STEAKHOUSE UTAMA', 1),
(2, 'Mandiri', '1370009876543', 'PT STEAKHOUSE UTAMA', 1),
(3, 'BRI', '034101000123303', 'PT STEAKHOUSE UTAMA', 1);

-- --------------------------------------------------------

--
-- Struktur dari tabel `menu`
--

CREATE TABLE `menu` (
  `id` int(11) NOT NULL,
  `nama_menu` varchar(255) NOT NULL,
  `kategori` enum('steak','rice_bowl','sides','desserts','drinks') NOT NULL,
  `harga` decimal(12,2) NOT NULL,
  `stok` int(11) NOT NULL DEFAULT 50,
  `rating_avg` decimal(2,1) DEFAULT 5.0,
  `gambar_url` varchar(255) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `menu`
--

INSERT INTO `menu` (`id`, `nama_menu`, `kategori`, `harga`, `stok`, `rating_avg`, `gambar_url`, `deskripsi`, `created_at`) VALUES
(1, 'Meltique Ribeye Steak 200g', 'steak', 135000.00, 50, 4.9, 'https://images.unsplash.com/photo-1558030006-450675393462?w=500', 'Daging ribeye meltique tender dan juicy dengan marbling tinggi.', '2026-09-20 09:31:08'),
(2, 'Australian Sirloin Steak 200g', 'steak', 115000.00, 46, 5.0, 'https://images.unsplash.com/photo-1544025162-d76694265947?w=500', 'Potongan sirloin impor Australia dengan tekstur gurih khas.', '2026-09-20 09:31:08'),
(3, 'Prime Tenderloin Steak 180g', 'steak', 145000.00, 50, 4.8, 'https://images.unsplash.com/photo-1560781290-7dc94c0f8f4f?w=500', 'Daging khas dalam tanpa lemak, sangat lembut dan lumer di mulut.', '2026-09-20 09:31:08'),
(4, 'Wagyu Tomahawk Steak 500g', 'steak', 380000.00, 50, 5.0, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=500', 'Potongan daging wagyu premium berspesifikasi tinggi dengan tulang khas.', '2026-09-20 09:31:08'),
(5, 'US Prime T-Bone Steak 350g', 'steak', 220000.00, 50, 4.9, 'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=500', 'Perpaduan gurihnya Sirloin dan lembutnya Tenderloin dalam satu potongan T-Bone.', '2026-09-20 09:31:08'),
(6, 'Wagyu MB5 Ribeye Steak 200g', 'steak', 240000.00, 46, 5.0, 'https://images.unsplash.com/photo-1600891964092-4316c288032e?w=500', 'Wagyu marbling score 5 dengan kelembutan ekstra dan sensasi butter alami.', '2026-09-20 09:31:08'),
(7, 'Grilled Chicken Steak', 'steak', 58000.00, 50, 4.6, 'https://images.unsplash.com/photo-1532550907401-a500c9a57435?w=500', 'Dada ayam panggang bumbu rempah dengan kulit crispy dan daging juicy.', '2026-09-20 09:31:08'),
(8, 'Crispy Chicken Steak with Mushroom Gravy', 'steak', 55000.00, 50, 4.7, 'https://images.unsplash.com/photo-1625938145744-e380515399b7?w=500', 'Fillet ayam goreng tepung renyah disiram saus jamur gurih.', '2026-09-20 09:31:08'),
(9, 'Pan-Seared Salmon Steak', 'steak', 125000.00, 50, 4.8, 'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?w=500', 'Ikan salmon segar dipanggang crispy skin dengan saus lemon butter.', '2026-09-20 09:31:08'),
(10, 'Lamb Chop Steak with Mint Sauce', 'steak', 165000.00, 50, 4.7, 'https://images.unsplash.com/photo-1603048588665-791ca8aea617?w=500', 'Iga domba pilihan empuk dipanggang rempah disajikan dengan saus mint segar.', '2026-09-20 09:31:08'),
(11, 'Wagyu Slice Steak Rice Bowl', 'rice_bowl', 68000.00, 50, 4.8, 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=500', 'Irisan wagyu tumis saus spesial dengan nasi mentega hangat & poached egg.', '2026-09-20 09:31:08'),
(12, 'Beef Cutlet Blackpepper Rice', 'rice_bowl', 58000.00, 50, 4.7, 'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=500', 'Potongan daging sapi crispy disiram saus lada hitam khas di atas nasi.', '2026-09-20 09:31:08'),
(13, 'Chicken Katsu Curry Rice', 'rice_bowl', 52000.00, 50, 4.6, 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=500', 'Ayam katsu renyah dengan kuah kari Jepang gurih kental dan wortel kentang.', '2026-09-20 09:31:08'),
(14, 'Hamburg Steak Rice with Melted Cheese', 'rice_bowl', 62000.00, 50, 4.8, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500', 'Daging cincang steak tebal diselimuti keju leleh di atas nasi mentega.', '2026-09-20 09:31:08'),
(15, 'Creamy Carbonara Pasta with Steak Slices', 'rice_bowl', 68000.00, 50, 4.8, 'https://images.unsplash.com/photo-1621996346565-e3def6164299?w=500', 'Spaghetti creamy carbonara dengan topping irisan daging steak panggang.', '2026-09-20 09:31:08'),
(16, 'Spaghetti Bolognese Beef Meatball', 'rice_bowl', 55000.00, 50, 4.6, 'https://images.unsplash.com/photo-1551183053-bf91a1d81141?w=500', 'Spaghetti dengan saus tomat daging cincang dan bakso sapi olahan housemade.', '2026-09-20 09:31:08'),
(17, 'Spaghetti Aglio Olio Seafood', 'rice_bowl', 62000.00, 50, 4.7, 'https://images.unsplash.com/photo-1608897013039-887f21d8c804?w=500', 'Spaghetti tumis minyak zaitun, bawang putih, cabai kering, udang, dan cumi.', '2026-09-20 09:31:08'),
(18, 'Truffle Cream Penne Pasta', 'rice_bowl', 75000.00, 50, 4.9, 'https://images.unsplash.com/photo-1608897013039-887f21d8c804?w=500', 'Pasta penne saus krim minyak truffle aromatik dengan keju parmesan.', '2026-09-20 09:31:08'),
(19, 'Loaded Cheese French Fries', 'sides', 32000.00, 50, 4.7, 'https://images.unsplash.com/photo-1576107232684-1279f390859f?w=500', 'Kentang goreng renyah disiram saus keju & beef bacon bits.', '2026-09-20 09:31:08'),
(20, 'Mashed Potato with Gravy', 'sides', 25000.00, 50, 4.8, 'https://images.unsplash.com/photo-1618160702438-9b02ab6515c9?w=500', 'Kentang tumbuk lembut khas restoran disiram saus gurih.', '2026-09-20 09:31:08'),
(21, 'Crispy Potato Wedges', 'sides', 28000.00, 50, 4.6, 'https://images.unsplash.com/photo-1585109649139-366815a0d713?w=500', 'Potongan kentang tebal berbumbu renyah di luar lembut di dalam.', '2026-09-20 09:31:08'),
(22, 'Crispy Onion Rings', 'sides', 22000.00, 50, 4.5, 'https://images.unsplash.com/photo-1639024471283-03518883512d?w=500', 'Bawang bombay balur tepung bumbu renyah dengan saus tartar.', '2026-09-20 09:31:08'),
(23, 'Garlic Butter Bread Stick', 'sides', 20000.00, 50, 4.6, 'https://images.unsplash.com/photo-1573140247632-f8fd74997d5c?w=500', 'Roti memanggang gurih olesan garlic butter dan peterseli.', '2026-09-20 09:31:08'),
(24, 'Creamy Mushroom Soup', 'sides', 30000.00, 50, 4.8, 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=500', 'Sup jamur kental hangat disajikan dengan crouton renyah.', '2026-09-20 09:31:08'),
(25, 'Caesar Salad with Grilled Chicken', 'sides', 42000.00, 50, 4.7, 'https://images.unsplash.com/photo-1550304943-4f24f54ddde9?w=500', 'Sayuran segar, selada romaine, dressing caesar, potongan ayam panggang & parmesan.', '2026-09-20 09:31:08'),
(26, 'Deep Fried Calamari Rings', 'sides', 38000.00, 50, 4.6, 'https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?w=500', 'Cumi goreng tepung renyah disajikan dengan saus mayo lemon.', '2026-09-20 09:31:08'),
(27, 'Choco Lava Cake + Ice Cream', 'desserts', 38000.00, 50, 4.9, 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=500', 'Cokelat lumer hangat disajikan bersama 1 scoop es krim vanila.', '2026-09-20 09:31:08'),
(28, 'Classic New York Cheesecake', 'desserts', 35000.00, 50, 4.8, 'https://images.unsplash.com/photo-1533134242443-d4fd215305ad?w=500', 'Kue keju lembut dengan paduan selai stroberi manis asam.', '2026-09-20 09:31:08'),
(29, 'Classic Italian Tiramisu', 'desserts', 38000.00, 50, 4.9, 'https://images.unsplash.com/photo-1571877227200-a0d98ea607e9?w=500', 'Dessert rasa kopi espresso berpadu keju mascarpone yang lembut.', '2026-09-20 09:31:08'),
(30, 'Apple Pie with Cinnamon Powder', 'desserts', 32000.00, 50, 4.6, 'https://images.unsplash.com/photo-1568571780765-9276ac8b75a2?w=500', 'Pastry pie apel hangat aroma kayu manis bertabur gula halus.', '2026-09-20 09:31:08'),
(31, 'Triple Scoop Ice Cream Delight', 'desserts', 28000.00, 50, 4.7, 'https://images.unsplash.com/photo-1563805042-7684c019e1cb?w=500', 'Tiga scoop es krim pilihan dengan topping saus cokelat.', '2026-09-20 09:31:08'),
(32, 'Iced Lychee Tea with Fruit', 'drinks', 25000.00, 46, 4.9, 'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=500', 'Teh segar rasa lici disajikan dengan buah lici asli.', '2026-09-20 09:31:08'),
(33, 'Oreo Milkshake Special', 'drinks', 30000.00, 46, 4.8, 'https://images.unsplash.com/photo-1572490122747-3968b75cc699?w=500', 'Susu segar blend dengan biskuit Oreo dan whipped cream.', '2026-09-20 09:31:08'),
(34, 'Berry Mojito (Non-Alcoholic)', 'drinks', 28000.00, 50, 4.7, 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500', 'Campuran sirup beri, daun mint segar, dan soda menyegarkan.', '2026-09-20 09:31:08'),
(35, 'Iced Lemon Tea', 'drinks', 18000.00, 50, 4.6, 'https://images.unsplash.com/photo-1513558161293-cdaf765ed2fd?w=500', 'Teh lemon segar penyegar setelah menikmati steak.', '2026-09-20 09:31:08'),
(36, 'Avocado Chocolate Float', 'drinks', 32000.00, 50, 4.8, 'https://images.unsplash.com/photo-1577805947697-89e18249d767?w=500', 'Jus alpukat pekat disiram sirup cokelat & es krim cokelat.', '2026-09-20 09:31:08'),
(37, 'Matcha Green Tea Latte', 'drinks', 28000.00, 50, 4.7, 'https://images.unsplash.com/photo-1536256263959-770b48d82b0a?w=500', 'Minuman matcha Jepang berkualitas dipadu susu segar.', '2026-09-20 09:31:08'),
(38, 'Mineral Water 600ml', 'drinks', 8000.00, 50, 4.5, 'https://images.unsplash.com/photo-1548839140-29a749e1bc4e?w=500', 'Air mineral kemasan botol dingin / suhu ruang.', '2026-09-20 09:31:08');

-- --------------------------------------------------------

--
-- Struktur dari tabel `menu_options`
--

CREATE TABLE `menu_options` (
  `id` int(11) NOT NULL,
  `kategori_opsi` enum('saus','side_dish','topping') NOT NULL,
  `nama_opsi` varchar(100) NOT NULL,
  `harga_tambahan` decimal(10,2) DEFAULT 0.00
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `menu_options`
--

INSERT INTO `menu_options` (`id`, `kategori_opsi`, `nama_opsi`, `harga_tambahan`) VALUES
(1, 'saus', 'Blackpepper Sauce', 0.00),
(2, 'saus', 'Creamy Wild Mushroom Sauce', 0.00),
(3, 'saus', 'Classic Texas BBQ Sauce', 0.00),
(4, 'saus', 'Garlic Herb Butter', 0.00),
(5, 'saus', 'Truffle Cream Gravy', 10000.00),
(6, 'saus', 'Argentine Chimichurri Sauce', 5000.00),
(7, 'saus', 'Gorgonzola Cheese Sauce', 8000.00),
(8, 'saus', 'Smoked Honey Mustard', 5000.00),
(9, 'saus', 'Spicy Peri-Peri Sauce', 5000.00),
(10, 'saus', 'Japanese Teriyaki Glaze', 5000.00),
(11, 'saus', 'Creamy Tartar Sauce', 4000.00),
(12, 'saus', 'Red Wine Reduction Gravy', 12000.00),
(13, 'saus', 'Spicy Sambal Matah Butter', 6000.00),
(14, 'saus', 'Miso Butter Sauce', 7000.00),
(15, 'saus', 'Lemon Herb Gravy', 5000.00),
(16, 'saus', 'Chipotle Mayo Sauce', 5000.00),
(17, 'saus', 'Sweet Chili Glaze', 4000.00),
(18, 'saus', 'Habanero Fire Sauce', 6000.00),
(19, 'saus', 'Brown Butter Sage Dip', 8000.00),
(20, 'saus', 'Extra House Gravy', 8000.00),
(21, 'side_dish', 'Classic French Fries', 0.00),
(22, 'side_dish', 'Creamy Mashed Potato with Gravy', 0.00),
(23, 'side_dish', 'Crispy Seasoned Potato Wedges', 0.00),
(24, 'side_dish', 'Truffle Parmesan Fries', 15000.00),
(25, 'side_dish', 'Garlic Butter Rice', 0.00),
(26, 'side_dish', 'Steak Cut Fries', 0.00),
(27, 'side_dish', 'Baked Potato with Sour Cream', 12000.00),
(28, 'side_dish', 'Sweet Potato Fries', 10000.00),
(29, 'side_dish', 'Sautéed Butter Corn & Peas', 0.00),
(30, 'side_dish', 'Grilled Asparagus & Carrots', 8000.00),
(31, 'side_dish', 'Garden Salad Sesame Dressing', 0.00),
(32, 'side_dish', 'Creamed Spinach Parmesan', 12000.00),
(33, 'side_dish', 'Sautéed Wild Mushrooms', 10000.00),
(34, 'side_dish', 'Macaroni & Cheese Side', 14000.00),
(35, 'side_dish', 'Crispy Onion Rings Side', 8000.00),
(36, 'side_dish', 'Grilled Corn on the Cob', 7000.00),
(37, 'side_dish', 'Coleslaw Salad', 6000.00),
(38, 'side_dish', 'Roasted Garlic Baby Potatoes', 10000.00),
(39, 'side_dish', 'Steamed Broccoli & Cheese', 9000.00),
(40, 'side_dish', 'Garlic Bread Stick (2 pcs)', 8000.00),
(41, 'topping', 'Melted Mozzarella Cheese', 12000.00),
(42, 'topping', 'Sunny Side Up Egg', 7000.00),
(43, 'topping', 'Crispy Beef Bacon Strip (2 pcs)', 12000.00),
(44, 'topping', 'Grilled Garlic Butter Prawns (2 pcs)', 25000.00),
(45, 'topping', 'Caramelized Sweet Onions', 6000.00),
(46, 'topping', 'Sautéed Button Mushrooms', 10000.00),
(47, 'topping', 'Crispy Fried Shallots', 4000.00),
(48, 'topping', 'Fresh Jalapeno Slices', 5000.00),
(49, 'topping', 'Red Cheddar Slice', 8000.00),
(50, 'topping', 'Poached Egg', 8000.00),
(51, 'topping', 'Blue Cheese Crumbles', 15000.00),
(52, 'topping', 'Avocado Slices', 10000.00),
(53, 'topping', 'Crispy Chicken Cutlet Topping', 18000.00),
(54, 'topping', 'Bone Marrow Slice', 30000.00),
(55, 'topping', 'Garlic Flakes', 4000.00),
(56, 'topping', 'Crushed Pepper Bacon Bits', 9000.00),
(57, 'topping', 'Melted Emmental Cheese', 14000.00),
(58, 'topping', 'Grilled Pineapple Ring', 6000.00),
(59, 'topping', 'Truffle Oil Drizzle', 12000.00),
(60, 'topping', 'Extra Egg Yolk', 5000.00);

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `nomor_meja` int(11) NOT NULL,
  `nama_pelanggan` varchar(100) NOT NULL,
  `total_harga` decimal(12,2) NOT NULL,
  `status` enum('pending','diproses','selesai','dibatalkan') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `orders`
--

INSERT INTO `orders` (`id`, `nomor_meja`, `nama_pelanggan`, `total_harga`, `status`, `created_at`) VALUES
(1, 3, 'Pelanggan Meja 3', 1058000.00, 'selesai', '2026-09-20 09:45:57'),
(2, 5, 'Pelanggan Meja 5', 897000.00, 'selesai', '2026-09-20 09:46:46'),
(3, 4, 'Pelanggan Meja 4', 276000.00, 'selesai', '2026-09-20 09:48:09'),
(4, 2, 'Pelanggan Meja 2', 132250.00, 'selesai', '2026-09-20 09:52:20'),
(5, 2, 'Pelanggan Meja 2', 333500.00, 'selesai', '2026-09-20 11:24:41'),
(6, 1, 'Pelanggan Meja 1', 609500.00, 'selesai', '2026-09-20 11:33:17'),
(7, 1, 'Pelanggan Meja 1', 667000.00, 'selesai', '2026-09-20 13:33:33'),
(8, 1, 'Pelanggan Meja 1', 1219000.00, 'selesai', '2026-09-20 13:40:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `catatan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `menu_id`, `jumlah`, `subtotal`, `catatan`) VALUES
(1, 1, 2, 8, 920000.00, ''),
(2, 2, 2, 1, 115000.00, ''),
(3, 2, 1, 1, 135000.00, ''),
(4, 2, 3, 2, 290000.00, ''),
(5, 2, 6, 1, 240000.00, ''),
(6, 3, 6, 1, 240000.00, ''),
(7, 4, 2, 1, 115000.00, ''),
(8, 5, 2, 2, 230000.00, 'doneness: Medium, sauce: Blackpepper Sauce'),
(9, 5, 33, 2, 60000.00, 'size: Regular Cup, sugar: Normal Sugar, ice: Normal Ice'),
(10, 6, 6, 2, 480000.00, 'doneness: Medium Rare, sauce: BBQ Sauce'),
(11, 6, 32, 2, 50000.00, 'size: Large Cup (+Rp 5.000), sugar: Normal Sugar, ice: Normal Ice'),
(12, 7, 2, 4, 460000.00, 'doneness: Well Done, sauce: BBQ Sauce'),
(13, 7, 33, 4, 120000.00, 'size: Large Cup (+Rp 5.000), sugar: Less Sugar, ice: Normal Ice'),
(14, 8, 6, 4, 960000.00, 'doneness: Medium Rare, sauce: BBQ Sauce'),
(15, 8, 32, 4, 100000.00, 'size: Regular Cup, sugar: Less Sugar, ice: Less Ice');

-- --------------------------------------------------------

--
-- Struktur dari tabel `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `subtotal` decimal(12,2) NOT NULL,
  `tax` decimal(12,2) NOT NULL,
  `service_charge` decimal(12,2) NOT NULL,
  `total_bayar` decimal(12,2) NOT NULL,
  `metode_pembayaran` enum('cash','qris','credit_card','debit_card','bank_transfer','virtual_account') NOT NULL,
  `bank_tujuan` varchar(50) DEFAULT NULL,
  `nomor_referensi` varchar(100) DEFAULT NULL,
  `va_number` varchar(50) DEFAULT NULL,
  `snap_token` varchar(255) DEFAULT NULL,
  `status_pembayaran` enum('pending','lunas','gagal') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `payments`
--

INSERT INTO `payments` (`id`, `order_id`, `subtotal`, `tax`, `service_charge`, `total_bayar`, `metode_pembayaran`, `bank_tujuan`, `nomor_referensi`, `va_number`, `snap_token`, `status_pembayaran`, `created_at`) VALUES
(1, 1, 920000.00, 92000.00, 46000.00, 1058000.00, 'virtual_account', NULL, NULL, '70012000001', '3c66a989-e6e1-4456-980f-03bda1fcdaff', 'pending', '2026-09-20 09:45:58'),
(2, 2, 780000.00, 78000.00, 39000.00, 897000.00, 'virtual_account', NULL, NULL, '70012000002', '266f60f1-0192-42a4-829a-a4aaa07d23ab', 'pending', '2026-09-20 09:46:46'),
(3, 3, 240000.00, 24000.00, 12000.00, 276000.00, 'virtual_account', NULL, NULL, '70012000003', '3d05b6cb-768b-43ce-9d6b-1ade8c7e9064', 'pending', '2026-09-20 09:48:09'),
(4, 4, 115000.00, 11500.00, 5750.00, 132250.00, 'qris', NULL, NULL, '70012000004', 'dcb55749-ec8e-49a3-b6c9-5d947c3746a2', 'pending', '2026-09-20 09:52:21'),
(5, 5, 290000.00, 29000.00, 14500.00, 333500.00, '', NULL, NULL, '70012000005', '7ad0cb32-8c7d-42af-a3af-c6c21128520a', 'pending', '2026-09-20 11:24:41'),
(6, 6, 530000.00, 53000.00, 26500.00, 609500.00, '', NULL, NULL, '70012000006', '2e201fc5-abf7-47d1-86a0-3b6db9682f58', 'pending', '2026-09-20 11:33:18'),
(7, 7, 580000.00, 58000.00, 29000.00, 667000.00, '', NULL, NULL, '70012000007', '06b1c04a-da19-4be6-833d-f5e43c49c801', 'pending', '2026-09-20 13:33:34'),
(8, 8, 1060000.00, 106000.00, 53000.00, 1219000.00, 'qris', NULL, NULL, '70012000008', '7a0bf097-f9d8-43e3-8a83-593e4f06a773', 'pending', '2026-09-20 13:40:18');

-- --------------------------------------------------------

--
-- Struktur dari tabel `queue`
--

CREATE TABLE `queue` (
  `id` int(11) NOT NULL,
  `nomor_antrean` varchar(20) NOT NULL,
  `nama_pelanggan` varchar(100) NOT NULL,
  `jumlah_orang` int(11) NOT NULL,
  `nomor_telepon` varchar(20) DEFAULT NULL,
  `status` enum('menunggu','dipanggil','selesai','batal') DEFAULT 'menunggu',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `queue`
--

INSERT INTO `queue` (`id`, `nomor_antrean`, `nama_pelanggan`, `jumlah_orang`, `nomor_telepon`, `status`, `created_at`) VALUES
(1, 'Q-001', 'Naufal', 2, '08568564378', 'selesai', '2026-09-20 11:23:15'),
(2, 'Q-002', 'Zidan', 2, '081227272629', 'selesai', '2026-09-20 11:32:49'),
(3, 'Q-003', 'Naufal', 4, '08568564378', 'selesai', '2026-09-20 13:31:45'),
(4, 'Q-004', 'Adhis', 4, '081227272629', 'menunggu', '2026-09-20 13:37:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `reservations`
--

CREATE TABLE `reservations` (
  `id` int(11) NOT NULL,
  `nomor_meja` int(11) NOT NULL,
  `nama_pemesan` varchar(100) NOT NULL,
  `nomor_telepon` varchar(20) NOT NULL,
  `tanggal_reservasi` date NOT NULL,
  `jam_reservasi` time NOT NULL,
  `jumlah_tamu` int(11) NOT NULL,
  `status` varchar(20) DEFAULT 'aktif'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `reservations`
--

INSERT INTO `reservations` (`id`, `nomor_meja`, `nama_pemesan`, `nomor_telepon`, `tanggal_reservasi`, `jam_reservasi`, `jumlah_tamu`, `status`) VALUES
(1, 1, 'Naufal', '08568564378', '2026-09-22', '17:30:00', 4, 'aktif'),
(2, 2, 'Adhis', '081227272629', '2026-09-21', '15:30:00', 4, 'aktif');

-- --------------------------------------------------------

--
-- Struktur dari tabel `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `menu_id` int(11) NOT NULL,
  `nama_pelanggan` varchar(100) NOT NULL,
  `rating` int(11) DEFAULT NULL CHECK (`rating` between 1 and 5),
  `komentar` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `reviews`
--

INSERT INTO `reviews` (`id`, `menu_id`, `nama_pelanggan`, `rating`, `komentar`, `created_at`) VALUES
(1, 4, 'Naufal', 5, 'Mantap', '2026-09-20 11:35:55'),
(2, 2, 'Adhis', 5, 'Maknyos', '2026-09-20 11:36:45'),
(3, 2, 'Naufal', 5, 'Mantap', '2026-09-20 13:33:09');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tables`
--

CREATE TABLE `tables` (
  `id` int(11) NOT NULL,
  `nomor_meja` int(11) NOT NULL,
  `kapasitas` int(11) NOT NULL DEFAULT 4,
  `status` enum('kosong','terisi','reservasi') DEFAULT 'kosong'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `tables`
--

INSERT INTO `tables` (`id`, `nomor_meja`, `kapasitas`, `status`) VALUES
(1, 1, 2, 'kosong'),
(2, 2, 2, 'kosong'),
(3, 3, 4, 'kosong'),
(4, 4, 4, 'kosong'),
(5, 5, 4, 'kosong'),
(6, 6, 6, 'kosong'),
(7, 7, 6, 'kosong'),
(8, 8, 8, 'kosong'),
(9, 9, 4, 'kosong'),
(10, 10, 4, 'kosong'),
(11, 11, 4, 'kosong'),
(12, 12, 4, 'kosong'),
(13, 13, 4, 'kosong'),
(14, 14, 4, 'kosong'),
(15, 15, 4, 'kosong'),
(16, 16, 4, 'kosong'),
(17, 17, 4, 'kosong'),
(18, 18, 4, 'kosong'),
(19, 19, 4, 'kosong'),
(20, 20, 4, 'kosong'),
(21, 21, 4, 'kosong'),
(22, 22, 4, 'kosong'),
(23, 23, 4, 'kosong'),
(24, 24, 4, 'kosong'),
(25, 25, 4, 'kosong'),
(26, 26, 6, 'kosong'),
(27, 27, 6, 'kosong'),
(28, 28, 6, 'kosong'),
(29, 29, 6, 'kosong'),
(30, 30, 6, 'kosong'),
(31, 31, 6, 'kosong'),
(32, 32, 6, 'kosong'),
(33, 33, 6, 'kosong'),
(34, 34, 6, 'kosong'),
(35, 35, 6, 'kosong'),
(36, 36, 6, 'kosong'),
(37, 37, 6, 'kosong'),
(38, 38, 6, 'kosong'),
(39, 39, 6, 'kosong'),
(40, 40, 6, 'kosong'),
(41, 41, 8, 'kosong'),
(42, 42, 8, 'kosong'),
(43, 43, 8, 'kosong'),
(44, 44, 8, 'kosong'),
(45, 45, 8, 'kosong'),
(46, 46, 8, 'kosong'),
(47, 47, 8, 'kosong'),
(48, 48, 8, 'kosong'),
(49, 49, 8, 'kosong'),
(50, 50, 8, 'kosong');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `bank_accounts`
--
ALTER TABLE `bank_accounts`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `menu_options`
--
ALTER TABLE `menu_options`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Indeks untuk tabel `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `order_id` (`order_id`);

--
-- Indeks untuk tabel `queue`
--
ALTER TABLE `queue`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `reservations`
--
ALTER TABLE `reservations`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_id` (`menu_id`);

--
-- Indeks untuk tabel `tables`
--
ALTER TABLE `tables`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nomor_meja` (`nomor_meja`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `bank_accounts`
--
ALTER TABLE `bank_accounts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `menu`
--
ALTER TABLE `menu`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT untuk tabel `menu_options`
--
ALTER TABLE `menu_options`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT untuk tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `queue`
--
ALTER TABLE `queue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `reservations`
--
ALTER TABLE `reservations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `tables`
--
ALTER TABLE `tables`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`);

--
-- Ketidakleluasaan untuk tabel `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`);

--
-- Ketidakleluasaan untuk tabel `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`menu_id`) REFERENCES `menu` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
