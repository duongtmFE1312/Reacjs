-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th8 28, 2024 lúc 03:23 PM
-- Phiên bản máy phục vụ: 10.4.28-MariaDB
-- Phiên bản PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `db_shoestrend`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `catalog`
--

CREATE TABLE `catalog` (
  `id` int(3) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `des` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `catalog`
--

INSERT INTO `catalog` (`id`, `name`, `img`, `des`) VALUES
(1, 'Adidas', 'adidas1.jpg', 'Dòng giày chạy bộ với công nghệ Boost mang lại cảm giác đàn hồi và êm ái khi chạy.'),
(2, 'Jordan', 'jordan1.jpeg', 'Thiết kế cổ điển với phần upper da lộn và cao su ôm chặt cổ chân.'),
(3, 'Nike', 'nike1.jpg', 'Thiết kế cổ điển với phần upper bằng da hoặc vải, đế cao su dày dặn.'),
(6, 'hes', 'bannerpage.png', NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(3) NOT NULL,
  `fullname` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `total` int(11) NOT NULL,
  `status` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `createAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `user_id` int(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_detail`
--

CREATE TABLE `order_detail` (
  `id` int(3) NOT NULL,
  `order_id` int(3) NOT NULL,
  `product_id` int(3) NOT NULL,
  `quantity` int(3) NOT NULL,
  `price` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product`
--

CREATE TABLE `product` (
  `id` int(3) NOT NULL,
  `id_catalog` int(3) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL DEFAULT 0,
  `price_sale` int(11) NOT NULL DEFAULT 0,
  `sale` tinyint(1) NOT NULL DEFAULT 0,
  `news` tinyint(4) NOT NULL DEFAULT 0,
  `img` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `des` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product`
--

INSERT INTO `product` (`id`, `id_catalog`, `name`, `price`, `price_sale`, `sale`, `news`, `img`, `des`, `created_at`) VALUES
(1, 1, 'ADIDAS CAMPUS 00S', 789000, 489000, 1, 0, 'adidas1.jpg', 'Giày Adidas có nhiều kiểu dáng và mẫu mã khác nhau, từ các dòng sản phẩm cổ điển đến các dòng sản phẩm hiện đại và đột phá. Các thiết kế của Adidas thường mang đậm phong cách thể thao và đôi khi kết hợp với yếu tố thời trang đường phố, tạo ra sự đa dạng và phong phú cho người tiêu dùng.', '2024-07-23 16:19:39'),
(2, 1, 'ADIDAS FORUM 84 LOW', 799000, 599000, 0, 1, 'adidas2.jpeg', 'Giày Adidas có nhiều kiểu dáng và mẫu mã khác nhau, từ các dòng sản phẩm cổ điển đến các dòng sản phẩm hiện đại và đột phá. Các thiết kế của Adidas thường mang đậm phong cách thể thao và đôi khi kết hợp với yếu tố thời trang đường phố, tạo ra sự đa dạng và phong phú cho người tiêu dùng.', '2024-07-23 16:19:39'),
(3, 3, 'NIKE AIR FORCE 1 \'RUGGED ORANGE', 699000, 599000, 0, 1, 'nike1.jpg', ' Giày Nike có rất nhiều kiểu dáng và mẫu mã, từ các dòng sản phẩm chuyên biệt cho các môn thể thao cụ thể đến các dòng sản phẩm phong cách đường phố. Thiết kế của Nike thường mang phong cách hiện đại, đôi khi kết hợp với yếu tố thời trang và cá tính.', '2024-07-23 16:25:13'),
(4, 3, 'NIKE INTERACT RUN', 899000, 699000, 1, 0, 'nike2.jpg', ' Giày Nike có rất nhiều kiểu dáng và mẫu mã, từ các dòng sản phẩm chuyên biệt cho các môn thể thao cụ thể đến các dòng sản phẩm phong cách đường phố. Thiết kế của Nike thường mang phong cách hiện đại, đôi khi kết hợp với yếu tố thời trang và cá tính.', '2024-07-23 16:25:13'),
(5, 2, 'JORDAN 1 MID LIGHT SMOKE GREY', 749000, 649000, 0, 1, 'jordan1.jpeg', 'Giày Jordan thường có thiết kế độc đáo và phong cách cá nhân, thể hiện sự đẳng cấp và cá tính của Michael Jordan. Thiết kế của các đôi giày thường mang lại sự ấn tượng mạnh mẽ với các đường cong sắc nét, đồ họa phức tạp và các chi tiết đặc trưng.', '2024-07-23 16:27:15'),
(6, 2, 'Air Jordan 4 Retro OG Bred', 899000, 699000, 1, 0, 'jordan2.jpeg', 'Giày Jordan thường có thiết kế độc đáo và phong cách cá nhân, thể hiện sự đẳng cấp và cá tính của Michael Jordan. Thiết kế của các đôi giày thường mang lại sự ấn tượng mạnh mẽ với các đường cong sắc nét, đồ họa phức tạp và các chi tiết đặc trưng.', '2024-07-23 16:27:15'),
(7, 3, 'Nike Air Max 90 Surplus ‘Midnight Navy’', 899000, 599000, 1, 0, 'nike7.jpg', ' Giày Nike có rất nhiều kiểu dáng và mẫu mã, từ các dòng sản phẩm chuyên biệt cho các môn thể thao cụ thể đến các dòng sản phẩm phong cách đường phố. Thiết kế của Nike thường mang phong cách hiện đại, đôi khi kết hợp với yếu tố thời trang và cá tính.', '2024-07-23 16:48:14'),
(8, 1, 'Adidas Stan Smith Triple White', 949000, 589000, 1, 0, 'adidas4.jpg', 'Giày Adidas có nhiều kiểu dáng và mẫu mã khác nhau, từ các dòng sản phẩm cổ điển đến các dòng sản phẩm hiện đại và đột phá. Các thiết kế của Adidas thường mang đậm phong cách thể thao và đôi khi kết hợp với yếu tố thời trang đường phố, tạo ra sự đa dạng và phong phú cho người tiêu dùng.', '2024-07-23 16:52:03'),
(28, 2, 'sxxxxxxxxx', 343565, 535456, 0, 0, 'adidas1.jpg', 'sdsd', '0000-00-00 00:00:00'),
(31, 2, 'dsds', 12345, 12345, 0, 0, 'adidas1.jpg', 'dsdsd', '0000-00-00 00:00:00'),
(32, 1, '', 44, 0, 0, 0, 'adidas2.jpeg', NULL, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `pttt`
--

CREATE TABLE `pttt` (
  `id` int(3) NOT NULL,
  `ten` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `des` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `id` int(3) NOT NULL,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `phone` text CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `phone`) VALUES
(1, 'duongke', 'duongke', '0333333333');

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `catalog`
--
ALTER TABLE `catalog`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_catalog` (`id_catalog`);

--
-- Chỉ mục cho bảng `pttt`
--
ALTER TABLE `pttt`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `catalog`
--
ALTER TABLE `catalog`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `product`
--
ALTER TABLE `product`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT cho bảng `pttt`
--
ALTER TABLE `pttt`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `id` int(3) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Các ràng buộc cho bảng `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`id_catalog`) REFERENCES `catalog` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
